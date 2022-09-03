package edu.uva.cs.concepts.collection.s3;

import com.fasterxml.jackson.databind.InjectableValues;
import edu.uva.cs.concepts.collection.TypeMapper;
import edu.uva.cs.concepts.collection.SerDer;

/**
 * Deserialize Collection payloads into Collection objects with injectable attributes.
 */
public class S3SerDer extends SerDer {
    public S3SerDer(InjectableValues injectableValues) {
        super(injectableValues);
    }

    public TypeMapper createTypeMapper() {
        return S3TypeMapper.getInstance();
    }
}
