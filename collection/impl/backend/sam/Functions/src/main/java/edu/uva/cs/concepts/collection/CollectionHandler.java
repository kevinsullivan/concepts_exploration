package edu.uva.cs.concepts.collection;

import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.databind.InjectableValues;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.utils.EventValidator;
import edu.uva.cs.concepts.utils.VariableManager;

import java.util.HashMap;
import java.util.Map;

/**
 * Insert element into the collection.
 */
public abstract class CollectionHandler implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, com.amazonaws.services.lambda.runtime.Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Starting CollectionHandler...");

        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if(!EventValidator.isValidInitEvent(apiGatewayV2HTTPEvent) || !EventValidator.isValidEvent(apiGatewayV2HTTPEvent)) {
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


        Context collectionContext = createCollectionContext(apiGatewayV2HTTPEvent);
        Configuration configuration = createCollectionConfiguration(apiGatewayV2HTTPEvent);
        InjectableValues.Std iv = new InjectableValues.Std();
        iv.addValue("collectionContext", collectionContext);
        iv.addValue("collectionConfiguration", configuration);
        SerDer serDer = createSerDer(iv);

        String serializedOutput;
        String body = apiGatewayV2HTTPEvent.getBody();
        String type = apiGatewayV2HTTPEvent.getHeaders().get("type");
        String path = apiGatewayV2HTTPEvent.getRawPath();
        if(path.equalsIgnoreCase("init")) {
            Collection inputCollection = serDer.toCollection(body, type);
            Collection outputCollection = inputCollection.init();
            serializedOutput = serDer.toJson(outputCollection);
        } else if(path.equalsIgnoreCase("insert")) {
            CollectionItemPair inputCollectionItemPair = serDer.toCollectionItemPair(body, type);
            Collection inputCollection = inputCollectionItemPair.getCollection();
            Object inputItem = inputCollectionItemPair.getItem();
            Collection outputCollection = inputCollection.insert(inputCollection, inputItem);
            serializedOutput = serDer.toJson(outputCollection);
        } else if(path.equalsIgnoreCase("delete")) {
            CollectionItemPair inputCollectionItemPair = serDer.toCollectionItemPair(body, type);
            Collection inputCollection = inputCollectionItemPair.getCollection();
            Object inputItem = inputCollectionItemPair.getItem();
            Collection outputCollection = inputCollection.delete(inputCollection, inputItem);
            serializedOutput = serDer.toJson(outputCollection);
        } else if(path.equalsIgnoreCase("member")) {
            CollectionItemPair inputCollectionItemPair = serDer.toCollectionItemPair(body, type);
            Collection inputCollection = inputCollectionItemPair.getCollection();
            Object inputItem = inputCollectionItemPair.getItem();
            boolean isMember = inputCollection.member(inputCollection, inputItem);
            serializedOutput = serDer.toJson(isMember);
        } else {
            logger.log("Invalid environment");
            response.setStatusCode(500);
            return response;
        }

        logger.log("Returning the updated, serialized collection.");
        response.setStatusCode(200);
        response.setBody(serializedOutput);

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("Content-Length", String.valueOf(serializedOutput.length()));
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        logger.log("CollectionHandler Finished.");
        return response;
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager != null;
    }

    public abstract Configuration createCollectionConfiguration(APIGatewayV2HTTPEvent event);
    public abstract Context createCollectionContext(APIGatewayV2HTTPEvent event);
    public abstract SerDer createSerDer(InjectableValues injectableValues);
}