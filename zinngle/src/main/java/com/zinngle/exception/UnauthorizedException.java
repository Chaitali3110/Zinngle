// src/main/java/com/zinngle/exception/UnauthorizedException.java
package com.zinngle.exception;

public class UnauthorizedException extends RuntimeException {
    public UnauthorizedException(String message) {
        super(message);
    }
}
