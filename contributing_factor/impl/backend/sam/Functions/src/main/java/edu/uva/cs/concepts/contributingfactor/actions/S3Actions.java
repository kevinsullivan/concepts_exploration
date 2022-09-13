package edu.uva.cs.concepts.contributingfactor.actions;

import com.fasterxml.jackson.core.type.TypeReference;
import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.contributingfactor.Category;
import edu.uva.cs.concepts.contributingfactor.CategoryEnum;
import edu.uva.cs.concepts.contributingfactor.ContributingFactor;
import edu.uva.cs.utils.JacksonHelper;
import edu.uva.cs.utils.S3Helper;
import edu.uva.cs.utils.VariableManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.services.s3.S3Client;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import static edu.uva.cs.utils.S3Helper.createS3Client;

public class S3Actions extends ContributingFactorActions {
    private Logger logger = LoggerFactory.getLogger(S3Actions.class);

    public S3Actions(Configuration configuration, Context context) {
        super(configuration, context);
    }

    @Override
    public Category category(ContributingFactor contributingFactor) {
        VariableManager variables = context.getVariableManager();
        S3Client client = createS3Client(variables);

        logger.info("Fetching the category mapping from S3.");
        Map<String, String> categoryMap;
        try {
            InputStream stream = S3Helper.getAsInputStream(client, variables.get("bucket"), variables.get("key"));
            TypeReference<HashMap<String, String>> typeRef = new TypeReference<HashMap<String, String>>() {};
            categoryMap = JacksonHelper.fromJson(stream, typeRef);
        } catch(SdkServiceException exception) {
            logger.info(exception.getMessage());
            throw new RuntimeException();
        }

        String cfs = JacksonHelper.fromJson(JacksonHelper.toJson(contributingFactor.contributingFactor), String.class);
        if(cfs.isEmpty()) {
            throw new RuntimeException();
        }
        String categoryString = categoryMap.getOrDefault(cfs, "");
        if(categoryString.isEmpty()) {
            logger.info("Unknown category.");
            throw new RuntimeException();
        }
        categoryString = JacksonHelper.toJson(categoryString);

        Category category = JacksonHelper.fromJson(categoryString, Category.class);
        return category;
    }

    @Override
    public String description(ContributingFactor contributingFactor) {
        VariableManager variables = context.getVariableManager();
        S3Client client = createS3Client(variables);

        logger.info("Fetching the description mapping from S3.");
        Map<String, String> descriptionMap;
        try {
            InputStream stream = S3Helper.getAsInputStream(client, variables.get("bucket"), variables.get("key"));
            TypeReference<HashMap<String, String>> typeRef = new TypeReference<HashMap<String, String>>() {};
            descriptionMap = JacksonHelper.fromJson(stream, typeRef);
        } catch(SdkServiceException exception) {
            logger.info(exception.getMessage());
            throw new RuntimeException();
        }

        String cfs = JacksonHelper.fromJson(JacksonHelper.toJson(contributingFactor.contributingFactor), String.class);
        if(cfs.isEmpty()) {
            throw new RuntimeException();
        }
        String description = descriptionMap.getOrDefault(cfs, "");
        if(description.isEmpty()) {
            logger.info("Unknown description.");
            throw new RuntimeException();
        }
        description = JacksonHelper.toJson(description);

        return description;
    }
}
