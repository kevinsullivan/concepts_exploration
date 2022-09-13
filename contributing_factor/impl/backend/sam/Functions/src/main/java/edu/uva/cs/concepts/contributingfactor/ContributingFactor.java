package edu.uva.cs.concepts.contributingfactor;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import edu.uva.cs.concepts.Concept;

/**
 * Wrapper around the enum.
 */
public class ContributingFactor extends Concept {

    @JsonProperty
    public ContributingFactorEnum contributingFactor;

    @JsonCreator
    public ContributingFactor(@JsonProperty ContributingFactorEnum contributingFactorEnum) {
        this.contributingFactor = contributingFactorEnum;
    }

    @Override
    public String toString() {
        return contributingFactor.name();
    }
}
