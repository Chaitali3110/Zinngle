// src/main/java/com/zinngle/service/SupabaseAuthService.java
package com.zinngle.service;

import com.zinngle.config.SupabaseConfig;
import com.zinngle.dto.response.SupabaseAuthResponse;
import com.zinngle.exception.BadRequestException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class SupabaseAuthService {

    private final SupabaseConfig supabaseConfig;
    private final RestTemplate restTemplate = new RestTemplate();

    public SupabaseAuthResponse signUpWithEmail(String email, String password) {
        String url = supabaseConfig.getAuthUrl() + "/signup";
        
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("email", email);
        requestBody.put("password", password);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("apikey", supabaseConfig.getAnonKey());

        HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);

        try {
            ResponseEntity<SupabaseAuthResponse> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    request,
                    SupabaseAuthResponse.class
            );
            return response.getBody();
        } catch (Exception e) {
            log.error("Error signing up user: {}", e.getMessage());
            throw new BadRequestException("Failed to sign up user");
        }
    }

    public SupabaseAuthResponse signInWithEmail(String email, String password) {
        String url = supabaseConfig.getAuthUrl() + "/token?grant_type=password";
        
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("email", email);
        requestBody.put("password", password);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("apikey", supabaseConfig.getAnonKey());

        HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);

        try {
            ResponseEntity<SupabaseAuthResponse> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    request,
                    SupabaseAuthResponse.class
            );
            return response.getBody();
        } catch (Exception e) {
            log.error("Error signing in user: {}", e.getMessage());
            throw new BadRequestException("Invalid credentials");
        }
    }

    public void signOut(String accessToken) {
        String url = supabaseConfig.getAuthUrl() + "/logout";

        HttpHeaders headers = new HttpHeaders();
        headers.set("apikey", supabaseConfig.getAnonKey());
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<Void> request = new HttpEntity<>(headers);

        try {
            restTemplate.exchange(url, HttpMethod.POST, request, Void.class);
        } catch (Exception e) {
            log.error("Error signing out user: {}", e.getMessage());
        }
    }

    public SupabaseAuthResponse refreshToken(String refreshToken) {
        String url = supabaseConfig.getAuthUrl() + "/token?grant_type=refresh_token";
        
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("refresh_token", refreshToken);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("apikey", supabaseConfig.getAnonKey());

        HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);

        try {
            ResponseEntity<SupabaseAuthResponse> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    request,
                    SupabaseAuthResponse.class
            );
            return response.getBody();
        } catch (Exception e) {
            log.error("Error refreshing token: {}", e.getMessage());
            throw new BadRequestException("Failed to refresh token");
        }
    }
}
