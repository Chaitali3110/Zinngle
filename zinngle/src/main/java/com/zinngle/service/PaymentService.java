package com.zinngle.service;

import com.razorpay.RazorpayException;
import com.zinngle.dto.request.PaymentRequest;
import com.zinngle.dto.request.VerifyPaymentRequest;
import com.zinngle.dto.response.PaymentResponse;
import com.zinngle.exception.BadRequestException;
import com.zinngle.model.Transaction;
import com.zinngle.model.User;
import com.zinngle.repository.TransactionRepository;
import com.zinngle.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final RazorpayService razorpayService;
    private final UserRepository userRepository;
    private final TransactionRepository transactionRepository;

    @Transactional
    public PaymentResponse createPaymentOrder(UUID userId, PaymentRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BadRequestException("User not found"));

        try {
            String orderId = razorpayService.createOrder(request.getAmount());

            Transaction transaction = Transaction.builder()
                    .user(user)
                    .transactionType(Transaction.TransactionType.CREDIT)
                    .amount(request.getAmount())
                    .description("Top-up for " + request.getAmount())
                    .status(Transaction.TransactionStatus.PENDING)
                    .paymentGateway("Razorpay")
                    .orderId(orderId)
                    .createdAt(LocalDateTime.now())
                    .build();
            transactionRepository.save(transaction);

            return PaymentResponse.builder()
                    .orderId(orderId)
                    .amount(request.getAmount())
                    .currency("INR") // Assuming INR for Razorpay
                    .build();

        } catch (RazorpayException e) {
            throw new BadRequestException("Failed to create Razorpay order: " + e.getMessage());
        }
    }

    @Transactional
    public PaymentResponse verifyPayment(UUID userId, VerifyPaymentRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BadRequestException("User not found"));

        Transaction transaction = transactionRepository.findByOrderId(request.getOrderId())
                .orElseThrow(() -> new BadRequestException("Transaction not found for order ID: " + request.getOrderId()));

        if (transaction.getStatus() == Transaction.TransactionStatus.COMPLETED) {
            throw new BadRequestException("Payment already verified for this order.");
        }

        boolean isSignatureValid = razorpayService.verifyPayment(
                request.getOrderId(),
                request.getPaymentId(),
                request.getSignature()
        );

        if (!isSignatureValid) {
            transaction.setStatus(Transaction.TransactionStatus.FAILED);
            transactionRepository.save(transaction);
            throw new BadRequestException("Invalid payment signature.");
        }

        // Update user's wallet balance
        user.setCoinsBalance(user.getCoinsBalance().add(transaction.getAmount()));
        userRepository.save(user);

        // Update transaction status
        transaction.setPaymentId(request.getPaymentId());
        transaction.setStatus(Transaction.TransactionStatus.COMPLETED);
        transaction.setBalanceAfter(user.getCoinsBalance()); // Set final balance
        transactionRepository.save(transaction);

        return PaymentResponse.builder()
                .orderId(transaction.getOrderId())
                .paymentId(transaction.getPaymentId())
                .amount(transaction.getAmount())
                .currency("INR")
                .status("COMPLETED")
                .build();
    }
}