package edu.uva.cs.concepts.collection;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import edu.uva.cs.concepts.Concept;

public class CollectionItemPair<E, T extends Collection<E>> extends Concept {
    private T collection;
    private E item;

    @JsonCreator
    public CollectionItemPair(@JsonProperty("result") T collection, @JsonProperty("item") E item) {
        this.collection = collection;
        this.item = item;
    }

    public T getCollection() {
        return collection;
    }

    public E getItem() {
        return item;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("CollectionItemPair{");
        sb.append("collection=").append(collection);
        sb.append(", item=").append(item);
        sb.append('}');
        return sb.toString();
    }
}
