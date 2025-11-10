// src/main/java/com/zinngle/util/ValidationUtil.java
package com.zinngle.util;

import com.zinngle.exception.BadRequestException;

import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    private static final Pattern PHONE_PATTERN = 
        Pattern.compile("^[0-9]{10}$");

    public static void validateEmail(String email) {
        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
            throw new BadRequestException("Invalid email format");
        }
    }

    public static void validatePhoneNumber(String phoneNumber) {
        if (phoneNumber == null || !PHONE_PATTERN.matcher(phoneNumber).matches()) {
            throw new BadRequestException("Invalid phone number format");
        }
    }

    public static void validateAge(int age) {
        if (age < 18) {
            throw new BadRequestException("User must be at least 18 years old");
        }
    }
}
