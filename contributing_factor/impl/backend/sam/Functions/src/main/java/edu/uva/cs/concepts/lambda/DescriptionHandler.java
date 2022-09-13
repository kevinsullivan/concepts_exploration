package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.contributingfactor.ContributingFactor;
import edu.uva.cs.concepts.contributingfactor.ContributingFactorEnum;
import edu.uva.cs.concepts.contributingfactor.actions.ContributingFactorActions;
import edu.uva.cs.concepts.lambda.concrete.LambdaContributingFactorActionFactory;
import edu.uva.cs.utils.JacksonHelper;

import java.util.HashMap;
import java.util.Map;

/**
 * Contributing Factor to Description Mapper.
 */
public abstract class DescriptionHandler implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    @Override
    public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent apiGatewayProxyRequestEvent, com.amazonaws.services.lambda.runtime.Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Starting DescriptionHandler...");

        // TODO: Add back event validation logic.
        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent();
        logger.log("Environment and variable manager are valid.");

        String contributingFactorStr = apiGatewayProxyRequestEvent.getQueryStringParameters().get("contributing-factor");
        contributingFactorStr = String.format("%c%s%c", '"', contributingFactorStr, '"');
        ContributingFactorEnum cfe = JacksonHelper.fromJson(contributingFactorStr, ContributingFactorEnum.class);
        ContributingFactor contributingFactor = new ContributingFactor(cfe);

        LambdaContributingFactorActionFactory factory = createFactory();
        Configuration configuration = factory.createConfiguration(apiGatewayProxyRequestEvent);
        Context lambdaContext = factory.createContext(apiGatewayProxyRequestEvent);
        ContributingFactorActions actions = (ContributingFactorActions) factory.createActions(configuration, lambdaContext);

        String description = actions.description(contributingFactor);

        logger.log("Returning the description.");
        response.setStatusCode(200);
        response.setBody(description);

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("Content-Length", String.valueOf(description.length()));
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        logger.log("DescriptionHandler Finished.");
        return response;
    }

    protected abstract LambdaContributingFactorActionFactory createFactory();
}