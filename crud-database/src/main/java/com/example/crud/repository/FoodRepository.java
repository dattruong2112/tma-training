package com.example.crud.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.crud.model.Food;

import jakarta.transaction.Transactional;


@Repository
public interface FoodRepository extends JpaRepository<Food, Integer>{
	List<Food> findByCategory(String category);
	List<Food> findByIsFavoriteTrue();
	
	@Modifying
    @Transactional
    @Query(value = "DBCC CHECKIDENT ('foods', RESEED, 0)", nativeQuery = true)
    void resetIdentityColumn();
}
