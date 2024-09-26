package com.example.crud.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.example.crud.model.Order;

import jakarta.transaction.Transactional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer>{
	
	@Modifying
    @Transactional
    @Query(value = "DBCC CHECKIDENT ('orders', RESEED, 0)", nativeQuery = true)
    void resetIdentityColumn();
}
