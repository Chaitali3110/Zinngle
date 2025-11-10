// src/main/java/com/zinngle/exception/BadRequestException.java
package com.zinngle.exception;

public class BadRequestException extends RuntimeException {
    public BadRequestException(String message) {
        super(message);
    }
}
