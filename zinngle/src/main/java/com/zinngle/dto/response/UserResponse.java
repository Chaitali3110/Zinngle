package com.zinngle.dto.response;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
public class UserResponse {
    private UUID userId;
    private String email;
    private String phoneNumber;
    private String fullName;
    private LocalDate dateOfBirth;
    private String gender;
    private String bio;
    private String profileImageUrl;
    private Boolean isCreator;
    private Boolean isOnline;
    private LocalDateTime lastSeen;
    private BigDecimal coinsBalance;
    private String role;
    private Boolean isActive;
    private Boolean isVerified;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<String> interests;
}