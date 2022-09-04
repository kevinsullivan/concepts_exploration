package edu.uva.cs.concepts;

import edu.uva.cs.concepts.utils.VariableManager;

/**
 * Information about the runtime environment that collection implementation might need
 * to process properly.
 */
public class Context {
    protected VariableManager variableManager;

    public Context() {
        this(new VariableManager());
    }

    public Context(VariableManager variableManager) {
        this.variableManager = variableManager;
    }

    public VariableManager getVariableManager() {
        return variableManager;
    }

    public void setVariableManager(VariableManager variableManager) {
        this.variableManager = variableManager;
    }
}
