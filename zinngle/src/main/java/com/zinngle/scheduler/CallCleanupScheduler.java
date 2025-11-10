// src/main/java/com/zinngle/scheduler/CallCleanupScheduler.java
package com.zinngle.scheduler;

import com.zinngle.model.Call;
import com.zinngle.repository.CallRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class CallCleanupScheduler {

    private final CallRepository callRepository;

    @Scheduled(cron = "0 0 */6 * * *") // Every 6 hours
    @Transactional
    public void cleanupStaleCalls() {
        log.info("Starting cleanup of stale calls");
        
        LocalDateTime thresholdTime = LocalDateTime.now().minusHours(24);
        List<Call> staleCalls = callRepository.findAll().stream()
                .filter(call -> call.getStatus() == Call.CallStatus.INITIATED 
                        || call.getStatus() == Call.CallStatus.RINGING)
                .filter(call -> call.getCreatedAt().isBefore(thresholdTime))
                .toList();

        staleCalls.forEach(call -> {
            call.setStatus(Call.CallStatus.MISSED);
            callRepository.save(call);
        });

        log.info("Cleaned up {} stale calls", staleCalls.size());
    }
}
