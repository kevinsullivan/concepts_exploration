package edu.uva.cs.concepts.contributingfactor;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Wrapper around the enum.
 */
public class Category {
    public CategoryEnum category;

    @JsonCreator
    public Category(@JsonProperty CategoryEnum category) {
        this.category = category;
    }

}
