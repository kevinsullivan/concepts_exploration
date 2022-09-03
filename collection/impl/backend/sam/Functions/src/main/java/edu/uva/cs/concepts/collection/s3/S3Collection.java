package edu.uva.cs.concepts.collection.s3;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.Concept;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.collection.LambdaContext;
import edu.uva.cs.concepts.utils.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

/**
 * The AWS Lambda Representation of a Collection's state.
 * Set default values here.
 *
 * NB: We really take advantage of the List interface here. All the
 * actions, insert, remove, member are implemented for us by List. If they
 * were not, we would have way more work to do.
 * @param <T>
 */
public class S3Collection<T> extends Collection<T> {
    private Logger logger = LoggerFactory.getLogger(S3Collection.class);

    @JsonProperty("value")
    List<T> value;

    @JsonCreator
    public S3Collection(@JsonProperty("value") List<T> value) {
        this.value = value;
    }

    public List<T> getValue() {
        return value;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Collection{");
        sb.append("value=").append(value);
        sb.append('}');
        return sb.toString();
    }

    @Override
    public Collection<T> init() {
        logger.info("Initialize a proxy collection.");
        String initHash = HashHelper.hashAndEncode(toString());
        if(initHash.isEmpty()) {
            logger.error("Failed to hash the request body (original collection),");
            throw new RuntimeException();
        }
        logger.info("Initialization complete.");

        logger.info("Serialize the proxy.");
        String initSerializedProxy = JacksonHelper.toJson(this);
        if(initSerializedProxy.isEmpty()) {
            logger.info("could not serialize the updated collection.");
            throw new RuntimeException();
        }
        logger.info("Serialization complete.");

        logger.info("Write the collection proxy back to S3.");
        LambdaContext context = (LambdaContext) this.context;
        String bucket = configuration.config.get("bucket");
        String prefix = configuration.config.get("prefix");
        String initKey = prefix.concat(initHash);
        logger.info(String.format("S3 key constructed from proxy is %s", initKey));
        S3Client client = createS3Client(context.variableManager);
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(initKey)
                    .build(), RequestBody.fromString(initSerializedProxy));
        } catch(SdkServiceException exception) {
            logger.info(exception.getMessage());
            throw new RuntimeException();
        }
        logger.info("Writing to S3 complete.");

