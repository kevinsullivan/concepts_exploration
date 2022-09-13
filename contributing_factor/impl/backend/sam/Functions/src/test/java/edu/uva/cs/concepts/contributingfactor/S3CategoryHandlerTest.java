package edu.uva.cs.concepts.contributingfactor;
import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import edu.uva.cs.concepts.MockContext;
import edu.uva.cs.concepts.lambda.concrete.S3CategoryHandler;
import edu.uva.cs.utils.JacksonHelper;
import edu.uva.cs.utils.S3Helper;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.RegisterExtension;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Bucket;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.DeleteBucketRequest;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class S3CategoryHandlerTest {

    @RegisterExtension
    static final S3MockExtension S3_MOCK = S3MockExtension.builder().silent().withSecureConnection(false).build();
    private final S3Client s3Client = S3_MOCK.createS3ClientV2();
    private static final String BUCKET_NAME = "test-contributing-factors";
    private static final String CATEGORY_KEY = "contributing-factor/category.json";
    @BeforeAll
    private static void initializeEnvironment() {
        System.setProperty("overrideEndpoint", S3_MOCK.getServiceEndpoint());
        System.setProperty("accessKeyId", "foo");
        System.setProperty("secretAccessKey", "bar");
        System.setProperty("bucket", BUCKET_NAME);
    }

    @BeforeEach
    public void setup() {
        CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
                .bucket(BUCKET_NAME)
                .build();
        s3Client.createBucket(createBucketRequest);

        Map<String, String> categoryMap = new HashMap<>();
        categoryMap.put("patient_unnecessary_treatments", "patient");
        s3Client.putObject(
                builder -> builder.bucket(BUCKET_NAME).key(CATEGORY_KEY),
                RequestBody.fromString(JacksonHelper.toJson(categoryMap))
        );
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
        System.clearProperty("key");
    }

    @Test
    public void test_category() {
        APIGatewayProxyRequestEvent event = new APIGatewayProxyRequestEvent();
        Map<String, String> params = new HashMap<>();
        params.put("contributing-factor", "\"patient_unnecessary_treatments\"");
        event.setQueryStringParameters(params);

        System.setProperty("key", CATEGORY_KEY);
        S3CategoryHandler handler = new S3CategoryHandler();
        APIGatewayProxyResponseEvent response = handler.handleRequest(event, new MockContext());
        assertEquals(200, response.getStatusCode());
        assertEquals("\"patient\"", response.getBody());
    }

}