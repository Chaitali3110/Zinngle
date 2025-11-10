// src/main/java/com/zinngle/model/Creator.java
package com.zinngle.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "creators")
@EntityListeners(AuditingEntityListener.class)
public class Creator {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Builder.Default
    private VerificationStatus verificationStatus = VerificationStatus.PENDING;

    private String idType;
    private String idNumber;
    private String idFrontImageUrl;
    private String idBackImageUrl;
    private String selfieImageUrl;

    @Column(precision = 10, scale = 2)
    private BigDecimal videoPricePerMin;

    @Column(precision = 10, scale = 2)
    private BigDecimal audioPricePerMin;

    @Builder.Default
    @Column(precision = 10, scale = 2)
    private BigDecimal totalEarnings = BigDecimal.ZERO;

    @Builder.Default
    private Integer totalCalls = 0;

    @Builder.Default
    @Column(precision = 3, scale = 2)
    private BigDecimal averageRating = BigDecimal.ZERO;

    @Builder.Default
    @Column(nullable = false)
    private Boolean isAvailable = true;

    @ElementCollection
    @CollectionTable(name = "creator_categories", joinColumns = @JoinColumn(name = "creator_id"))
    @Column(name = "category")
    private List<String> categories;

    @ElementCollection
    @CollectionTable(name = "creator_languages", joinColumns = @JoinColumn(name = "creator_id"))
    @Column(name = "language")
    private List<String> languages;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    public enum VerificationStatus {
        PENDING, APPROVED, REJECTED
    }
}
