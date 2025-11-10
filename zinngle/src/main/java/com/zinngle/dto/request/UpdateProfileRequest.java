package com.zinngle.dto.request;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class UpdateProfileRequest {
    private String fullName;
    private LocalDate dateOfBirth;
    private String gender;
    private String bio;
    private List<String> interests;
    private List<String> photos;
    private String fcmToken;
}
