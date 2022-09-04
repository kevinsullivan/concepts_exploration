package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.utils.VariableManager;

public class LambdaContext extends Context {

    public APIGatewayV2HTTPEvent event;

    public LambdaContext(APIGatewayV2HTTPEvent event) {
        this(event, new VariableManager());
    }

    public LambdaContext(APIGatewayV2HTTPEvent event, VariableManager variableManager) {
        super(variableManager);
        this.event = event;
    }
}
