package edu.uva.cs.concepts.collection.s3;

import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.TypeMapper;

/**
 * We need to be able to deserialize all of the models coming in.
 *
 * I need a way to identify the T coming in, and a typed model to
 * deserialize it into.
 *
 * NB: There has to be a better way.
 * Type param with type param?
 */
public class S3TypeMapper implements TypeMapper {
    private static S3TypeMapper instance;

    private S3TypeMapper() {}

    public static TypeMapper getInstance() {
        if(instance == null) {
            instance = new S3TypeMapper();
        }
        return instance;
    }

    @Override
    public TypeReference collectionItemPairType(String typeName) {
        if(typeName.equals("Integer")) {
            return new TypeReference<CollectionItemPair<Integer, S3Collection<Integer>>>() {};
        } else if(typeName.equals("Boolean")) {
            return new TypeReference<CollectionItemPair<Boolean, S3Collection<Boolean>>>() {};
        } else if(typeName.equals("String")) {
            return new TypeReference<CollectionItemPair<String, S3Collection<String>>>() {};
        }

        throw new RuntimeException("Unknown Type");
    }

    public TypeReference collectionType(String typeName) {
        if(typeName.equals("Integer")) {
            return new TypeReference<S3Collection<Integer>>() {};
        } else if(typeName.equals("Boolean")) {
            return new TypeReference<S3Collection<Boolean>>() {};
        } else if(typeName.equals("String")) {
            return new TypeReference<S3Collection<String>>() {};
        }

        throw new RuntimeException("Unknown Type");
    }
}
