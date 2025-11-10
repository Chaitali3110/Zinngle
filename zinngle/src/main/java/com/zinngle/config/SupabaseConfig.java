// src/main/java/com/zinngle/config/SupabaseConfig.java
package com.zinngle.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Getter
@Configuration
public class SupabaseConfig {

    @Value("${supabase.url}")
    private String supabaseUrl;

    @Value("${supabase.anon.key}")
    private String anonKey;

    @Value("${supabase.service.role.key}")
    private String serviceRoleKey;

    public String getAuthUrl() {
        return supabaseUrl + "/auth/v1";
    }

    public String getRestUrl() {
        return supabaseUrl + "/rest/v1";
    }

    public String getStorageUrl() {
        return supabaseUrl + "/storage/v1";
    }
}
