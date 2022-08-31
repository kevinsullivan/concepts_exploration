package edu.uva.cs.concepts.collection;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.concepts.collection.representation.Collection;
import edu.uva.cs.concepts.utils.*;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

/**
 * Insert element into the collection.
 */
public class Init implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Start Init...");

        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if(!EventValidator.isValidInitEvent(apiGatewayV2HTTPEvent)) {
            logger.log("Invalid init event.");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if(!isValidEnvironment(variableManager)) {
            logger.log("Invalid environment");
            response.setStatusCode(500);
            return response;
        }
        logger.log("Environment and variable manager are valid.");

        logger.log("Initialize a proxy collection.");
        Collection initCollection = new Collection(new ArrayList());
        System.out.println("in lambda");
        System.out.println(initCollection.toString());
        System.out.println("----");
        String initHash = HashHelper.hashAndEncode(initCollection.toString());
        if(initHash.isEmpty()) {
            logger.log("Failed to hash the request body (original collection),");
            response.setStatusCode(500);
            return response;
        }
        logger.log("Initialization complete.");

        logger.log("Serialize the proxy.");
        String initSerializedProxy = JacksonHelper.toJson(initCollection);
        if(initSerializedProxy.isEmpty()) {
            logger.log("could not serialize the updated collection.");
            response.setStatusCode(500);
            return response;
        }
        logger.log("Serialization complete.");

        logger.log("Write the collection proxy back to S3.");
        Map<String, String> qs = apiGatewayV2HTTPEvent.getQueryStringParameters();
        String bucket = qs.get("bucket");
        String prefix = qs.get("prefix");
        String initKey = prefix.concat(initHash);
        logger.log(String.format("S3 key constructed from proxy is %s", initKey));
        S3Client client = createS3Client(variableManager);
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(initKey)
                    .build(), RequestBody.fromString(initSerializedProxy));
            response.setStatusCode(200);
        } catch(SdkServiceException exception) {
            logger.log(exception.getMessage());
            response.setStatusCode(500);
            return response;
        }
        logger.log("Writing to S3 complete.");

        logger.log("Returning the updated, serialized collection.");
        response.setStatusCode(200);
        response.setBody(initSerializedProxy);

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("Content-Length", String.valueOf(initSerializedProxy.length()));
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        logger.log("End Init...");
        return response;
    }
    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager != null;
    }
}