package edu.uva.cs.concepts.collection.representation;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * We need to be able to deserialize all of the models coming in.
 *
 * I need a way to identify the T coming in, and a typed model to
 * deserialize it into.
 *
 * NB: There has to be a better way.
 */
public class StateMapper {
    public static TypeReference inputFromHeader(String stateName) {
        if(stateName.equals("CollectionItemPair<Integer>")) {
            return new TypeReference<CollectionItemPair<Integer>>() {};
        } else if(stateName.equals("CollectionItemPair<Boolean>")) {
            return new TypeReference<CollectionItemPair<Boolean>>() {};
        } else if(stateName.equals("CollectionItemPair<String>")) {
            return new TypeReference<CollectionItemPair<String>>() {
            };
        }

        throw new RuntimeException("Unknown Model");
    }

    public static TypeReference outputFromHeader(String stateName) {
        if(stateName.equals("CollectionItemPair<Integer>")) {
            return new TypeReference<Collection<Integer>>() {};
        } else if(stateName.equals("CollectionItemPair<Boolean>")) {
            return new TypeReference<Collection<Boolean>>() {};
        } else if(stateName.equals("CollectionItemPair<String>")) {
            return new TypeReference<Collection<String>>() {
            };
        }


        throw new RuntimeException("Unknown Model");
    }

}
