package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.actions.CollectionActions;
import edu.uva.cs.concepts.lambda.concrete.LambdaCollectionActionFactory;
import edu.uva.cs.concepts.utils.EventValidator;
import edu.uva.cs.concepts.utils.JacksonHelper;
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
        if(!EventValidator.isValidInitEvent(apiGatewayV2HTTPEvent) && !EventValidator.isValidEvent(apiGatewayV2HTTPEvent)) {
            logger.log("Invalid init event.");
            response.setStatusCode(500);
            return response;
        }
        logger.log("Environment and variable manager are valid.");

        String type = apiGatewayV2HTTPEvent.getHeaders().get("type");
        LambdaCollectionActionFactory<?> actionFactory = createFactory(type);
        Context collectionContext = actionFactory.createContext(apiGatewayV2HTTPEvent);
        Configuration configuration = actionFactory.createConfiguration(apiGatewayV2HTTPEvent);
        CollectionActions collectionActions = (CollectionActions) actionFactory.createActions(configuration, collectionContext);
        Map<String, Map<String, TypeReference>> typeMap = actionFactory.createTypeMaps();
        Map<String, TypeReference> cipTypeMap = typeMap.getOrDefault("collectionitempair", java.util.Collections.emptyMap());
        Map<String, TypeReference> cTypeMap = typeMap.getOrDefault("collection", java.util.Collections.emptyMap());
        if(cipTypeMap.isEmpty() || cTypeMap.isEmpty()) {
            logger.log("Missing required type maps");
            response.setStatusCode(500);
            return response;
        }

        String serializedOutput;
        String body = apiGatewayV2HTTPEvent.getBody();
        String path = apiGatewayV2HTTPEvent.getRawPath();
        if(path.equalsIgnoreCase("init")) {
            Collection<?> outputCollection = collectionActions.init();
            serializedOutput = JacksonHelper.toJson(outputCollection);
        } else if(path.equalsIgnoreCase("insert")) {
            CollectionItemPair inputCollectionItemPair = (CollectionItemPair) JacksonHelper.fromJson(body, cipTypeMap.get(type));
            Collection inputCollection = inputCollectionItemPair.getCollection();
            Object inputItem = inputCollectionItemPair.getItem();
            Collection outputCollection = null;
            try {
                outputCollection = collectionActions.insert(inputCollection, inputItem);
            } catch(RuntimeException e) {
                logger.log("failed to run action");
                response.setStatusCode(500);
                return response;
            }
            serializedOutput = JacksonHelper.toJson(outputCollection);
        } else if(path.equalsIgnoreCase("delete")) {
            CollectionItemPair inputCollectionItemPair = (CollectionItemPair) JacksonHelper.fromJson(body, cipTypeMap.get(type));
            Collection inputCollection = inputCollectionItemPair.getCollection();
            Object inputItem = inputCollectionItemPair.getItem();
            Collection outputCollection = null;
            try {
                outputCollection = collectionActions.delete(inputCollection, inputItem);
            } catch(RuntimeException e) {
                logger.log("failed to run action");
                response.setStatusCode(500);
                return response;
            }
            serializedOutput = JacksonHelper.toJson(outputCollection);
        } else if(path.equalsIgnoreCase("member")) {
            CollectionItemPair inputCollectionItemPair = (CollectionItemPair) JacksonHelper.fromJson(body, cipTypeMap.get(type));
            Collection inputCollection = inputCollectionItemPair.getCollection();
            Object inputItem = inputCollectionItemPair.getItem();
            Boolean isMember = null;
            try {
                isMember = collectionActions.member(inputCollection, inputItem);
            } catch(RuntimeException e) {
                logger.log("failed to run action");
                response.setStatusCode(500);
                return response;
            }
            serializedOutput = JacksonHelper.toJson(isMember);
        } else {
            logger.log(String.format("Unknown action from path: %s", path));
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

    private LambdaCollectionActionFactory createFactory(String type) {
        if(type.equalsIgnoreCase("string")) {
            LambdaCollectionActionFactory<String> factory = createFactory();
            return factory;
        } else if(type.equalsIgnoreCase("integer")) {
            LambdaCollectionActionFactory<Integer> factory = createFactory();
            return factory;
        } else if(type.equalsIgnoreCase("boolean")) {
            LambdaCollectionActionFactory<Boolean> factory = createFactory();
            return factory;
        }

        throw new RuntimeException();
    }

    protected abstract <T> LambdaCollectionActionFactory<T> createFactory();
}