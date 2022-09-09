package edu.uva.cs.concepts.lambda.concrete;

import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.actions.S3Actions;

import java.util.HashMap;
import java.util.Map;

public class LambdaS3ActionFactory<T> extends LambdaCollectionActionFactory<T> {

    @Override
    public Actions<Collection<T>> createActions(Configuration configuration, Context context) {
        return new S3Actions<>(configuration, context);
    }

    @Override
    public Map<String, Map<String, TypeReference>> createTypeMaps() {
        Map<String, Map<String, TypeReference>> typeReferenceMap = new HashMap<>();
        typeReferenceMap.put("collectionitempair", collectionItemPairTypeMap());
        typeReferenceMap.put("collection", collectionTypeMap());
        return typeReferenceMap;
    }

    private Map<String, TypeReference> collectionItemPairTypeMap() {
        Map<String, TypeReference> typeReferenceMap = new HashMap<>();
        typeReferenceMap.put("string", new TypeReference<CollectionItemPair<String, Collection<String>>>(){});
        typeReferenceMap.put("int", new TypeReference<CollectionItemPair<Integer, Collection<Integer>>>(){});
        typeReferenceMap.put("bool", new TypeReference<CollectionItemPair<Boolean, Collection<Boolean>>>(){});

        return typeReferenceMap;
    }

    private Map<String, TypeReference> collectionTypeMap() {
        Map<String, TypeReference> typeReferenceMap = new HashMap<>();
        typeReferenceMap.put("string", new TypeReference<Collection<String>>(){});
        typeReferenceMap.put("int", new TypeReference<Collection<Integer>>(){});
        typeReferenceMap.put("bool", new TypeReference<Collection<Boolean>>(){});

        return typeReferenceMap;
    }
}
