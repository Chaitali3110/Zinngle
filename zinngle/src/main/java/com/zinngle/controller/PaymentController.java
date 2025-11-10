// src/main/java/com/zinngle/controller/PaymentController.java
package com.zinngle.controller;

import com.zinngle.dto.request.PaymentRequest;
import com.zinngle.dto.response.PaymentResponse;
import com.zinngle.security.JwtTokenProvider;
import com.zinngle.dto.request.VerifyPaymentRequest;
import com.zinngle.service.PaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/payments")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/create-order")
    public ResponseEntity<PaymentResponse> createOrder(
            @RequestHeader("Authorization") String token,
            @Valid @RequestBody PaymentRequest request) {
        UUID userId = jwtTokenProvider.getUserIdFromToken(token.substring(7));
        PaymentResponse response = paymentService.createPaymentOrder(userId, request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/verify")
    public ResponseEntity<PaymentResponse> verifyPayment(
            @RequestHeader("Authorization") String token,
            @RequestBody VerifyPaymentRequest request) {
        UUID userId = jwtTokenProvider.getUserIdFromToken(token.substring(7));
        PaymentResponse response = paymentService.verifyPayment(userId, request);
        return ResponseEntity.ok(response);
    }
}
