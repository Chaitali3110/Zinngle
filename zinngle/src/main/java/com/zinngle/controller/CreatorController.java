// src/main/java/com/zinngle/controller/CreatorController.java
package com.zinngle.controller;

import com.zinngle.dto.request.CreatorApplicationRequest;
import com.zinngle.dto.response.CreatorResponse;
import com.zinngle.service.CreatorService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/creators")
@RequiredArgsConstructor
public class CreatorController {

    private final CreatorService creatorService;

    @GetMapping
    public ResponseEntity<Page<CreatorResponse>> getCreators(Pageable pageable) {
        Page<CreatorResponse> response = creatorService.getAvailableCreators(pageable);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{creatorId}")
    public ResponseEntity<CreatorResponse> getCreator(@PathVariable UUID creatorId) {
        CreatorResponse response = creatorService.getCreatorById(creatorId);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/apply")
    public ResponseEntity<CreatorResponse> applyAsCreator(
            @Valid @RequestBody CreatorApplicationRequest request) {
        CreatorResponse response = creatorService.createCreatorApplication(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<Page<CreatorResponse>> getCreatorsByCategory(
            @PathVariable String category,
            Pageable pageable) {
        Page<CreatorResponse> response = creatorService.getCreatorsByCategory(category, pageable);
        return ResponseEntity.ok(response);
    }
}
