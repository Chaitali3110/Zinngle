// src/main/java/com/zinngle/dto/response/AuthResponse.java
package com.zinngle.dto.response;

import lombok.Builder;
import lombok.Data;

import java.util.UUID;

@Data
@Builder
public class AuthResponse {
    private String token;
    private UUID userId;
    private String email;
    private String fullName;
    private Boolean isCreator;
}
