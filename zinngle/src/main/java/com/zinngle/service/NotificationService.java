// src/main/java/com/zinngle/service/NotificationService.java
package com.zinngle.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService {

    public void sendPushNotification(UUID userId, String title, String body, String token) {
        try {
            Message message = Message.builder()
                    .setToken(token)
                    .setNotification(Notification.builder()
                            .setTitle(title)
                            .setBody(body)
                            .build())
                    .build();

            String response = FirebaseMessaging.getInstance().send(message);
            log.info("Successfully sent message: {}", response);
        } catch (Exception e) {
            log.error("Error sending notification", e);
        }
    }

    public void sendCallNotification(UUID receiverId, String callerName, String token) {
        sendPushNotification(
                receiverId,
                "Incoming Call",
                callerName + " is calling you",
                token
        );
    }

    public void sendMessageNotification(UUID receiverId, String senderName, String message, String token) {
        sendPushNotification(
                receiverId,
                "New Message from " + senderName,
                message,
                token
        );
    }

    public void sendGiftNotification(UUID receiverId, String giftName) {
        // You would typically fetch the receiver's FCM token from the database here
        // For now, we'll use a placeholder or assume it's passed if available
        String dummyFcmToken = "YOUR_RECEIVER_FCM_TOKEN"; // Replace with actual token retrieval logic

        sendPushNotification(
                receiverId,
                "New Gift Received!",
                "You received a " + giftName + "!",
                dummyFcmToken // Use the actual token here
        );
    }
}
