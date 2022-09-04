package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.fasterxml.jackson.databind.InjectableValues;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.utils.VariableManager;

/**
 * Abstract Factory to create the pieces needed to implement concepts in AWS lambda
 */
public abstract class LambdaActionFactory<T extends Concept> {

    public abstract Actions<T> createActions(Configuration configuration, Context context);

    public Configuration createConfiguration(APIGatewayV2HTTPEvent event) {
        Configuration configuration = new Configuration();
        configuration.config.putAll(event.getHeaders());
        configuration.config.putAll(event.getQueryStringParameters());
        return configuration;
    }

    public Context createContext(APIGatewayV2HTTPEvent event) {
        Context context = new LambdaContext(event, new VariableManager());
        return context;
    }
    public abstract SerDer createInputSerDer(String type);
    public abstract SerDer createOutputSerDer(String type);

}
