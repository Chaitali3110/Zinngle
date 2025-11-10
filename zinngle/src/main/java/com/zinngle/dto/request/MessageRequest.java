package com.zinngle.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.UUID;

@Data
public class MessageRequest {

    @NotBlank(message = "Sender ID is required")
    private String senderId;

    @NotNull(message = "Receiver ID is required")
    private UUID receiverId;

    @NotBlank(message = "Content is required")
    private String content;

    private String messageType; // e.g., TEXT, IMAGE, GIFT
    private String mediaUrl; // Optional for images, voice notes
}
