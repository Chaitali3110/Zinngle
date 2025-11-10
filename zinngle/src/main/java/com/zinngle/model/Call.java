// src/main/java/com/zinngle/model/Call.java
package com.zinngle.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "calls")
@EntityListeners(AuditingEntityListener.class)
public class Call {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne
    @JoinColumn(name = "caller_id", nullable = false)
    private User caller;

    @ManyToOne
    @JoinColumn(name = "creator_id", nullable = false)
    private Creator creator;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CallType callType;

    @Enumerated(EnumType.STRING)
    @Builder.Default
    @Column(nullable = false)
    private CallStatus status = CallStatus.INITIATED;

    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Integer durationSeconds;

    @Column(precision = 10, scale = 2)
    private BigDecimal totalCost;

    private String agoraChannelName;
    
    @Column(columnDefinition = "TEXT")
    private String agoraToken;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    public enum CallType {
        VIDEO, AUDIO
    }

    public enum CallStatus {
        INITIATED, RINGING, ACCEPTED, ONGOING, ENDED, MISSED, REJECTED
    }
}
