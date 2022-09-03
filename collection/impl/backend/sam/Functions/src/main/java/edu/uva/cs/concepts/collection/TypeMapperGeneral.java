package edu.uva.cs.concepts.collection;

import com.fasterxml.jackson.core.type.TypeReference;

// T Is what we map to/from
public abstract class TypeMapperGeneral<T> {
    public abstract TypeReference<T> toTypeReference(String str);
}
