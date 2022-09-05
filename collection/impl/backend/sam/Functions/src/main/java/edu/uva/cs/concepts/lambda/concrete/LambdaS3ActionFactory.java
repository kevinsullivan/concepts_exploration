package edu.uva.cs.concepts.lambda.concrete;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.InjectableValues;
import edu.uva.cs.concepts.*;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.actions.S3Actions;
import edu.uva.cs.concepts.lambda.LambdaActionFactory;

import java.util.HashMap;
import java.util.Map;

// appropriat factory creatd ar runtime
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
        typeReferenceMap.put("integer", new TypeReference<CollectionItemPair<Integer, Collection<Integer>>>(){});
        typeReferenceMap.put("boolean", new TypeReference<CollectionItemPair<Boolean, Collection<Boolean>>>(){});

        return typeReferenceMap;
    }

    private Map<String, TypeReference> collectionTypeMap() {
        Map<String, TypeReference> typeReferenceMap = new HashMap<>();
        typeReferenceMap.put("string", new TypeReference<Collection<String>>(){});
        typeReferenceMap.put("integer", new TypeReference<Collection<Integer>>(){});
        typeReferenceMap.put("boolean", new TypeReference<Collection<Boolean>>(){});

        return typeReferenceMap;
    }
}
