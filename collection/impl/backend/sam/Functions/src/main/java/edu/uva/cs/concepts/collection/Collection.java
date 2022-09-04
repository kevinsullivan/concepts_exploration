package edu.uva.cs.concepts.collection;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import edu.uva.cs.concepts.Concept;

import java.util.List;

/**
 * The AWS Lambda Representation of a Collection's state.
 * Set default values here.
 *
 * NB: We really take advantage of the List interface here. All the
 * actions, insert, remove, member are implemented for us by List. If they
 * were not, we would have way more work to do.
 * @param <T>
 */
public class Collection<T> extends Concept {

    @JsonProperty("value")
    List<T> value;

    @JsonCreator
    public Collection(@JsonProperty("value") List<T> value) {
        this.value = value;
    }

    public List<T> getValue() {
        return value;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Collection{");
        sb.append("value=").append(value);
        sb.append('}');
        return sb.toString();
    }
}
