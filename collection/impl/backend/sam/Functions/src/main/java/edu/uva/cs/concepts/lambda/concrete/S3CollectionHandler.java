package edu.uva.cs.concepts.lambda.concrete;

import edu.uva.cs.concepts.lambda.CollectionHandler;

/**
 * Insert element into the collection.
 */
public class S3CollectionHandler extends CollectionHandler {
    @Override
    protected <T> LambdaCollectionActionFactory<T> createFactory() {
        return new LambdaS3ActionFactory<>();
    }
}