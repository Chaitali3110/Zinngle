package com.zinngle.dto.response;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
public class CreatorResponse {
    private UUID creatorId;
    private UUID userId;
    private String fullName;
    private String profileImage;
    private String bio;
    private BigDecimal videoPricePerMin;
    private BigDecimal audioPricePerMin;
    private Double averageRating; // Assuming a rating out of 5, can be double
    private Integer totalCalls;
    private List<String> categories;
    private List<String> languages;
    private Boolean isAvailable;
    private String verificationStatus; // PENDING, APPROVED, REJECTED
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