        return this;
    }

    // Collection is our proxy representation
    public Collection<T> insert(Collection<T> collection, T item) {
        logger.info("Use the request collection proxy to get the underlying S3 object.");
        String originalHash = HashHelper.hashAndEncode(collection.toString());
        if(originalHash.isEmpty()) {
            logger.error("failed to hash the request body (original collection)");
            throw new RuntimeException();
        }

        LambdaContext context = (LambdaContext) this.context;
        String bucket = configuration.config.get("bucket");
        String prefix = configuration.config.get("prefix");
        String originalKey = prefix.concat(originalHash);
        logger.info(String.format("S3 key constructed from proxy is %s", originalKey));
        S3Client client = createS3Client(context.variableManager);
        InputStream inputStream = S3Helper.getAsInputStream(client, bucket, originalKey);
        logger.info("Underlying S3 object got.");

        logger.info("Deserialize into a collection object.");
        S3Collection<T> s3CollectionProxy = JacksonHelper.fromJson(
                inputStream,
                new TypeReference<S3Collection<T>>() { }
        );
        if(s3CollectionProxy == null) {
            logger.info("Could not determine underlying object from the provided proxy");
            throw new RuntimeException();
        }
        logger.info("Deserializing complete.");

        logger.info("Remove the underlying S3 object.");
        try {
            client.deleteObject(builder -> builder
                    .bucket(bucket)
                    .key(originalKey)
                    .build());
        } catch(SdkServiceException exception) {
            logger.info(exception.getMessage());
            throw new RuntimeException();
        }
        logger.info("Removing complete.");

        logger.info("Insert the item into the collection proxy.");
        s3CollectionProxy.getValue().add(item);
        String updatedHash = HashHelper.hashAndEncode(s3CollectionProxy.toString());
        String updatedKey = prefix.concat(updatedHash);
        logger.info(String.format("S3 key constructed from proxy is %s", updatedKey));
        String updatedSerializedProxy = JacksonHelper.toJson(s3CollectionProxy);
        if(updatedSerializedProxy.isEmpty()) {
            logger.info("Could not serialize the updated collection.");
            throw new RuntimeException();
        }
        logger.info("Inserting complete.");

        logger.info("Write the collection proxy back to S3.");
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(updatedKey)
                    .build(), RequestBody.fromString(updatedSerializedProxy));
        } catch(SdkServiceException exception) {
            logger.info(exception.getMessage());
            throw new RuntimeException();
        }
        logger.info("Writing complete.");

        return s3CollectionProxy;
    }

    public boolean member(Collection<T> collection, T item) {
        logger.info("Member Start...");

        logger.info("Use the request collection proxy to get the underlying S3 object.");
        String originalHash = HashHelper.hashAndEncode(collection.toString());
        if (originalHash.isEmpty()) {
            logger.error("failed to hash the request body (original collection)");
            throw new RuntimeException();
        }
        LambdaContext context = (LambdaContext) this.context;
        String bucket = configuration.config.get("bucket");
        String prefix = configuration.config.get("prefix");
        String originalKey = prefix.concat(originalHash);
        logger.info(String.format("S3 key constructed from proxy is %s", originalKey));
        S3Client client = createS3Client(context.variableManager);
        InputStream inputStream = S3Helper.getAsInputStream(client, bucket, originalKey);
        logger.info("Underlying S3 object got.");

        logger.info("Deserialize into a collection object.");
        S3Collection<T> s3CollectionProxy = JacksonHelper.fromJson(
                inputStream,
                new TypeReference<S3Collection<T>>() { }
        );
        if (s3CollectionProxy == null) {
            logger.error("Could not determine underlying object from the provided proxy");
            throw new RuntimeException();
        }
        logger.info("Deserializing complete.");

        logger.info("Perform membership test.");
        boolean isMember = s3CollectionProxy.getValue().contains(item);
        logger.info("Membership test complete.");

        return isMember;

    }

    @Override
    public Collection<T> delete(Collection<T> collection, T item) {
        logger.info("Remove Start...");

        logger.info("Use the request collection proxy to get the underlying S3 object.");
        String originalHash = HashHelper.hashAndEncode(collection.toString());
        if(originalHash.isEmpty()) {
            logger.error("failed to hash the request body (original collection)");
            throw new RuntimeException();
        }

        LambdaContext context = (LambdaContext) this.context;
        Map<String, String> qs = context.event.getQueryStringParameters();
        String bucket = configuration.config.get("bucket");
        String prefix = configuration.config.get("prefix");
        String originalKey = prefix.concat(originalHash);
        logger.info(String.format("S3 key constructed from proxy is %s", originalKey));
        S3Client client = createS3Client(context.variableManager);
        InputStream inputStream = S3Helper.getAsInputStream(client, bucket, originalKey);
        logger.info("Underlying S3 object got.");

        logger.info("Deserialize into a collection object.");
        S3Collection<T> S3CollectionProxy = JacksonHelper.fromJson(
                inputStream,
                new TypeReference<S3Collection<T>>() { }
        );
        if(S3CollectionProxy == null) {
            logger.error("Could not determine underlying object from the provided proxy");
            throw new RuntimeException();
        }
        logger.info("Deserializing complete.");

        logger.info("Remove the underlying S3 object.");
        try {
            client.deleteObject(builder -> builder
                    .bucket(bucket)
                    .key(originalKey)
                    .build());
        } catch(SdkServiceException exception) {
            logger.error(exception.getMessage());
            throw new RuntimeException();
        }
        logger.info("Removing complete.");

        logger.info("Remove the item from the collection proxy.");
        S3CollectionProxy.getValue().remove(item);
        String updatedHash = HashHelper.hashAndEncode(S3CollectionProxy.toString());
        String updatedKey = prefix.concat(updatedHash);
        String updatedSerializedProxy = JacksonHelper.toJson(S3CollectionProxy);
        if(updatedSerializedProxy.isEmpty()) {
            logger.error("could not serialize the updated collection.");
            throw new RuntimeException();
        }
        logger.info("Removing complete.");

        logger.info("Write the collection proxy back to S3.");
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(updatedKey)
                    .build(), RequestBody.fromString(updatedSerializedProxy));
        } catch(SdkServiceException exception) {
            logger.error(exception.getMessage());
            throw new RuntimeException();
        }
        logger.info("Writing complete.");

        return S3CollectionProxy;
    }

    @Override
    protected TypeReference<? extends Concept<T>> tr() {
        return new TypeReference<S3Collection<T>>() {};
    }
}
