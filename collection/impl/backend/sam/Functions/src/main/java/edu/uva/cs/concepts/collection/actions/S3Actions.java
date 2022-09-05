package edu.uva.cs.concepts.collection.actions;

import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.collection.Collection;
import edu.uva.cs.concepts.lambda.LambdaContext;
import edu.uva.cs.concepts.utils.HashHelper;
import edu.uva.cs.concepts.utils.JacksonHelper;
import edu.uva.cs.concepts.utils.S3Helper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.InputStream;
import java.util.ArrayList;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

public class S3Actions<T> extends CollectionActions<T> {
    private Logger logger = LoggerFactory.getLogger(S3Actions.class);

    public S3Actions(Configuration configuration, Context context) {
        super(configuration, context);
    }

    @Override
    public Collection<T> init() {
        logger.info("Initialize a proxy collection.");
        Collection<T> collection = new Collection<>(new ArrayList<>());
        logger.info("Initialization complete.");

        logger.info("Serialize the proxy.");
        String initHash = HashHelper.hashAndEncode(collection.toString());
        if(initHash.isEmpty()) {
            logger.error("Failed to hash the request body (original collection),");
            throw new RuntimeException();
        }
        String initSerializedProxy = JacksonHelper.toJson(collection);
        if(initSerializedProxy.isEmpty()) {
            logger.info("could not serialize the updated collection.");
            throw new RuntimeException();
        }
        logger.info("Serialization complete.");

        logger.info("Write the collection proxy back to S3.");
        String bucket = configuration.config.get("bucket");
        String prefix = configuration.config.get("prefix");
        String initKey = prefix.concat(initHash);
        logger.info(String.format("S3 key constructed from proxy is %s", initKey));
        S3Client client = createS3Client(context.getVariableManager());
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

        return collection;
    }

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
        S3Client client = createS3Client(context.getVariableManager());
        InputStream inputStream = S3Helper.getAsInputStream(client, bucket, originalKey);
        logger.info("Underlying S3 object got.");

        logger.info("Deserialize into a collection object.");
        Collection<T> CollectionProxy = JacksonHelper.fromJson(
                inputStream,
                new TypeReference<Collection<T>>() { }
        );
        if(CollectionProxy == null) {
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
        CollectionProxy.getValue().add(item);
        String updatedHash = HashHelper.hashAndEncode(CollectionProxy.toString());
        String updatedKey = prefix.concat(updatedHash);
        logger.info(String.format("S3 key constructed from proxy is %s", updatedKey));
        String updatedSerializedProxy = JacksonHelper.toJson(CollectionProxy);
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

        return CollectionProxy;
    }

    public boolean member(Collection<T> collection, T item) {
        logger.info("Member Start...");

        logger.info("Use the request collection proxy to get the underlying S3 object.");
        String originalHash = HashHelper.hashAndEncode(collection.toString());
        if (originalHash.isEmpty()) {
            logger.error("failed to hash the request body (original collection)");
            throw new RuntimeException();
        }
        String bucket = configuration.config.get("bucket");
        String prefix = configuration.config.get("prefix");
        String originalKey = prefix.concat(originalHash);
        logger.info(String.format("S3 key constructed from proxy is %s", originalKey));
        S3Client client = createS3Client(context.getVariableManager());
        InputStream inputStream = S3Helper.getAsInputStream(client, bucket, originalKey);
        logger.info("Underlying S3 object got.");

        logger.info("Deserialize into a collection object.");
        Collection<T> CollectionProxy = JacksonHelper.fromJson(
                inputStream,
                new TypeReference<Collection<T>>() { }
        );
        if (CollectionProxy == null) {
            logger.error("Could not determine underlying object from the provided proxy");
            throw new RuntimeException();
        }
        logger.info("Deserializing complete.");

        logger.info("Perform membership test.");
        boolean isMember = CollectionProxy.getValue().contains(item);
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

        String bucket = configuration.config.get("bucket");
        String prefix = configuration.config.get("prefix");
        String originalKey = prefix.concat(originalHash);
        logger.info(String.format("S3 key constructed from proxy is %s", originalKey));
        S3Client client = createS3Client(context.getVariableManager());
        InputStream inputStream = S3Helper.getAsInputStream(client, bucket, originalKey);
        logger.info("Underlying S3 object got.");

        logger.info("Deserialize into a collection object.");
        Collection<T> CollectionProxy = JacksonHelper.fromJson(
                inputStream,
                new TypeReference<Collection<T>>() { }
        );
        if(CollectionProxy == null) {
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
        CollectionProxy.getValue().remove(item);
        String updatedHash = HashHelper.hashAndEncode(CollectionProxy.toString());
        String updatedKey = prefix.concat(updatedHash);
        String updatedSerializedProxy = JacksonHelper.toJson(CollectionProxy);
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

        return CollectionProxy;
    }
}
