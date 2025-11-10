// src/main/java/com/zinngle/service/CreatorService.java
package com.zinngle.service;

import com.zinngle.dto.request.CreatorApplicationRequest;
import com.zinngle.dto.response.CreatorResponse;
import com.zinngle.exception.BadRequestException;
import com.zinngle.model.Creator;
import com.zinngle.model.User;
import com.zinngle.repository.CreatorRepository;
import com.zinngle.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CreatorService {

    private final CreatorRepository creatorRepository;
    private final UserRepository userRepository;

    @Transactional
    public CreatorResponse createCreatorApplication(CreatorApplicationRequest request) {
        User user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new BadRequestException("User not found"));

        if (user.getIsCreator()) {
            throw new BadRequestException("User is already a creator");
        }

        Creator creator = Creator.builder()
                .user(user)
                .idType(request.getIdType())
                .idNumber(request.getIdNumber())
                .videoPricePerMin(request.getVideoPricePerMin())
                .audioPricePerMin(request.getAudioPricePerMin())
                .categories(request.getCategories())
                .languages(request.getLanguages())
                .verificationStatus(Creator.VerificationStatus.PENDING)
                .build();

        creator = creatorRepository.save(creator);
        return mapToCreatorResponse(creator);
    }

    public Page<CreatorResponse> getAvailableCreators(Pageable pageable) {
        Page<Creator> creators = creatorRepository.findAvailableCreators(pageable);
        return creators.map(this::mapToCreatorResponse);
    }

    public Page<CreatorResponse> getCreatorsByCategory(String category, Pageable pageable) {
        Page<Creator> creators = creatorRepository.findByCategory(category, pageable);
        return creators.map(this::mapToCreatorResponse);
    }

    public CreatorResponse getCreatorById(UUID creatorId) {
        Creator creator = creatorRepository.findById(creatorId)
                .orElseThrow(() -> new BadRequestException("Creator not found"));
        return mapToCreatorResponse(creator);
    }

    private CreatorResponse mapToCreatorResponse(Creator creator) {
        return CreatorResponse.builder()
                .creatorId(creator.getId())
                .userId(creator.getUser().getId())
                .fullName(creator.getUser().getFullName())
                .profileImage(creator.getUser().getProfileImageUrl())
                .bio(creator.getUser().getBio())
                .videoPricePerMin(creator.getVideoPricePerMin())
                .audioPricePerMin(creator.getAudioPricePerMin())
                .averageRating(creator.getAverageRating() != null ? creator.getAverageRating().doubleValue() : null)
                .totalCalls(creator.getTotalCalls())
                .categories(creator.getCategories())
                .languages(creator.getLanguages())
                .isAvailable(creator.getIsAvailable())
                .verificationStatus(creator.getVerificationStatus().name())
                .build();
    }
}
