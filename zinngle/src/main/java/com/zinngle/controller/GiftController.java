// src/main/java/com/zinngle/controller/GiftController.java
package com.zinngle.controller;

import com.zinngle.dto.response.GiftResponse;
import com.zinngle.dto.request.SendGiftRequest;
import com.zinngle.service.GiftService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/gifts")
@RequiredArgsConstructor
public class GiftController {

    private final GiftService giftService;

    @GetMapping
    public ResponseEntity<List<GiftResponse>> getAllGifts() {
        List<GiftResponse> gifts = giftService.getAllGifts();
        return ResponseEntity.ok(gifts);
    }

    @GetMapping("/category/{category}")
    public ResponseEntity<List<GiftResponse>> getGiftsByCategory(@PathVariable String category) {
        List<GiftResponse> gifts = giftService.getGiftsByCategory(category);
        return ResponseEntity.ok(gifts);
    }

    @PostMapping("/send")
    public ResponseEntity<Void> sendGift(@RequestBody SendGiftRequest request) {
        giftService.sendGift(request);
        return ResponseEntity.ok().build();
    }
}
