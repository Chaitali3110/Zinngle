// src/main/java/com/zinngle/controller/ChatWebSocketController.java
package com.zinngle.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import com.zinngle.dto.request.MessageRequest;
import com.zinngle.dto.response.MessageResponse;
import com.zinngle.service.ChatService;

import java.util.UUID;

@Controller
@RequiredArgsConstructor
public class ChatWebSocketController {

    private final ChatService chatService;

    @MessageMapping("/chat.sendMessage")
    @SendTo("/topic/public")
    public MessageResponse sendMessage(@Payload MessageRequest messageRequest) {
        UUID senderId = UUID.fromString(messageRequest.getSenderId());
        return chatService.sendMessage(senderId, messageRequest);
    }

    @MessageMapping("/chat.addUser")
    @SendTo("/topic/public")
    public MessageResponse addUser(@Payload MessageRequest messageRequest,
                                   SimpMessageHeaderAccessor headerAccessor) {
        headerAccessor.getSessionAttributes().put("username", messageRequest.getSenderId());
        return MessageResponse.builder()
                .content(messageRequest.getSenderId() + " joined!")
                .messageType("JOIN")
                .build();
    }
}
