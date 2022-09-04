package edu.uva.cs.concepts.collection;
import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.concepts.MockContext;
import edu.uva.cs.concepts.lambda.concrete.S3CollectionHandler;
import edu.uva.cs.concepts.utils.HashHelper;
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
import software.amazon.awssdk.utils.builder.SdkBuilder;

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
        APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
        Map<String, String> params = new HashMap<>();
        params.put("bucket", BUCKET_NAME);
        params.put("prefix", "foo/");
        event.setQueryStringParameters(params);
        Map<String, String> headers = new HashMap<>();
        headers.put("type", "Integer");
        event.setHeaders(headers);
        event.setRawPath("init");

        S3CollectionHandler s3CollectionHandler = new S3CollectionHandler();
        s3CollectionHandler.handleRequest(event, new MockContext());

        APIGatewayV2HTTPResponse response = s3CollectionHandler.handleRequest(event, new MockContext());
        assertEquals(200, response.getStatusCode());

        // Test the returned representation.
        CollectionSerDer<Integer> serDer = new CollectionSerDer<>();
        Collection<Integer> returnedProxyCollection = serDer.deserialize(response.getBody());
        assertTrue(returnedProxyCollection.getValue().isEmpty());

        // Test we have an S3 representation.
        //String key = "foo/".concat(initKey());
        //InputStream stream = S3Helper.getAsInputStream(s3Client, BUCKET_NAME, key);
        //Collection<Integer> storedProxyCollection = serDer.deserialize(stream);
        //assertTrue(storedProxyCollection.getValue().isEmpty());
    }

    private String initKey() {
        Collection<Integer> initCollection = new Collection<>(new ArrayList<>());
        return HashHelper.hashAndEncode(initCollection.toString());
    }
}