package com.example.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.example.crud.model.Order;
import com.example.crud.repository.FoodRepository;
import com.example.crud.repository.OrderRepository;


@RestController
@RequestMapping("/order")
@CrossOrigin
public class OrderController {
	
	@Autowired
	OrderRepository orderRepository;
	
	@Autowired
	FoodRepository foodRepository;
	
	@GetMapping("/")
	public List<Order> getAllOrders(){
		List<Order> orders = orderRepository.findAll(); 
		return orders;
	}
	
//	Get data by ID
	@GetMapping("/{id}")
	public Optional<Order> getOrderById(@PathVariable("id") int orderId) {
		Optional<Order> orderData = orderRepository.findById(orderId);
		return orderData;
	}
	
	@PostMapping("/create")
	public ResponseEntity<Order> createOrder(@RequestBody HashMap<String, Object> data) {
	    try {
	        Order order = new Order();
	        
	        if (data != null) {
	            if (data.containsKey("orderDateTime")) {
	                order.setOrderDateTime(data.get("orderDateTime").toString());
	            }
	            if (data.containsKey("food")) {
	                @SuppressWarnings("unchecked")
					List<Map<String, Object>> foodDataList = (List<Map<String, Object>>) data.get("food");
	                List<Food> foodList = new ArrayList<>();

	                for (Map<String, Object> foodData : foodDataList) {
	                    int id = (int) foodData.get("id");
	                    Food food = foodRepository.findById(id).get();
	                    food.setOrder(order);
	                    foodList.add(food);
	               
	                order.setFoods(foodList);
	                }
	            
	            }
	            orderRepository.save(order); 
	        }
	        return new ResponseEntity<>(order, HttpStatus.CREATED);
	    } catch (Exception e) {
	        return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
//	Put Data
	@PutMapping("/edit/{id}")
	public ResponseEntity<Order> updateOrder(@PathVariable("id") int orderId, @RequestBody Order order) {
		Optional<Order> orderData = orderRepository.findById(orderId);
		if (orderData.isPresent()) {
			Order _order = orderData.get();
			_order.setOrderDateTime(order.getOrderDateTime());
			return new ResponseEntity<>(orderRepository.save(_order), HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
//	Delete All
	@DeleteMapping("/delete")
	public void deleteAll() {
		orderRepository.deleteAll();
		orderRepository.resetIdentityColumn();
	}
	
//	Delete by Id
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<HttpStatus> deleteOrderById(@PathVariable("id") int orderId) {
		try {
			orderRepository.deleteById(orderId);
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
