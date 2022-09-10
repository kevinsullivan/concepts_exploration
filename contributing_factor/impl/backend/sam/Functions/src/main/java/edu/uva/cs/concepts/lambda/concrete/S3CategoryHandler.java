package edu.uva.cs.concepts.lambda.concrete;

import edu.uva.cs.concepts.lambda.CategoryHandler;

public class S3CategoryHandler extends CategoryHandler {
    @Override
    protected LambdaContributingFactorActionFactory createFactory() {
        return new LambdaS3ActionFactory();
    }
}