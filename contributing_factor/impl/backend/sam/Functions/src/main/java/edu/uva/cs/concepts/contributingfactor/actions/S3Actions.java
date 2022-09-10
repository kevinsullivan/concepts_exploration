package edu.uva.cs.concepts.contributingfactor.actions;

import edu.uva.cs.concepts.Configuration;
import edu.uva.cs.concepts.Context;
import edu.uva.cs.concepts.contributingfactor.Category;
import edu.uva.cs.concepts.contributingfactor.CategoryEnum;
import edu.uva.cs.concepts.contributingfactor.ContributingFactor;
import edu.uva.cs.concepts.contributingfactor.ContributingFactorEnum;
import edu.uva.cs.concepts.utils.JacksonHelper;
import edu.uva.cs.concepts.utils.S3Helper;
import edu.uva.cs.concepts.utils.VariableManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.services.s3.S3Client;

import java.io.InputStream;
import java.util.Map;

import static edu.uva.cs.concepts.utils.S3Helper.createS3Client;

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
            categoryMap = JacksonHelper.fromJson(stream, Map.class);
        } catch(SdkServiceException exception) {
            logger.info(exception.getMessage());
            throw new RuntimeException();
        }

        String cfs = S3Actions.quoteUnwrap(JacksonHelper.toJson(contributingFactor.contributingFactor));
        if(cfs.isEmpty()) {
            throw new RuntimeException();
        }
        String categoryString = S3Actions.quoteWrap(categoryMap.getOrDefault(cfs, ""));
        if(categoryString.equals("\"\"")) {
            logger.info("Unknown category.");
            throw new RuntimeException();
        }

        CategoryEnum categoryEnum = JacksonHelper.fromJson(categoryString, CategoryEnum.class);
        return new Category(categoryEnum);
    }

    @Override
    public String description(ContributingFactor contributingFactor) {
        VariableManager variables = context.getVariableManager();
        S3Client client = createS3Client(variables);

        logger.info("Fetching the description mapping from S3.");
        Map<String, String> descriptionMap;
        try {
            InputStream stream = S3Helper.getAsInputStream(client, variables.get("bucket"), variables.get("key"));
            descriptionMap = JacksonHelper.fromJson(stream, Map.class);
        } catch(SdkServiceException exception) {
            logger.info(exception.getMessage());
            throw new RuntimeException();
        }

        String cfs = S3Actions.quoteUnwrap(JacksonHelper.toJson(contributingFactor.contributingFactor));
        if(cfs.isEmpty()) {
            throw new RuntimeException();
        }
        String description = S3Actions.quoteWrap(descriptionMap.getOrDefault(cfs, ""));
        if(description.equals("\"\"")) {
            logger.info("Unknown description.");
            throw new RuntimeException();
        }

        return description;
    }

    private static String quoteWrap(String str) {
        return String.valueOf('"').concat(str).concat(String.valueOf('"'));
    }

    private static String quoteUnwrap(String str) {
        if(str.startsWith(String.valueOf('"')) && str.endsWith(String.valueOf('"'))) {
            return str.substring(1, str.length()-1);
        }

        return "";
    }

}
