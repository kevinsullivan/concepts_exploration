package edu.uva.cs.concepts.lambda.concrete;

import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.contributingfactor.ContributingFactor;
import edu.uva.cs.concepts.contributingfactor.actions.S3Actions;

import java.util.Collections;
import java.util.Map;

public class LambdaS3ActionFactory extends LambdaContributingFactorActionFactory {

    @Override
    public Actions<ContributingFactor> createActions(Configuration configuration, Context context) {
        return new S3Actions(configuration, context);
    }

    @Override
    public Map<String, Map<String, TypeReference>> createTypeMaps() {
        return Collections.emptyMap();
    }
}
