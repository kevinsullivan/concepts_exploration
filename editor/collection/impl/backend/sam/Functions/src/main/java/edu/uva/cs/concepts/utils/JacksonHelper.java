package edu.uva.cs.concepts.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.openapitools.jackson.nullable.JsonNullableModule;

import java.io.IOException;
import java.io.InputStream;

public class JacksonHelper {

    public static <T> T fromJson(InputStream value, Class<T> clazz) {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JsonNullableModule());
        try {
            return objectMapper.readValue(value, clazz);
        } catch (IOException e) {
            System.err.println("failed to deserialize object");
        }
        return null;
    }

    public static String toJson(Object object) {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JsonNullableModule());
        try {
            return objectMapper.writeValueAsString(object);
        } catch (IOException e) {
            System.err.println("failed to serialize object");
        }
        return "";
    }
}
