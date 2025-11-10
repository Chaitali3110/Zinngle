// src/main/java/com/zinngle/dto/request/CallRequest.java
package com.zinngle.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.UUID;

@Data
public class CallRequest {
    
    @NotNull(message = "Creator ID is required")
    private UUID creatorId;

    @NotBlank(message = "Call type is required")
    private String callType; // VIDEO or AUDIO
}
