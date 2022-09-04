package edu.uva.cs.concepts;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.InjectableValues;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.openapitools.jackson.nullable.JsonNullableModule;
import software.amazon.awssdk.utils.StringInputStream;

import java.io.IOException;
import java.io.InputStream;

/**
 * Deserialize Collection payloads into Collection objects with injectable attributes.
 */
public class SerDer<T extends Concept> {
    ObjectMapper objectMapper;

    public SerDer(InjectableValues injectableValues) {
        this();
        objectMapper.setInjectableValues(injectableValues);
    }

    public SerDer() {
        objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JsonNullableModule());
    }

    public T deserialize(String value) {
        try {
            return objectMapper.readValue(value, new TypeReference<T>() { });
        } catch (IOException e) {
            System.err.println("failed to deserialize object");
        }
        return null;
    }

    public T deserialize(InputStream value) {
        try {
            return objectMapper.readValue(value, new TypeReference<T>() { });
        } catch (IOException e) {
            System.err.println("failed to deserialize object");
        }
        return null;
    }

    public String serialize(Object value) {
        try {
            return objectMapper.writeValueAsString(value);
        } catch (IOException e) {
            System.err.println("failed to deserialize object");
        }
        return null;
    }
}
