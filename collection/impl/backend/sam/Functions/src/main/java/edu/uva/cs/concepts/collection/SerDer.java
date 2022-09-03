package edu.uva.cs.concepts.collection;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.InjectableValues;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.CollectionItemPair;
import edu.uva.cs.concepts.collection.TypeMapper;
import org.openapitools.jackson.nullable.JsonNullableModule;
import software.amazon.awssdk.utils.StringInputStream;

import java.io.IOException;
import java.io.InputStream;

/**
 * Deserialize Collection payloads into Collection objects with injectable attributes.
 */
public abstract class SerDer {
    ObjectMapper objectMapper;
    TypeMapper typeMapper;

    public SerDer(InjectableValues injectableValues) {
        objectMapper = new ObjectMapper();
        objectMapper.setInjectableValues(injectableValues);
        objectMapper.registerModule(new JsonNullableModule());
        typeMapper = createTypeMapper();
    }

    public <T extends Collection<?>> T toCollection(String value, String type) {
        return toCollection(new StringInputStream(value), (TypeReference<T>)  typeMapper.collectionType(type));
    }

    public <T extends Collection<?>> T toCollection(InputStream value, TypeReference<T> valueTypeRef) {
        try {
            return objectMapper.readValue(value, valueTypeRef);
        } catch (IOException e) {
            System.err.println("failed to deserialize object");
        }
        return null;
    }

    public <T extends CollectionItemPair<?, ?>> T toCollectionItemPair(String value, String type) {
        return toCollectionItemPair(new StringInputStream(value), (TypeReference<T>)  typeMapper.collectionItemPairType(type));
    }

    public <T extends CollectionItemPair<?, ?>> T toCollectionItemPair(InputStream value, TypeReference<T> valueTypeRef) {
        try {
            return objectMapper.readValue(value, valueTypeRef);
        } catch (IOException e) {
            System.err.println("failed to deserialize object");
        }
        return null;
    }

    public String toJson(Object object) {
        try {
            return objectMapper.writeValueAsString(object);
        } catch (IOException e) {
            System.err.println("failed to serialize object");
        }
        return "";
    }

    public abstract TypeMapper createTypeMapper();
}
