// src/main/java/com/zinngle/repository/GiftRepository.java
package com.zinngle.repository;

import com.zinngle.model.Gift;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface GiftRepository extends JpaRepository<Gift, UUID> {
    List<Gift> findByCategory(String category);
}
