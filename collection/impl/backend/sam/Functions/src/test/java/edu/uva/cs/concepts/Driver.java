package edu.uva.cs.concepts;

import com.fasterxml.jackson.databind.InjectableValues;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

public class Driver {

    public static void main(String[] args) throws IOException {
        InjectableValues iv = new InjectableValues.Std();
        ((InjectableValues.Std) iv).addValue("foo", "foo");
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setInjectableValues(iv);

        TestInject inject = objectMapper.readValue("{\"value\": 5}", TestInject.class);
        inject.printInjected();


    }
}
