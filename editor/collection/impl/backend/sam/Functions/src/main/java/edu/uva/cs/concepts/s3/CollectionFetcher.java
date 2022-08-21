package edu.uva.cs.concepts.s3;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.uva.cs.concepts.collection.gen.model.Collection;
import edu.uva.cs.concepts.utils.S3Helper;
import edu.uva.cs.concepts.utils.VariableManager;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.S3Object;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

/**
 * Get submissions that match query
 *
 */
public class CollectionFetcher implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

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

        String bucket = variableManager.get("bucket");
        Map<String, String> qs = apiGatewayV2HTTPEvent.getQueryStringParameters();
        String prefix = qs.get("folder");


        S3Client client = createS3Client(variableManager);
        ListObjectsV2Request.Builder builder = ListObjectsV2Request.builder()
                .bucket(bucket)
                .prefix(prefix);
        ListObjectsV2Request listObjectsV2Request = builder.build();

        List<Object> data = client.listObjectsV2(listObjectsV2Request).contents().stream()
                .map(S3Object::key)
                .map(key -> S3Helper.getObjectAsObject(client, bucket, key))
                .collect(Collectors.toList());


        Collection collection = new Collection();
        collection.setValue(data);
        response.setBody(toJson(collection));
        response.setStatusCode(200);

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("Content-Length", String.valueOf(response.getBody().length()));
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        return response;
    }

    private String toJson(Object value) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return "";
    }

    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        if(event == null) {
            return false;
        }

        Map<String, String> qsp = event.getQueryStringParameters();
        if(qsp == null) {
            return false;
        }

        return qsp.containsKey("folder");
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("bucket") && !variableManager.getOrDefault("bucket", "").isEmpty();
    }
}