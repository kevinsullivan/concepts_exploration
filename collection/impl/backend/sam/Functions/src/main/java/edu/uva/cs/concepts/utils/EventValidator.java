package edu.uva.cs.concepts.utils;

import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import edu.uva.cs.concepts.collection.gen.model.CollectionItemPair;
import software.amazon.awssdk.utils.StringInputStream;

import java.util.Map;

public class EventValidator {

    public static boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        if(event == null) {
            return false;
        }

        String body = event.getBody();
        if(body == null || body.isEmpty()) {
            return false;
        }

        CollectionItemPair pair = JacksonHelper.fromJson(new StringInputStream(event.getBody()), CollectionItemPair.class);
        if(pair == null || pair.getCollection() == null || pair.getItem() == null) {
            return false;
        }

        Map<String, String> qsp = event.getQueryStringParameters();
        if(qsp == null) {
            return false;
        }

        return qsp.containsKey("bucket") && qsp.containsKey("prefix");
    }

    public static boolean isValidInitEvent(APIGatewayV2HTTPEvent event) {
        if(event == null) {
            return false;
        }

        Map<String, String> qsp = event.getQueryStringParameters();
        if(qsp == null) {
            return false;
        }

        return qsp.containsKey("bucket") && qsp.containsKey("prefix");
    }
}