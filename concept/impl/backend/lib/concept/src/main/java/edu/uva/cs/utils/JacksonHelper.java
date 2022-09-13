package edu.uva.cs.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.openapitools.jackson.nullable.JsonNullableModule;
import software.amazon.awssdk.utils.StringInputStream;

import java.io.IOException;
import java.io.InputStream;

public class JacksonHelper {

    public static <T> T fromJson(String value, Class<T> clazz) {
        return fromJson(new StringInputStream(value), clazz);
    }

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

    public static <T> T fromJson(String value, TypeReference<T> valueTypeRef) {
        return fromJson(new StringInputStream(value), valueTypeRef);
    }

    public static <T> T fromJson(InputStream value, TypeReference<T> valueTypeRef) {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JsonNullableModule());
        try {
            return objectMapper.readValue(value, valueTypeRef);
        } catch (IOException e) {
            e.printStackTrace();
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
