package edu.uva.cs.concepts.lambda.concrete;

import com.fasterxml.jackson.databind.InjectableValues;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.actions.S3Actions;
import edu.uva.cs.concepts.lambda.LambdaActionFactory;

// appropriat factory creatd ar runtime
public class LambdaS3ActionFactory<T> extends LambdaCollectionActionFactory<T> {

    @Override
    public Actions<Collection<T>> createActions(Configuration configuration, Context context) {
        return new S3Actions<>(configuration, context);
    }

    @Override
    public SerDer createInputSerDer(String type) {
        return new SerDer<CollectionItemPair<T, Collection<T>>>();
    }

    @Override
    public SerDer createOutputSerDer(String type) {
        return new CollectionSerDer<T>();
    }
}
