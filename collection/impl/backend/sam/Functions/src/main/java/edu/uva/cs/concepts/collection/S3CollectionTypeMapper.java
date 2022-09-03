package edu.uva.cs.concepts.collection;

import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.collection.s3.S3Collection;

// T Is what we map to/from
public class S3CollectionTypeMapper extends TypeMapperGeneral<S3Collection>{

    @Override
    public TypeReference<S3Collection> toTypeReference(String str) {
        if(str.equals("Integer")) {
            return new TypeReference<S3Collection<Integer>>() {};
        } else if(typeName.equals("Boolean")) {
            return new TypeReference<S3Collection<Boolean>>() {};
        } else if(typeName.equals("String")) {
            return new TypeReference<S3Collection<String>>() {};
        }

        throw new RuntimeException("Unknown Type");
    }
}
