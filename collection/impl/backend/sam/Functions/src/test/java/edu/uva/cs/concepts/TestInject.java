package edu.uva.cs.concepts;

import com.fasterxml.jackson.annotation.JacksonInject;

public class TestInject {

    @JacksonInject("foo")
    private String foo;

    public int value;

    public void printInjected() {
        System.out.println(foo);
    }


}
