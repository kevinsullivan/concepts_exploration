package edu.uva.cs.concepts.collection.s3;

import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.fasterxml.jackson.databind.InjectableValues;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.collection.CollectionHandler;
import edu.uva.cs.concepts.collection.LambdaContext;
import edu.uva.cs.concepts.collection.SerDer;
import edu.uva.cs.concepts.utils.VariableManager;

/**
 * Insert element into the collection.
 */
public class S3CollectionHandler extends CollectionHandler {

    @Override
    public SerDer createSerDer(InjectableValues injectableValues) {
        return new S3SerDer(injectableValues);
    }

    @Override
    public Configuration createCollectionConfiguration(APIGatewayV2HTTPEvent event) {
        Configuration configuration = new Configuration();
        configuration.config.putAll(event.getHeaders());
        configuration.config.putAll(event.getQueryStringParameters());
        return configuration;
    }

    @Override
    public Context createCollectionContext(APIGatewayV2HTTPEvent event) {
        Context context = new LambdaContext(event, new VariableManager());
        return context;
    }
}