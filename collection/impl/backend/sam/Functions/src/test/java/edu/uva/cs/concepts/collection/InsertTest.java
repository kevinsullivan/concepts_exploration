package edu.uva.cs.concepts.collection;

import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import edu.uva.cs.concepts.MockContext;
import edu.uva.cs.concepts.collection.representation.Collection;
import edu.uva.cs.concepts.collection.representation.CollectionItemPair;
import edu.uva.cs.concepts.collection.representation.StateMapper;
import edu.uva.cs.concepts.utils.HashHelper;
import edu.uva.cs.concepts.utils.JacksonHelper;
import edu.uva.cs.concepts.utils.S3Helper;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.utils.StringInputStream;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class InsertTest {

    @RegisterExtension
    static final S3MockExtension S3_MOCK =
            S3MockExtension.builder().silent().withSecureConnection(false).build();
    private final S3Client s3Client = S3_MOCK.createS3ClientV2();

    private static final String BUCKET_NAME = "test-collections";

    @BeforeAll
    private static void initializeEnvironment() {
        System.setProperty("overrideEndpoint", S3_MOCK.getServiceEndpoint());
        System.setProperty("accessKeyId", "foo");
        System.setProperty("secretAccessKey", "bar");
    }

    @BeforeEach
    public void setup() {
        CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
                .bucket(BUCKET_NAME)
                .build();
        s3Client.createBucket(createBucketRequest);
    }

    @AfterEach
    public void teardown() {
            s3Client.listBuckets().buckets().stream().map(Bucket::name).forEach(bucket ->
                    S3Helper.emptyBucket(s3Client, bucket));

        s3Client.listBuckets().buckets().stream()
                .map(Bucket::name)
                .map(DeleteBucketRequest.builder()::bucket)
                .map(SdkBuilder::build)
                .forEach(s3Client::deleteBucket);
    }


    @Test
    public void test_insert_int() {
        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("Model", "CollectionItemPair<Integer>");
        event.setHeaders(headers);

        // Initialize a collection to operate on.
        Init init = new Init();
        init.handleRequest(event, new MockContext());

        // Build an insert request.
        CollectionItemPair<Integer> collectionItemPair = new CollectionItemPair<>(
                new Collection<>(new ArrayList<>()),
                42
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);

        // Invoke the insert handler.
        Insert insert = new Insert();
        APIGatewayV2HTTPResponse insertResponse = insert.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());

        // Test returned representation.
        Collection updated = (Collection) JacksonHelper.fromJson(
                new StringInputStream(insertResponse.getBody()),
                StateMapper.outputFromHeader(headers.get("Model"))
        );
        assertTrue(updated.getValue().contains(42));

        // Test S3 representation.
        String hash = HashHelper.hashAndEncode(updated.toString());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, "foo/".concat(hash));
        Collection storedProxyCollection = JacksonHelper.fromJson(stream, Collection.class);
        assertTrue(storedProxyCollection.getValue().contains(42));
    }

    @Test
    public void test_insert_bool() {
        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("Model", "CollectionItemPair<Boolean>");
        event.setHeaders(headers);

        // Initialize a collection to operate on.
        Init init = new Init();
        APIGatewayV2HTTPResponse initResponse = init.handleRequest(event, new MockContext());
        Collection initCollection = (Collection) JacksonHelper.fromJson(
                new StringInputStream(initResponse.getBody()),
                StateMapper.outputFromHeader(headers.get("Model"))
        );

        // Build an insert request.
        CollectionItemPair<Boolean> collectionItemPair = new CollectionItemPair<>(
                initCollection,
                true
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);

        // Invoke the insert handler.
        Insert insert = new Insert();
        APIGatewayV2HTTPResponse insertResponse = insert.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());

        // Test returned representation.
        Collection updated = (Collection) JacksonHelper.fromJson(
                new StringInputStream(insertResponse.getBody()),
                StateMapper.outputFromHeader(headers.get("Model"))
        );
        assertTrue(updated.getValue().contains(true));

        // Test S3 representation.
        String hash = HashHelper.hashAndEncode(updated.toString());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, "foo/".concat(hash));
        Collection storedProxyCollection = JacksonHelper.fromJson(stream, Collection.class);
        assertTrue(storedProxyCollection.getValue().contains(true));
    }

    @Test
    public void test_insert_into_unknown_collection() throws JsonProcessingException {
        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);

        CollectionItemPair<Integer> collectionItemPair = new CollectionItemPair<>(
                new Collection<>(new ArrayList<>()),
                5
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);

        // Invoke the insert handler.
        Insert insert = new Insert();
        APIGatewayV2HTTPResponse insertResponse = insert.handleRequest(event, new MockContext());
        assertEquals(500, insertResponse.getStatusCode());
    }
}