package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.actions.CollectionActions;
import edu.uva.cs.concepts.lambda.concrete.LambdaCollectionActionFactory;
import edu.uva.cs.concepts.utils.JacksonHelper;

import java.util.HashMap;
import java.util.Map;

/**
 * Insert element into the collection.
 */
public abstract class CollectionHandler implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    @Override
    public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent apiGatewayProxyRequestEvent, com.amazonaws.services.lambda.runtime.Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Starting CollectionHandler...");

        // TODO: Add back event validation logic.
        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent();
        logger.log("Environment and variable manager are valid.");

        String type = apiGatewayProxyRequestEvent.getHeaders().get("t");
        LambdaCollectionActionFactory<?> actionFactory = createFactory(type);
        Context collectionContext = actionFactory.createContext(apiGatewayProxyRequestEvent);
        Configuration configuration = actionFactory.createConfiguration(apiGatewayProxyRequestEvent);
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
        String body = apiGatewayProxyRequestEvent.getBody();
        String path = apiGatewayProxyRequestEvent.getPath();
        // TODO: Be smarter about this...
        try {
            if (path.toLowerCase().endsWith("init")) {
                Collection<?> outputCollection = collectionActions.init();
                serializedOutput = JacksonHelper.toJson(outputCollection);
            } else if (path.toLowerCase().endsWith("insert")) {
                CollectionItemPair inputCollectionItemPair = (CollectionItemPair) JacksonHelper.fromJson(body, cipTypeMap.get(type));
                Collection inputCollection = inputCollectionItemPair.getCollection();
                Object inputItem = inputCollectionItemPair.getItem();
                Collection outputCollection = collectionActions.insert(inputCollection, inputItem);
                serializedOutput = JacksonHelper.toJson(outputCollection);
            } else if (path.toLowerCase().endsWith("remove")) {
                CollectionItemPair inputCollectionItemPair = (CollectionItemPair) JacksonHelper.fromJson(body, cipTypeMap.get(type));
                Collection inputCollection = inputCollectionItemPair.getCollection();
                Object inputItem = inputCollectionItemPair.getItem();
                Collection outputCollection = collectionActions.remove(inputCollection, inputItem);
                serializedOutput = JacksonHelper.toJson(outputCollection);
            } else if (path.toLowerCase().endsWith("member")) {
                CollectionItemPair inputCollectionItemPair = (CollectionItemPair) JacksonHelper.fromJson(body, cipTypeMap.get(type));
                Collection inputCollection = inputCollectionItemPair.getCollection();
                Object inputItem = inputCollectionItemPair.getItem();
                Boolean isMember = collectionActions.member(inputCollection, inputItem);
                serializedOutput = JacksonHelper.toJson(isMember);
            } else {
                logger.log(String.format("Unknown action from path: %s", path));
                response.setStatusCode(500);
                return response;
            }
        } catch(Exception e) {
            e.printStackTrace();
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

    /**
     * NB: Ideally I wouldn't need two lookups, but I have not quite worked through
     * the type erasure problems.
     * @param type
     * @return
     */
    private LambdaCollectionActionFactory createFactory(String type) {
        if(type.equalsIgnoreCase("string")) {
            LambdaCollectionActionFactory<String> factory = createFactory();
            return factory;
        } else if(type.equalsIgnoreCase("int")) {
            LambdaCollectionActionFactory<Integer> factory = createFactory();
            return factory;
        } else if(type.equalsIgnoreCase("bool")) {
            LambdaCollectionActionFactory<Boolean> factory = createFactory();
            return factory;
        }

        throw new RuntimeException();
    }

    protected abstract <T> LambdaCollectionActionFactory<T> createFactory();
}