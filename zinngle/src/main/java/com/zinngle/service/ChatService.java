// src/main/java/com/zinngle/service/ChatService.java
package com.zinngle.service;

import com.zinngle.dto.request.MessageRequest;
import com.zinngle.dto.response.MessageResponse;
import com.zinngle.exception.BadRequestException;
import com.zinngle.model.Message;
import com.zinngle.model.User;
import com.zinngle.repository.MessageRepository;
import com.zinngle.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ChatService {

    private final MessageRepository messageRepository;
    private final UserRepository userRepository;
    private final SimpMessagingTemplate messagingTemplate;

    @Transactional
    public MessageResponse sendMessage(UUID senderId, MessageRequest request) {
        User sender = userRepository.findById(senderId)
                .orElseThrow(() -> new BadRequestException("Sender not found"));

        User receiver = userRepository.findById(request.getReceiverId())
                .orElseThrow(() -> new BadRequestException("Receiver not found"));

        Message message = Message.builder()
                .sender(sender)
                .receiver(receiver)
                .content(request.getContent())
                .messageType(Message.MessageType.valueOf(request.getMessageType()))
                .mediaUrl(request.getMediaUrl())
                .isRead(false)
                .build();

        message = messageRepository.save(message);

        // Send real-time notification via WebSocket
        MessageResponse response = mapToMessageResponse(message);
        messagingTemplate.convertAndSend(
                "/topic/messages/" + receiver.getId(),
                response
        );

        return response;
    }

    public List<MessageResponse> getConversation(UUID userId1, UUID userId2) {
        List<Message> messages = messageRepository.findConversation(userId1, userId2);
        return messages.stream()
                .map(this::mapToMessageResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public void markAsRead(UUID messageId) {
        Message message = messageRepository.findById(messageId)
                .orElseThrow(() -> new BadRequestException("Message not found"));
        message.setIsRead(true);
        messageRepository.save(message);
    }

    private MessageResponse mapToMessageResponse(Message message) {
        return MessageResponse.builder()
                .id(message.getId())
                .senderId(message.getSender().getId())
                .senderName(message.getSender().getFullName())
                .receiverId(message.getReceiver().getId())
                .content(message.getContent())
                .messageType(message.getMessageType().name())
                .mediaUrl(message.getMediaUrl())
                .isRead(message.getIsRead())
                .createdAt(message.getCreatedAt())
                .build();
    }
}
