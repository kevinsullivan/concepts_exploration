package edu.uva.cs.concepts.collection.actions;

import edu.uva.cs.concepts.Actions;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.collection.Collection;

public abstract class CollectionActions<T> extends Actions<Collection<T>> {

    public CollectionActions(Configuration configuration, Context context) {
        super(configuration, context);
    }

    public abstract Collection<T> init();
    public abstract Collection<T> insert(Collection<T> collection, T item);
    public abstract Collection<T> delete(Collection<T> collection, T item);
    public abstract boolean member(Collection<T> collection, T item);
}
