package com.zinngle.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Data
public class CreatorApplicationRequest {

    @NotNull(message = "User ID is required")
    private UUID userId;

    @NotBlank(message = "ID Type is required")
    private String idType; // e.g., Aadhar, Passport

    @NotBlank(message = "ID Number is required")
    private String idNumber;

    @NotNull(message = "Video price per minute is required")
    private BigDecimal videoPricePerMin;

    @NotNull(message = "Audio price per minute is required")
    private BigDecimal audioPricePerMin;

    private List<String> categories;
    private List<String> languages;
}
