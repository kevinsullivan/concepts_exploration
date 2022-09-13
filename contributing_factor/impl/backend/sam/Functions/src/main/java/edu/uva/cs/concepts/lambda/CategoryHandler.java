package edu.uva.cs.concepts.lambda;

import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.contributingfactor.Category;
import edu.uva.cs.concepts.contributingfactor.ContributingFactor;
import edu.uva.cs.concepts.contributingfactor.ContributingFactorEnum;
import edu.uva.cs.concepts.contributingfactor.actions.ContributingFactorActions;
import edu.uva.cs.concepts.lambda.concrete.LambdaContributingFactorActionFactory;
import edu.uva.cs.utils.JacksonHelper;

import java.util.HashMap;
import java.util.Map;

/**
 * Contributing Factor to Category Mapper.
 */
public abstract class CategoryHandler implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent> {

    @Override
    public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent apiGatewayProxyRequestEvent, com.amazonaws.services.lambda.runtime.Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Starting CategoryHandler...");

        // TODO: Add back event validation logic.
        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent();
        logger.log("Environment and variable manager are valid.");

        String contributingFactorStr = apiGatewayProxyRequestEvent.getQueryStringParameters().get("contributing-factor");
        ContributingFactor contributingFactor = JacksonHelper.fromJson(contributingFactorStr, ContributingFactor.class);
        if(contributingFactor == null) {
            response.setStatusCode(500);
            return response;
        }

        LambdaContributingFactorActionFactory factory = createFactory();
        Configuration configuration = factory.createConfiguration(apiGatewayProxyRequestEvent);
        Context lambdaContext = factory.createContext(apiGatewayProxyRequestEvent);
        ContributingFactorActions actions = (ContributingFactorActions) factory.createActions(configuration, lambdaContext);

        Category category = actions.category(contributingFactor);
        String serializedOutput = JacksonHelper.toJson(category.category);

        logger.log("Returning the category.");
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

        logger.log("CategoryHandler Finished.");
        return response;
    }

    protected abstract LambdaContributingFactorActionFactory createFactory();
}