package edu.uva.cs.concepts;

import com.fasterxml.jackson.annotation.JacksonInject;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * The AWS Lambda Representation of a Collection's state.
 * Set default values here.
 *
 * NB: We really take advantage of the List interface here. All the
 * actions, insert, remove, member are implemented for us by List. If they
 * were not, we would have way more work to do.
 * @param <T>
 */
public abstract class Concept<T> {
    @JacksonInject("context")
    protected Context context;

    @JacksonInject("configuration")
    protected Configuration configuration;

    protected abstract TypeReference<? extends Concept<T>> tr();
}
