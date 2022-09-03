package edu.uva.cs.concepts.collection;

import edu.uva.cs.concepts.Concept;

/**
 * The AWS Lambda Representation of a Collection's state.
 * Set default values here.
 *
 * NB: We really take advantage of the List interface here. All the
 * actions, insert, remove, member are implemented for us by List. If they
 * were not, we would have way more work to do.
 * @param <T>
 */
public abstract class Collection<T> extends Concept<T> {

    public abstract Collection<T> init();
    public abstract Collection<T> insert(Collection<T> collection, T item);
    public abstract Collection<T> delete(Collection<T> collection, T item);
    public abstract boolean member(Collection<T> collection, T item);
}
