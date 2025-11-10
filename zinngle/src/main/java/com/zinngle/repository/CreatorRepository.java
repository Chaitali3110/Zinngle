// src/main/java/com/zinngle/repository/CreatorRepository.java
package com.zinngle.repository;

import com.zinngle.model.Creator;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface CreatorRepository extends JpaRepository<Creator, UUID> {
    Optional<Creator> findByUserId(UUID userId);
    
    @Query("SELECT c FROM Creator c WHERE c.verificationStatus = 'APPROVED' AND c.isAvailable = true")
    Page<Creator> findAvailableCreators(Pageable pageable);
    
    @Query("SELECT c FROM Creator c WHERE c.verificationStatus = 'APPROVED' " +
           "AND c.isAvailable = true AND :category MEMBER OF c.categories")
    Page<Creator> findByCategory(String category, Pageable pageable);
}
