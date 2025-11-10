// src/main/java/com/zinngle/service/AgoraService.java
package com.zinngle.service;

// Removed: import io.agora.rtc.RtcTokenBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class AgoraService {

    @Value("${agora.app.id}")
    private String appId;

    @Value("${agora.app.certificate}")
    private String appCertificate;

    public String generateToken(String channelName, UUID userId) {
        // Temporarily returning a dummy token until Agora SDK dependency is resolved
        return "DUMMY_AGORA_TOKEN"; 
    }
}
