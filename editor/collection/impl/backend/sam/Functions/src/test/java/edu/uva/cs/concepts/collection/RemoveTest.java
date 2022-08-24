package edu.uva.cs.concepts.collection;

import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import edu.uva.cs.concepts.MockContext;
import edu.uva.cs.concepts.collection.gen.model.Collection;
import edu.uva.cs.concepts.collection.gen.model.CollectionItemPair;
import edu.uva.cs.concepts.utils.HashHelper;
import edu.uva.cs.concepts.utils.JacksonHelper;
import edu.uva.cs.concepts.utils.S3Helper;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Bucket;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.DeleteBucketRequest;
import software.amazon.awssdk.utils.StringInputStream;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class RemoveTest {

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
    public void test_remove() {
        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);

        // Initialize a collection to operate on.
        Init init = new Init();
        APIGatewayV2HTTPResponse response = init.handleRequest(event, new MockContext());
        Collection returnedProxyCollection = JacksonHelper.fromJson(new StringInputStream(response.getBody()), Collection.class);

        // Seed the collection.
        // Add 42.
        CollectionItemPair collectionItemPair = new CollectionItemPair()
                .collection(returnedProxyCollection)
                .item("42");
        String body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);
        Insert insert = new Insert();
        response = insert.handleRequest(event, new MockContext());
        returnedProxyCollection = JacksonHelper.fromJson(new StringInputStream(response.getBody()), Collection.class);

        // Add 99.
        collectionItemPair = new CollectionItemPair()
                .collection(returnedProxyCollection)
                .item("99");
        body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);
        response = insert.handleRequest(event, new MockContext());
        returnedProxyCollection = JacksonHelper.fromJson(new StringInputStream(response.getBody()), Collection.class);

        // Remove 42.
        collectionItemPair = new CollectionItemPair()
                .collection(returnedProxyCollection)
                .item("42");
        body = JacksonHelper.toJson(collectionItemPair);
        event.setBody(body);

        Remove remove = new Remove();
        APIGatewayV2HTTPResponse removeResponse = remove.handleRequest(event, new MockContext());
        assertEquals(200, removeResponse.getStatusCode());

        // Test returned representation.
        Collection updated = JacksonHelper.fromJson(new StringInputStream(removeResponse.getBody()), Collection.class);
        assertFalse(updated.getValue().contains("42"));
        assertTrue(updated.getValue().contains("99"));

        // Test S3 representation.
        String hash = HashHelper.hashAndEncode(updated.toString());
        InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, "foo/".concat(hash));
        Collection storedProxyCollection = JacksonHelper.fromJson(stream, Collection.class);
        assertFalse(storedProxyCollection.getValue().contains("42"));
        assertTrue(storedProxyCollection.getValue().contains("99"));
    }
}