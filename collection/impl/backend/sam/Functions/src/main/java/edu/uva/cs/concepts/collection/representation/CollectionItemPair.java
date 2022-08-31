package edu.uva.cs.concepts.collection.representation;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

// openapi cant generate this..
public class CollectionItemPair<T> {

    private Collection<T> collection;
    private T item;

    @JsonCreator
    public CollectionItemPair(@JsonProperty("result") Collection<T> collection, @JsonProperty("item") T item) {
        this.collection = collection;
        this.item = item;
    }

    public Collection<T> getCollection() {
        return collection;
    }

    public T getItem() {
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
