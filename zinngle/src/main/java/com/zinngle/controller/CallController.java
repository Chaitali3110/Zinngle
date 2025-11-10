// src/main/java/com/zinngle/controller/CallController.java
package com.zinngle.controller;

import com.zinngle.dto.request.CallRequest;
import com.zinngle.dto.response.CallResponse;
import com.zinngle.security.JwtTokenProvider;
import com.zinngle.service.CallService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/calls")
@RequiredArgsConstructor
public class CallController {

    private final CallService callService;
    private final JwtTokenProvider jwtTokenProvider;

    @PostMapping("/initiate")
    public ResponseEntity<CallResponse> initiateCall(
            @RequestHeader("Authorization") String token,
            @Valid @RequestBody CallRequest request) {
        UUID userId = jwtTokenProvider.getUserIdFromToken(token.substring(7));
        CallResponse response = callService.initiateCall(userId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PostMapping("/{callId}/end")
    public ResponseEntity<CallResponse> endCall(@PathVariable UUID callId) {
        CallResponse response = callService.endCall(callId);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/history")
    public ResponseEntity<List<CallResponse>> getCallHistory(
            @RequestHeader("Authorization") String token) {
        UUID userId = jwtTokenProvider.getUserIdFromToken(token.substring(7));
        List<CallResponse> response = callService.getUserCallHistory(userId);
        return ResponseEntity.ok(response);
    }
}
