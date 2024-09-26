package com.example.crud.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.crud.model.Food;
import com.example.crud.repository.FoodRepository;

@RestController //
@RequestMapping("/food")
@CrossOrigin
public class FoodController {
	@Autowired //
	FoodRepository foodRepository;
	
	@GetMapping("/")
	public List<Food> getAllFoods(){
		List<Food> foods = foodRepository.findAll(); 
		return foods;
	}
	
//	Get data by ID
	@GetMapping("/{id}")
	public Optional<Food> getFoodById(@PathVariable("id") int foodId) {
		Optional<Food> foodData = foodRepository.findById(foodId);
		return foodData;
	}
	
	@GetMapping("/category/{category}")
	public List<Food> getFoodByCategory(@PathVariable String category) {
        return foodRepository.findByCategory(category);
    }
	
	@GetMapping("/favorite")
	public List<Food> getFoodByFavorite() {
		return foodRepository.findByIsFavoriteTrue();
	}
//	Post data
	@PostMapping("/create")
	public ResponseEntity<Food> createFood(@RequestBody Food food) {
	    try {
	        Food newFood = foodRepository.save(food);  
	        return new ResponseEntity<>(newFood, HttpStatus.ACCEPTED); 
	    } catch (Exception e) {
	        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
//	Put Data
	@PutMapping("/edit/{id}")
	public ResponseEntity<Food> updatefood(@PathVariable("id") int foodId, @RequestBody Food food) {
		Optional<Food> foodData = foodRepository.findById(foodId);
		if (foodData.isPresent()) {
			Food _food = foodData.get();
			_food.setName(food.getName());
			_food.setPrice(food.getPrice());
			_food.setCookingTime(food.getCookingTime());
			_food.setRate(food.getRate());
			_food.setDescription(food.getDescription());
			_food.setFavorite(food.isFavorite());
			_food.setCategory(food.getCategory());
			_food.setQuantity(food.getQuantity());
			return new ResponseEntity<>(foodRepository.save(_food), HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PutMapping("/edit/favorite/{id}")
	public ResponseEntity<Food> updateFavorite(@PathVariable("id") int foodId, @RequestBody Food food) {
		Optional<Food> foodData = foodRepository.findById(foodId);
		if (foodData.isPresent()) {
			Food _food = foodData.get();
			_food.setFavorite(food.isFavorite());
			return new ResponseEntity<>(foodRepository.save(_food), HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
	@PutMapping("/edit/quantity/{id}")
	public ResponseEntity<Food> updateQuantity(@PathVariable("id") int foodId, @RequestBody Food food) {
		Optional<Food> foodData = foodRepository.findById(foodId);
		if (foodData.isPresent()) {
			Food _food = foodData.get();
			_food.setQuantity(food.getQuantity());
			return new ResponseEntity<>(foodRepository.save(_food), HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
//	Delete All
	@DeleteMapping("/delete")
	public void deleteAll() {
		foodRepository.deleteAll();
		foodRepository.resetIdentityColumn();
	}
	
//	Delete by Id
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<HttpStatus> deleteFoodById(@PathVariable("id") int foodId) {
		try {
			foodRepository.deleteById(foodId);
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}

