package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.Actions;
import edu.uva.cs.concepts.Concept;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.utils.VariableManager;

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
        if(event.getHeaders() != null) {
            configuration.config.putAll(event.getHeaders());
        }
        configuration.config.putAll(event.getQueryStringParameters());
        return configuration;
    }

    public Context createContext(APIGatewayProxyRequestEvent event) {
        Context context = new LambdaContext(event, new VariableManager());
        return context;
    }
    public abstract Map<String, Map<String, TypeReference>> createTypeMaps();


}
