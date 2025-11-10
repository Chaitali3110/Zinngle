package com.zinngle.service;

import com.zinngle.dto.request.SendGiftRequest;
import com.zinngle.dto.response.GiftResponse;
import com.zinngle.exception.BadRequestException;
import com.zinngle.model.Gift;
import com.zinngle.model.User;
import com.zinngle.repository.GiftRepository;
import com.zinngle.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GiftService {

    private final GiftRepository giftRepository;
    private final UserRepository userRepository;
    private final WalletService walletService; // Assuming WalletService exists
    private final NotificationService notificationService; // Inject NotificationService

    public List<GiftResponse> getAllGifts() {
        return giftRepository.findAll().stream()
                .map(this::mapToGiftResponse)
                .collect(Collectors.toList());
    }

    public List<GiftResponse> getGiftsByCategory(String category) {
        return giftRepository.findByCategory(category).stream()
                .map(this::mapToGiftResponse)
                .collect(Collectors.toList());
    }

    @Transactional
    public void sendGift(SendGiftRequest request) {
        User sender = userRepository.findById(request.getSenderId())
                .orElseThrow(() -> new BadRequestException("Sender not found"));
        
        User receiver = userRepository.findById(request.getReceiverId())
                .orElseThrow(() -> new BadRequestException("Receiver not found"));

        Gift gift = giftRepository.findById(request.getGiftId())
                .orElseThrow(() -> new BadRequestException("Gift not found"));

        // Deduct gift price from sender's wallet
        walletService.deductCoins(sender.getId(), BigDecimal.valueOf(gift.getPrice()));

        // Notify the receiver
        notificationService.sendGiftNotification(receiver.getId(), gift.getName());

        // Implement logic to notify receiver, etc.
    }

    private GiftResponse mapToGiftResponse(Gift gift) {
        return GiftResponse.builder()
                .id(gift.getId())
                .name(gift.getName())
                .icon(gift.getIcon())
                .price(gift.getPrice())
                .category(gift.getCategory())
                .createdAt(gift.getCreatedAt())
                .build();
    }
}