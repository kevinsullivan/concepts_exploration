package edu.uva.cs.concepts;

import java.util.HashMap;
import java.util.Map;

/**
 * Configurations for the Collection implementation.
 *
 * Wrapped in a class in case there is every anything more than k/v pairs to
 * add.
 */
public class Configuration {
    public Map<String, String> config;

    public Configuration() {
        config = new HashMap<>();
    }
}
