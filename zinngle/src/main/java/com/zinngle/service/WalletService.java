// src/main/java/com/zinngle/service/WalletService.java
package com.zinngle.service;

import com.zinngle.exception.BadRequestException;
import com.zinngle.model.Transaction;
import com.zinngle.model.User;
import com.zinngle.repository.TransactionRepository;
import com.zinngle.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class WalletService {

    private final UserRepository userRepository;
    private final TransactionRepository transactionRepository;

    @Transactional
    public void addCoins(UUID userId, BigDecimal amount, String paymentId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BadRequestException("User not found"));

        user.setCoinsBalance(user.getCoinsBalance().add(amount));
        userRepository.save(user);

        Transaction transaction = Transaction.builder()
                .user(user)
                .transactionType(Transaction.TransactionType.CREDIT)
                .amount(amount)
                .description("Coins added to wallet")
                .status(Transaction.TransactionStatus.COMPLETED)
                .paymentGateway("RAZORPAY")
                .paymentId(paymentId)
                .build();

        transactionRepository.save(transaction);
    }

    @Transactional
    public void deductCoins(UUID userId, BigDecimal amount) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BadRequestException("User not found"));

        if (user.getCoinsBalance().compareTo(amount) < 0) {
            throw new BadRequestException("Insufficient balance");
        }

        user.setCoinsBalance(user.getCoinsBalance().subtract(amount));
        userRepository.save(user);

        Transaction transaction = Transaction.builder()
                .user(user)
                .transactionType(Transaction.TransactionType.DEBIT)
                .amount(amount)
                .description("Coins deducted for call")
                .status(Transaction.TransactionStatus.COMPLETED)
                .build();

        transactionRepository.save(transaction);
    }

    @Transactional
    public void addCreatorEarnings(UUID creatorId, BigDecimal amount) {
        // Implementation for adding earnings to creator
    }

    public BigDecimal getBalance(UUID userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BadRequestException("User not found"));
        return user.getCoinsBalance();
    }
}
