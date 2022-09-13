package edu.uva.cs.concepts;

public abstract class Actions<T extends Concept> {
    protected Configuration configuration;
    protected Context context;

    public Actions(Configuration configuration, Context context) {
        this.configuration = configuration;
        this.context = context;
    }
}
