package edu.uva.cs.concepts.contributingfactor;

import edu.uva.cs.concepts.Concept;

/**
 * Wrapper around the enum.
 */
public class Category extends Concept {
    public CategoryEnum category;

    public Category(CategoryEnum category) {
        this.category = category;
    }

}
