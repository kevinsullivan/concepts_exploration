package edu.uva.cs.concepts.collection;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.concepts.collection.gen.model.Collection;
import edu.uva.cs.concepts.utils.*;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.util.HashMap;
import java.util.Map;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

/**
 * Member check of the collection.
 *
 */
public class Member implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, Context context) {
        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if(!EventValidator.isValidEvent(apiGatewayV2HTTPEvent)) {
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
        boolean isMember = S3Helper.exists(client, bucket, key);

        response.setStatusCode(200);
        response.setBody(String.valueOf(isMember));

        Map<String, String> headers = new HashMap<>();
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        return response;
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager != null;
    }
}