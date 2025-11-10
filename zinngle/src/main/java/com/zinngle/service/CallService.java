// src/main/java/com/zinngle/service/CallService.java
package com.zinngle.service;

import com.zinngle.dto.request.CallRequest;
import com.zinngle.dto.response.CallResponse;
import com.zinngle.exception.BadRequestException;
import com.zinngle.model.Call;
import com.zinngle.model.Creator;
import com.zinngle.model.User;
import com.zinngle.repository.CallRepository;
import com.zinngle.repository.CreatorRepository;
import com.zinngle.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CallService {

    private final CallRepository callRepository;
    private final UserRepository userRepository;
    private final CreatorRepository creatorRepository;
    private final AgoraService agoraService;
    private final WalletService walletService;

    @Transactional
    public CallResponse initiateCall(UUID callerId, CallRequest request) {
        User caller = userRepository.findById(callerId)
                .orElseThrow(() -> new BadRequestException("Caller not found"));

        Creator creator = creatorRepository.findById(request.getCreatorId())
                .orElseThrow(() -> new BadRequestException("Creator not found"));

        if (!creator.getIsAvailable()) {
            throw new BadRequestException("Creator is not available");
        }

        String channelName = UUID.randomUUID().toString();
        String agoraToken = agoraService.generateToken(channelName, callerId);

        Call call = Call.builder()
                .caller(caller)
                .creator(creator)
                .callType(Call.CallType.valueOf(request.getCallType()))
                .status(Call.CallStatus.INITIATED)
                .agoraChannelName(channelName)
                .agoraToken(agoraToken)
                .build();

        call = callRepository.save(call);

        return mapToCallResponse(call);
    }

    @Transactional
    public CallResponse endCall(UUID callId) {
        Call call = callRepository.findById(callId)
                .orElseThrow(() -> new BadRequestException("Call not found"));

        call.setEndTime(LocalDateTime.now());
        
        if (call.getStartTime() != null) {
            long seconds = Duration.between(call.getStartTime(), call.getEndTime()).getSeconds();
            call.setDurationSeconds((int) seconds);

            BigDecimal pricePerMin = call.getCallType() == Call.CallType.VIDEO
                    ? call.getCreator().getVideoPricePerMin()
                    : call.getCreator().getAudioPricePerMin();

            BigDecimal minutes = BigDecimal.valueOf(seconds).divide(BigDecimal.valueOf(60));
            BigDecimal totalCost = pricePerMin.multiply(minutes);
            call.setTotalCost(totalCost);

            // Deduct from caller's wallet
            walletService.deductCoins(call.getCaller().getId(), totalCost);

            // Add to creator's earnings
            BigDecimal creatorEarnings = totalCost.multiply(BigDecimal.valueOf(0.7)); // 70%
            walletService.addCreatorEarnings(call.getCreator().getId(), creatorEarnings);
        }

        call.setStatus(Call.CallStatus.ENDED);
        call = callRepository.save(call);

        return mapToCallResponse(call);
    }

    public List<CallResponse> getUserCallHistory(UUID userId) {
        List<Call> calls = callRepository.findUserCallHistory(userId);
        return calls.stream()
                .map(this::mapToCallResponse)
                .collect(Collectors.toList());
    }

    private CallResponse mapToCallResponse(Call call) {
        return CallResponse.builder()
                .callId(call.getId())
                .callerName(call.getCaller().getFullName())
                .creatorName(call.getCreator().getUser().getFullName())
                .callType(call.getCallType().name())
                .status(call.getStatus().name())
                .durationSeconds(call.getDurationSeconds())
                .totalCost(call.getTotalCost())
                .agoraChannelName(call.getAgoraChannelName())
                .agoraToken(call.getAgoraToken())
                .createdAt(call.getCreatedAt())
                .build();
    }
}
