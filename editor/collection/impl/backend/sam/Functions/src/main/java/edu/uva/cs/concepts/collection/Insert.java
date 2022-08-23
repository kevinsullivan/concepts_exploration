package edu.uva.cs.concepts.collection;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.uva.cs.concepts.collection.gen.model.Collection;
import edu.uva.cs.concepts.utils.HashHelper;
import edu.uva.cs.concepts.utils.JacksonHelper;
import edu.uva.cs.concepts.utils.S3Helper;
import edu.uva.cs.concepts.utils.VariableManager;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Object;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

/**
 * Get submissions that match query
 *
 */
public class Insert implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, Context context) {
        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if(!isValidEvent(apiGatewayV2HTTPEvent)) {
            context.getLogger().log("invalid event");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if(!isValidEnvironment(variableManager)) {
            context.getLogger().log("invalid environment");
            response.setStatusCode(500);
            return response;
        }

        String body = apiGatewayV2HTTPEvent.getBody();
        String hash = HashHelper.hashAndEncode(body);
        if(hash.isEmpty()) {
            context.getLogger().log("failed to hash the request body");
            response.setStatusCode(500);
            return response;
        }

        Map<String, String> qs = apiGatewayV2HTTPEvent.getQueryStringParameters();
        String bucket = qs.get("bucket");
        String prefix = qs.get("prefix");
        String key = prefix.concat(hash);

        S3Client client = createS3Client(variableManager);
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .build(), RequestBody.fromString(body));
            response.setStatusCode(200);
        } catch(SdkServiceException exception) {
            context.getLogger().log(exception.getMessage());
            response.setStatusCode(500);
            return response;
        }

        Collection collection = S3Helper.getCollection(client, bucket, prefix);
        String responseBody = JacksonHelper.toJson(collection);
        if(responseBody.isEmpty()) {
            context.getLogger().log("failed to serialize the response body.");
            response.setStatusCode(500);
            return response;
        }

        response.setBody(responseBody);

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("Content-Length", String.valueOf(responseBody.length()));
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        return response;
    }


    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        if(event == null) {
            return false;
        }

        String body = event.getBody();
        if(body == null || body.isEmpty()) {
            return false;
        }

        Map<String, String> qsp = event.getQueryStringParameters();
        if(qsp == null) {
            return false;
        }

        return qsp.containsKey("bucket") && qsp.containsKey("prefix");
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager != null;
    }
}