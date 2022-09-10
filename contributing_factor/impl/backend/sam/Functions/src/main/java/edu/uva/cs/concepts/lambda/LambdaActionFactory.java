package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.utils.VariableManager;

import java.util.Map;

/**
 * Abstract Factory to create the pieces needed to implement concepts in AWS lambda.
 *
 * The appropriate factory will be created at runtime.
 */
public abstract class LambdaActionFactory<T extends Concept> {

    public abstract Actions<T> createActions(Configuration configuration, Context context);

    public Configuration createConfiguration(APIGatewayProxyRequestEvent event) {
        Configuration configuration = new Configuration();
        configuration.config.putAll(event.getQueryStringParameters());
        return configuration;
    }

    public Context createContext(APIGatewayProxyRequestEvent event) {
        Context context = new LambdaContext(event, new VariableManager());
        return context;
    }
    public abstract Map<String, Map<String, TypeReference>> createTypeMaps();


}
