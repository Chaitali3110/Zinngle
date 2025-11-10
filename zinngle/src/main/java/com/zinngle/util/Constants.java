// src/main/java/com/zinngle/util/Constants.java
package com.zinngle.util;

public class Constants {
    
    // Token expiration
    public static final long JWT_EXPIRATION = 86400000L; // 24 hours
    
    // Pagination
    public static final int DEFAULT_PAGE_SIZE = 20;
    public static final int MAX_PAGE_SIZE = 100;
    
    // Call pricing
    public static final double PLATFORM_COMMISSION = 0.30; // 30%
    public static final int MIN_CALL_DURATION_FOR_CHARGE = 60; // 60 seconds
    
    // File upload
    public static final long MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
    public static final String[] ALLOWED_IMAGE_TYPES = {"image/jpeg", "image/png", "image/jpg"};
    
    // Error messages
    public static final String USER_NOT_FOUND = "User not found";
    public static final String CREATOR_NOT_FOUND = "Creator not found";
    public static final String INSUFFICIENT_BALANCE = "Insufficient balance";
    public static final String INVALID_CREDENTIALS = "Invalid credentials";
}
