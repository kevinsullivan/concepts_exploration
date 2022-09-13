package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.utils.VariableManager;
import edu.uva.cs.utils.VariableManager;

public class LambdaContext extends Context {

    public APIGatewayProxyRequestEvent event;

    public LambdaContext(APIGatewayProxyRequestEvent event) {
        this(event, new VariableManager());
    }

    public LambdaContext(APIGatewayProxyRequestEvent event, VariableManager variableManager) {
        super(variableManager);
        this.event = event;
    }
}
