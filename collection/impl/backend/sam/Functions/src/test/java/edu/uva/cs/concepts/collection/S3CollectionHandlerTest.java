package edu.uva.cs.concepts.collection;
import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.MockContext;
import edu.uva.cs.concepts.contributingfactor.ContributingFactor;
import edu.uva.cs.concepts.contributingfactor.ContributingFactorEnum;
import edu.uva.cs.concepts.lambda.concrete.S3CollectionHandler;
import edu.uva.cs.utils.HashHelper;
import edu.uva.cs.utils.JacksonHelper;
import edu.uva.cs.utils.S3Helper;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Bucket;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.DeleteBucketRequest;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class S3CollectionHandlerTest {

    @RegisterExtension
    static final S3MockExtension S3_MOCK = S3MockExtension.builder().silent().withSecureConnection(false).build();
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
    public void test_init() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "int");
        event.setHeaders(headers);
        event.setPath("init");

        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent response = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, response.getStatusCode());

        // Test the returned representation.
        Collection<Integer> returnedProxyCollection = JacksonHelper.fromJson(response.getBody(), new TypeReference<Collection<Integer>>() { });
        assertTrue(returnedProxyCollection.getValue().isEmpty());

        // Test we have an S3 representation.
        String key = "foo/".concat(initKey());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, key);
        Collection<Integer> storedProxyCollection = JacksonHelper.fromJson(stream, new TypeReference<Collection<Integer>>() { });
        assertTrue(storedProxyCollection.getValue().isEmpty());
    }

    @Test
    public void test_insert_int() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "int");
        event.setHeaders(headers);
        event.setPath("init");

        // Initialize a collection to operate on.
        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent response = s3CollectionHandler.handleRequest(event, new MockContext());
        Collection<Integer> initCollection = JacksonHelper.fromJson(
                response.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );

        // Build an insert request.
        CollectionItemPair<Integer, Collection<Integer>> collectionItemPair = new CollectionItemPair<>(
                initCollection,
                42
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("insert");
        event.setBody(body);

        // Invoke the insert handler.
        APIGatewayProxyResponseEvent insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());

        // Test returned representation.
        Collection<Integer> updated = JacksonHelper.fromJson(
                insertResponse.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );
        assertTrue(updated.getValue().contains(42));

        // Test S3 representation.
        String hash = HashHelper.hashAndEncode(updated.toString());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, "foo/".concat(hash));
        Collection<Integer> storedProxyCollection = JacksonHelper.fromJson(
                stream,
                new TypeReference<Collection<Integer>>(){}
        );
        assertTrue(storedProxyCollection.getValue().contains(42));
    }

    @Test
    public void test_insert_bool() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "bool");
        event.setHeaders(headers);
        event.setPath("init");

        // Initialize a collection to operate on.
        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent response = s3CollectionHandler.handleRequest(event, new MockContext());
        Collection<Boolean> initCollection = JacksonHelper.fromJson(
                response.getBody(),
                new TypeReference<Collection<Boolean>>(){}
        );

        // Build an insert request.
        CollectionItemPair<Boolean, Collection<Boolean>> collectionItemPair = new CollectionItemPair<>(
                initCollection,
                true
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("insert");
        event.setBody(body);

        // Invoke the insert handler.
        APIGatewayProxyResponseEvent insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());

        // Test returned representation.
        Collection<Boolean> updated = JacksonHelper.fromJson(
                insertResponse.getBody(),
                new TypeReference<Collection<Boolean>>(){}
        );
        assertTrue(updated.getValue().contains(true));

        // Test S3 representation.
        String hash = HashHelper.hashAndEncode(updated.toString());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, "foo/".concat(hash));
        Collection<Boolean> storedProxyCollection = JacksonHelper.fromJson(
                stream,
                new TypeReference<Collection<Boolean>>(){}
        );
        assertTrue(storedProxyCollection.getValue().contains(true));
    }

    @Test
    public void test_insert_into_unknown_collection() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "int");
        event.setHeaders(headers);
        event.setPath("insert");

        // Initialize a collection to operate on.
        CollectionItemPair<Integer, Collection<Integer>> collectionItemPair = new CollectionItemPair<>(
                new Collection<>(new ArrayList<>()),
                5
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);

        // Invoke the insert handler.
        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(500, insertResponse.getStatusCode());
    }

    @Test
    public void test_remove() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "int");
        event.setHeaders(headers);
        event.setPath("init");

        // Initialize a collection to operate on.
        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent response = s3CollectionHandler.handleRequest(event, new MockContext());
        Collection<Integer> initCollection = JacksonHelper.fromJson(
                response.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );

        // Build an insert request.
        CollectionItemPair<Integer, Collection<Integer>> collectionItemPair = new CollectionItemPair<>(
                initCollection,
                42
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("insert");
        event.setBody(body);

        // Invoke the insert handler.
        APIGatewayProxyResponseEvent insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());
        Collection<Integer> returnedProxyCollection = JacksonHelper.fromJson(
                insertResponse.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );

        // Add 99.
        collectionItemPair = new CollectionItemPair<>(
                returnedProxyCollection,
                99
        );
        body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);
        insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        returnedProxyCollection = JacksonHelper.fromJson(
                insertResponse.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );

        // Remove 42.
        collectionItemPair = new CollectionItemPair<>(
                returnedProxyCollection,
                42
        );
        body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("remove");
        event.setBody(body);
        APIGatewayProxyResponseEvent removeResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, removeResponse.getStatusCode());

        // Test returned representation.
        returnedProxyCollection = JacksonHelper.fromJson(
                removeResponse.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );
        assertFalse(returnedProxyCollection.getValue().contains(42));
        assertTrue(returnedProxyCollection.getValue().contains(99));

        // Test S3 representation.
        String hash = HashHelper.hashAndEncode(returnedProxyCollection.toString());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, "foo/".concat(hash));
        Collection<Integer> storedProxyCollection = JacksonHelper.fromJson(
                stream,
                new TypeReference<Collection<Integer>>(){}
        );
        assertFalse(storedProxyCollection.getValue().contains(42));
        assertTrue(storedProxyCollection.getValue().contains(99));
    }

    @Test
    public void test_member_true() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "int");
        event.setHeaders(headers);
        event.setPath("init");

        // Initialize a collection to operate on.
        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent response = s3CollectionHandler.handleRequest(event, new MockContext());
        Collection<Integer> initCollection = JacksonHelper.fromJson(
                response.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );

        // Build an insert request.
        CollectionItemPair<Integer, Collection<Integer>> collectionItemPair = new CollectionItemPair<>(
                initCollection,
                42
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("insert");
        event.setBody(body);

        // Invoke the insert handler.
        APIGatewayProxyResponseEvent insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());
        Collection<Integer> returnedProxyCollection = JacksonHelper.fromJson(
                insertResponse.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );


        // Assert 42 is in the collection.
        collectionItemPair = new CollectionItemPair(
                returnedProxyCollection,
                42
        );
        body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("member");
        event.setBody(body);
        APIGatewayProxyResponseEvent memberResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, memberResponse.getStatusCode());

        // Test returned representation.
        Boolean isMember = JacksonHelper.fromJson(
                memberResponse.getBody(),
                Boolean.class
        );
        assertTrue(isMember);
    }

    @Test
    public void test_member_false() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "int");
        event.setHeaders(headers);
        event.setPath("init");

        // Initialize a collection to operate on.
        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent response = s3CollectionHandler.handleRequest(event, new MockContext());
        Collection<Integer> initCollection = JacksonHelper.fromJson(
                response.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );

        // Build an insert request.
        CollectionItemPair<Integer, Collection<Integer>> collectionItemPair = new CollectionItemPair<>(
                initCollection,
                42
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("insert");
        event.setBody(body);

        // Invoke the insert handler.
        APIGatewayProxyResponseEvent insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());
        Collection<Integer> returnedProxyCollection = JacksonHelper.fromJson(
                insertResponse.getBody(),
                new TypeReference<Collection<Integer>>(){}
        );


        // Assert 99 is not in the collection.
        collectionItemPair = new CollectionItemPair(
                returnedProxyCollection,
                99
        );
        body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("member");
        event.setBody(body);
        APIGatewayProxyResponseEvent memberResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, memberResponse.getStatusCode());

        // Test returned representation.
        Boolean isMember = JacksonHelper.fromJson(
                memberResponse.getBody(),
                Boolean.class
        );
        assertFalse(isMember);
    }

    @Test
    public void test_insert_contributing_factor() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("t", "contributingfactor");
        event.setHeaders(headers);
        event.setPath("init");

        // Initialize a collection to operate on.
        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        APIGatewayProxyResponseEvent response = s3CollectionHandler.handleRequest(event, new MockContext());
        Collection<String> initCollection = JacksonHelper.fromJson(
                response.getBody(),
                new TypeReference<Collection<String>>(){}
        );

        // Build an insert request.
        CollectionItemPair<String, Collection<String>> collectionItemPair = new CollectionItemPair<>(
                initCollection,
                ContributingFactorEnum.PatientOther.name()
        );
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setPath("insert");
        event.setBody(body);

        // Invoke the insert handler.
        APIGatewayProxyResponseEvent insertResponse = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, insertResponse.getStatusCode());

        // Test returned representation.
        Collection<String> updated = JacksonHelper.fromJson(
                insertResponse.getBody(),
                new TypeReference<Collection<String>>(){}
        );
        assertTrue(updated.getValue().contains("PatientOther"));

        // Test S3 representation.
        String hash = HashHelper.hashAndEncode(updated.toString());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, "foo/".concat(hash));
        Collection<String> storedProxyCollection = JacksonHelper.fromJson(
                stream,
                new TypeReference<Collection<String>>(){}
        );
        System.out.println(storedProxyCollection);
        assertTrue(storedProxyCollection.getValue().contains("PatientOther"));
    }

    private String initKey() {
        Collection<Integer> initCollection = new Collection<>(new ArrayList<>());
        return HashHelper.hashAndEncode(initCollection.toString());
    }
}