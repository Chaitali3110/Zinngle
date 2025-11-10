package com.zinngle.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
public class MessageResponse {
    private UUID id;
    private UUID senderId;
    private String senderName;
    private UUID receiverId;
    private String content;
    private String messageType;
    private String mediaUrl;
    private Boolean isRead;
    private LocalDateTime createdAt;
}
