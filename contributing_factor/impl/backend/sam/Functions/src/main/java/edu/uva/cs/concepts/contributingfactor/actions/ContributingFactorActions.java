package edu.uva.cs.concepts.contributingfactor.actions;

import edu.uva.cs.concepts.Actions;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.contributingfactor.Category;
import edu.uva.cs.concepts.contributingfactor.ContributingFactor;

public abstract class ContributingFactorActions extends Actions<ContributingFactor> {

    public ContributingFactorActions(Configuration configuration, Context context) {
        super(configuration, context);
    }

    public abstract Category category(ContributingFactor contributingFactor);
    public abstract String description(ContributingFactor contributingFactor);
}
