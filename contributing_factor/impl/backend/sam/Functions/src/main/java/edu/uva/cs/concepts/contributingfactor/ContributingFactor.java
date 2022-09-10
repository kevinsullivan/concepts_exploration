package edu.uva.cs.concepts.contributingfactor;

import edu.uva.cs.concepts.Concept;

/**
 * Wrapper around the enum.
 */
public class ContributingFactor extends Concept {
    public ContributingFactorEnum contributingFactor;

    public ContributingFactor(ContributingFactorEnum contributingFactorEnum) {
        this.contributingFactor = contributingFactorEnum;
    }
}
