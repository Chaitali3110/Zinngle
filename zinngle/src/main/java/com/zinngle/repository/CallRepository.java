// src/main/java/com/zinngle/repository/CallRepository.java
package com.zinngle.repository;

import com.zinngle.model.Call;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface CallRepository extends JpaRepository<Call, UUID> {
    Page<Call> findByCallerId(UUID callerId, Pageable pageable);
    Page<Call> findByCreatorId(UUID creatorId, Pageable pageable);
    
    @Query("SELECT c FROM Call c WHERE (c.caller.id = :userId OR c.creator.user.id = :userId) " +
           "ORDER BY c.createdAt DESC")
    List<Call> findUserCallHistory(UUID userId);
}
