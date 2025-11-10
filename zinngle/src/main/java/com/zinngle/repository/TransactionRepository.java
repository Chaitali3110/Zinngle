// src/main/java/com/zinngle/repository/TransactionRepository.java
package com.zinngle.repository;

import com.zinngle.model.Transaction;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, UUID> {
    Page<Transaction> findByUserId(UUID userId, Pageable pageable);
    Page<Transaction> findByUserIdAndTransactionType(UUID userId, 
                                                     Transaction.TransactionType type, 
                                                     Pageable pageable);
    Optional<Transaction> findByOrderId(String orderId);
}
