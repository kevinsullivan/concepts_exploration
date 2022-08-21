package edu.uva.cs.concepts.utils;

import org.junit.jupiter.api.Test;

import java.util.regex.Pattern;

import static org.junit.jupiter.api.Assertions.*;

public class TestS3Helper {

    @Test
    public void testKey() {
        String pattern = "\\d{4}/\\d{2}/\\d{2}/\\d{2}/\\d{2}/\\d{2}/\\w{32}\\.json";
        assertTrue(Pattern.matches(pattern, S3Helper.createKey()));
    }
}
