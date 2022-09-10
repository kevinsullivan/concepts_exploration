package edu.uva.cs.concepts.lambda.concrete;

import edu.uva.cs.concepts.lambda.DescriptionHandler;

public class S3DescriptionHandler extends DescriptionHandler {
    @Override
    protected LambdaContributingFactorActionFactory createFactory() {
        return new LambdaS3ActionFactory();
    }
}