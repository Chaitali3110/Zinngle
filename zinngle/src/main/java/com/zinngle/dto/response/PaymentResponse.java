package com.zinngle.dto.response;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class PaymentResponse {
    private String orderId;
    private String paymentId;
    private BigDecimal amount;
    private String currency;
    private String status; // e.g., PENDING, COMPLETED, FAILED
}