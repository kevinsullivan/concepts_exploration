package edu.uva.cs.concepts.s3;

import com.adobe.testing.s3mock.junit5.S3MockExtension;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.RegisterExtension;
import edu.uva.cs.concepts.collection.gen.model.Collection;
import software.amazon.awssdk.core.exception.SdkException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.utils.builder.SdkBuilder;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class CollectionFetcherTest {

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
    System.setProperty("bucket", BUCKET_NAME);
  }

  @BeforeEach
  public void setup() {
    CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
            .bucket(BUCKET_NAME)
            .build();
    s3Client.createBucket(createBucketRequest);
    uploadTestData();
  }

  private void uploadTestData() {
    Collection collection1 = new Collection()
            .addValueItem("Barack")
            .addValueItem("Donald")
            .addValueItem("Joe");

    Collection collection2 = new Collection()
            .addValueItem("George H. W.")
            .addValueItem("Bill")
            .addValueItem("George W.");

    try {
        ObjectMapper objectMapper = new ObjectMapper();

        PutObjectRequest putOb = PutObjectRequest.builder()
                .bucket(BUCKET_NAME)
                .key("Collection/c1")
                .build();

        s3Client.putObject(putOb,
                RequestBody.fromString(objectMapper.writeValueAsString(collection1)));

        PutObjectRequest putOb2 = PutObjectRequest.builder()
                .bucket(BUCKET_NAME)
                .key("Collection/c2")
                .build();

        s3Client.putObject(putOb2,
                RequestBody.fromString(objectMapper.writeValueAsString(collection2)));
      } catch (JsonProcessingException | SdkException e) {
        assert false;
      }
  }

  @AfterEach
  public void teardown() {
    s3Client.listBuckets().buckets().stream().map(Bucket::name).forEach(bucket ->
            s3Client.deleteObjects(d -> d.bucket(bucket)
                    .delete(Delete.builder().objects(s3Client.listObjectsV2(b -> b.bucket(bucket).build())
                            .contents()
                            .stream()
                            .map(S3Object::key)
                            .map(ObjectIdentifier.builder()::key)
                            .map(SdkBuilder::build)
                            .collect(Collectors.toList()))
                            .build())
                    .build()));

    s3Client.listBuckets().buckets().stream()
            .map(Bucket::name)
            .map(DeleteBucketRequest.builder()::bucket)
            .map(SdkBuilder::build)
            .forEach(s3Client::deleteBucket);
  }


  @Test
  public void test_fetching_collection() throws JsonProcessingException {
    CollectionFetcher CollectionFetcher = new CollectionFetcher();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    Map<String, String> params = new HashMap<>();
    params.put("folder", "Collection");
    event.setQueryStringParameters(params);

    APIGatewayV2HTTPResponse response = CollectionFetcher.handleRequest(event, new MockContext());
    System.out.println(response.getBody());
    Collection c = fromJson(response.getBody(), Collection.class);
    System.out.println(c);
    assertEquals(2, c.getValue().size());
  }

  private <T> T fromJson(String value, Class<T> clazz) {
    ObjectMapper objectMapper = new ObjectMapper();
    try {
      return objectMapper.readValue(value, clazz);
    } catch (JsonProcessingException e) {
      e.printStackTrace();
    }
    return null;
  }
}