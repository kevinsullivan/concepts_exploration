package edu.uva.cs.concepts.contributingfactor;

import com.fasterxml.jackson.annotation.JsonProperty;

public enum CategoryEnum {

    @JsonProperty("patient")
    Patient,

    @JsonProperty("system")
    System,

    @JsonProperty("team")
    Team;
}

