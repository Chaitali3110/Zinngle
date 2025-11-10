// src/main/java/com/zinngle/exception/ResourceNotFoundException.java
package com.zinngle.exception;

public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String message) {
        super(message);
    }
}
