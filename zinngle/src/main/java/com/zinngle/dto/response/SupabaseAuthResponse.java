// src/main/java/com/zinngle/dto/response/SupabaseAuthResponse.java
package com.zinngle.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class SupabaseAuthResponse {
    
    @JsonProperty("access_token")
    private String accessToken;
    
    @JsonProperty("refresh_token")
    private String refreshToken;
    
    @JsonProperty("expires_in")
    private Long expiresIn;
    
    @JsonProperty("token_type")
    private String tokenType;
    
    private SupabaseUser user;
    
    @Data
    public static class SupabaseUser {
        private String id;
        private String email;
        
        @JsonProperty("email_confirmed_at")
        private String emailConfirmedAt;
        
        @JsonProperty("phone")
        private String phone;
        
        @JsonProperty("created_at")
        private String createdAt;
        
        @JsonProperty("updated_at")
        private String updatedAt;
    }
}
