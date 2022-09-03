package edu.uva.cs.concepts.collection;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * We need to be able to deserialize all of the models coming in.
 *
 * I need a way to identify the T coming in, and a typed model to
 * deserialize it into.
 *
 * NB: There has to be a better way.
 * Type param with type param?
 */
public interface TypeMapper {
    TypeReference collectionItemPairType(String str);

    TypeReference collectionType(String stateName);
}
