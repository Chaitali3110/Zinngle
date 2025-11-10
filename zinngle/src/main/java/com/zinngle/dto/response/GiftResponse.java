package com.zinngle.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
public class GiftResponse {
    private UUID id;
    private String name;
    private String icon;
    private Integer price;
    private String category;
    private LocalDateTime createdAt;
}
