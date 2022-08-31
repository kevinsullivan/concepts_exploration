package edu.uva.cs.concepts.collection;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.concepts.collection.representation.Collection;
import edu.uva.cs.concepts.collection.representation.CollectionItemPair;
import edu.uva.cs.concepts.collection.representation.StateMapper;
import edu.uva.cs.concepts.utils.*;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.utils.StringInputStream;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

/**
 * Insert element into the collection.
 */
public class Insert implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Start Insert...");

        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if(!EventValidator.isValidEvent(apiGatewayV2HTTPEvent)) {
            logger.log("Invalid event.");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if(!isValidEnvironment(variableManager)) {
            logger.log("Invalid environment.");
            response.setStatusCode(500);
            return response;
        }
        logger.log("Environment and variable manager are valid.");

        logger.log("Reconstruct our proxies from the serialized form.");
        String body = apiGatewayV2HTTPEvent.getBody();
        String model = apiGatewayV2HTTPEvent.getHeaders().get("Model");

        CollectionItemPair pair = (CollectionItemPair) JacksonHelper.fromJson(
                new StringInputStream(body),
                StateMapper.inputFromHeader(model)
        );
        Collection reqCollectionProxy = pair.getCollection();
        Object reqItemProxy = pair.getItem();
        logger.log("Reconstructing complete.");

        logger.log("Use the request collection proxy to get the underlying S3 object.");
        String originalHash = HashHelper.hashAndEncode(reqCollectionProxy.toString());
        if(originalHash.isEmpty()) {
            logger.log("failed to hash the request body (original collection)");
            response.setStatusCode(500);
            return response;
        }
        Map<String, String> qs = apiGatewayV2HTTPEvent.getQueryStringParameters();
        String bucket = qs.get("bucket");
        String prefix = qs.get("prefix");
        String originalKey = prefix.concat(originalHash);
        logger.log(String.format("S3 key constructed from proxy is %s", originalKey));
        S3Client client = createS3Client(variableManager);
        InputStream inputStream = S3Helper.getAsInputStream(client, bucket, originalKey);
        logger.log("Underlying S3 object got.");

        logger.log("Deserialize into a collection object.");
        Collection storedCollectionProxy = (Collection) JacksonHelper.fromJson(
                inputStream,
                StateMapper.outputFromHeader(model)
        );
        if(storedCollectionProxy == null) {
            logger.log("Could not determine underlying object from the provided proxy");
            response.setStatusCode(500);
            return response;
        }
        logger.log("Deserializing complete.");

        logger.log("Remove the underlying S3 object.");
        try {
            client.deleteObject(builder -> builder
                    .bucket(bucket)
                    .key(originalKey)
                    .build());
        } catch(SdkServiceException exception) {
            logger.log(exception.getMessage());
            response.setStatusCode(500);
            return response;
        }
        logger.log("Removing complete.");

        logger.log("Insert the item into the collection proxy.");
        storedCollectionProxy.getValue().add(reqItemProxy);
        String updatedHash = HashHelper.hashAndEncode(storedCollectionProxy.toString());
        String updatedKey = prefix.concat(updatedHash);
        logger.log(String.format("S3 key constructed from proxy is %s", updatedKey));
        String updatedSerializedProxy = JacksonHelper.toJson(storedCollectionProxy);
        if(updatedSerializedProxy.isEmpty()) {
            logger.log("Could not serialize the updated collection.");
            response.setStatusCode(500);
            return response;
        }
        logger.log("Inserting complete.");

        logger.log("Write the collection proxy back to S3.");
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(updatedKey)
                    .build(), RequestBody.fromString(updatedSerializedProxy));
            response.setStatusCode(200);
        } catch(SdkServiceException exception) {
            logger.log(exception.getMessage());
            response.setStatusCode(500);
            return response;
        }
        logger.log("Writing complete.");

        logger.log("Return the updated, serialized collection.");
        response.setStatusCode(200);
        response.setBody(updatedSerializedProxy);

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("Content-Length", String.valueOf(updatedSerializedProxy.length()));
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        logger.log("End Insert...");
        return response;
    }
    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager != null;
    }
}