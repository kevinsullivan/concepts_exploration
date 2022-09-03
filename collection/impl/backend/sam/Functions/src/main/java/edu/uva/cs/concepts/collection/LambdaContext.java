package edu.uva.cs.concepts.collection;

import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.utils.VariableManager;

public class LambdaContext implements Context {

    public APIGatewayV2HTTPEvent event;
    public VariableManager variableManager;

    public LambdaContext(APIGatewayV2HTTPEvent event, VariableManager variableManager) {
        this.event = event;
        this.variableManager = variableManager;
    }
}
