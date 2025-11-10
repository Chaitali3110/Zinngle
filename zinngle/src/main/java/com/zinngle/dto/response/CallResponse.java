// src/main/java/com/zinngle/dto/response/CallResponse.java
package com.zinngle.dto.response;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
public class CallResponse {
    private UUID callId;
    private String callerName;
    private String creatorName;
    private String callType;
    private String status;
    private Integer durationSeconds;
    private BigDecimal totalCost;
    private String agoraChannelName;
    private String agoraToken;
    private LocalDateTime createdAt;
}
