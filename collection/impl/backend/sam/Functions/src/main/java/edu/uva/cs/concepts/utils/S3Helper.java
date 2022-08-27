package edu.uva.cs.concepts.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.uva.cs.concepts.collection.gen.model.Collection;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.ResponseBytes;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3ClientBuilder;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.utils.AttributeMap;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.io.*;
import java.net.URI;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import static software.amazon.awssdk.http.SdkHttpConfigurationOption.TRUST_ALL_CERTIFICATES;

public class S3Helper {

    /**
     * An S3 Client parameterized by the environment.
     *
     * @param variableManager
     * @return
     */
    public static S3Client createS3Client(VariableManager variableManager) {
        String region = variableManager.getOrDefault("region", "us-east-1");

        // TODO (nphair): Do not blindly trust everything. Figure out how to trust only our mocked endpoint.
        S3ClientBuilder builder = S3Client.builder()
                .region(Region.of(region))
                .httpClient(UrlConnectionHttpClient.builder().buildWithDefaults(AttributeMap.builder()
                        .put(TRUST_ALL_CERTIFICATES, Boolean.TRUE)
                        .build()));

        if (variableManager.containsKey("overrideEndpoint")) {
            builder.endpointOverride(URI.create(variableManager.get("overrideEndpoint")));
        }

        if (variableManager.containsKey("accessKeyId") && variableManager.containsKey("secretAccessKey")) {
            String accessKeyId = variableManager.get("accessKeyId");
            String secretAccessKey = variableManager.get("secretAccessKey");
            AwsCredentials credentials = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
            builder.credentialsProvider(StaticCredentialsProvider.create(credentials));
        }

        return builder.build();
    }

    /**
     * Create a key that is composed of the current time and a uuid.
     *
     * @return the key
     */
    public static String createKey() {
        String uuid = UUID.randomUUID().toString().replace("-", "");
        return S3Helper.createPrefix(Instant.now()) + "/" + uuid + ".json";
    }

    /**
     * Create a prefix from an instant with the date format.
     *
     * @param instant
     * @return
     */
    public static String createPrefix(Instant instant) {
        DateTimeFormatter formatter = DateTimeFormatter
                .ofPattern("y/MM/dd/HH/mm/ss")
                .withZone(ZoneId.from(ZoneOffset.UTC));
        return formatter.format(instant);
    }

    /**
     * Fetches and parses a submission in S3.
     *
     * @param s3
     * @param bucketName
     * @param keyName
     * @return
     */
    public static InputStream getAsInputStream(S3Client s3, String bucketName, String keyName) {
        try {
            GetObjectRequest objectRequest = GetObjectRequest
                    .builder()
                    .key(keyName)
                    .bucket(bucketName)
                    .build();

            ResponseBytes<GetObjectResponse> objectBytes = s3.getObjectAsBytes(objectRequest);
            return objectBytes.asInputStream();
        } catch (S3Exception e) {
            System.err.println(e.awsErrorDetails().errorMessage());
        }
        return new ByteArrayInputStream(new byte[0]);
    }

    /**
     * Remove all the objects from a bucket.
     * @param s3
     * @param bucket
     */
    public static void emptyBucket(S3Client s3, String bucket) {
        java.util.Collection<ObjectIdentifier> objs = s3.listObjectsV2(b -> b.bucket(bucket).build())
                .contents()
                .stream()
                .map(S3Object::key)
                .map(ObjectIdentifier.builder()::key)
                .map(SdkBuilder::build)
                .collect(Collectors.toList());

        if(objs.isEmpty())  {
            return;
        }

        s3.deleteObjects(d -> d.bucket(bucket)
                .delete(Delete.builder().objects(objs).build()).build());
    }


    /**
     * Delete all objects under a given prefix.
     * @param s3
     * @param bucket
     * @param prefix
     */
    public static void deletePrefix(S3Client s3, String bucket, String prefix) {
        s3.deleteObjects(d -> d.bucket(bucket)
                .delete(Delete.builder().objects(s3.listObjectsV2(b -> b.bucket(bucket).prefix(prefix).build())
                                .contents()
                                .stream()
                                .map(S3Object::key)
                                .map(ObjectIdentifier.builder()::key)
                                .map(SdkBuilder::build)
                                .collect(Collectors.toList()))
                        .build()));
    }


    /**
     * True if object is in S3 bucket. Otherwise, False.
     * @param s3
     * @param bucket
     * @param key
     * @return
     */
    public static boolean exists(S3Client s3, String bucket, String key) {
        try {
            s3.headObject(HeadObjectRequest.builder().bucket(bucket).key(key).build());
            return true;
        } catch (NoSuchKeyException e) {
            return false;
        }
    }
}
