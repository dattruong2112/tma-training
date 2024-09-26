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

import com.example.crud.model.User;
import com.example.crud.repository.UserRepository;

@RestController //
@RequestMapping("/user")
@CrossOrigin

public class UserController {
	@Autowired //
	UserRepository userRepository;
	
	@GetMapping("/")
	public List<User> getAllUser(){
		List<User> users = userRepository.findAll(); 
		return users;
	}
	
//	Get data by ID
	@GetMapping("/{id}")
	public Optional<User> getUserById(@PathVariable("id") int userId) {
		Optional<User> userData = userRepository.findById(userId);
		return userData;
	}
	
//	Post data
	@PostMapping("/create")
	public ResponseEntity<String> createUser(@RequestBody User user) {
	    Optional<User> existingUser = userRepository.findByEmail(user.getEmail());
	    if (existingUser.isPresent()) {
	        return new ResponseEntity<>("Email already exists", HttpStatus.CONFLICT);
	    }

	    try {
	        @SuppressWarnings("unused")
			User newUser = userRepository.save(user);  
	        return new ResponseEntity<>("User created successfully", HttpStatus.CREATED); 
	    } catch (Exception e) {
	        return new ResponseEntity<>("Error occurred while creating user", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	
	@PostMapping("/login")
	public ResponseEntity<String> loginUser(@RequestBody User loginUser) {
	    Optional<User> userData = userRepository.findByEmail(loginUser.getEmail().toLowerCase());

	    if (userData.isPresent()) {
	        User user = userData.get();

	        if (user.getPassword().equals(loginUser.getPassword())) {
	            return new ResponseEntity<>("Login successful", HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>("Invalid password", HttpStatus.UNAUTHORIZED);
	        }
	    } else {
	        return new ResponseEntity<>("User not found", HttpStatus.NOT_FOUND);
	    }
	}


	
//	Put Data
	@PutMapping("/edit/{id}")
	public ResponseEntity<User> updateUser(@PathVariable("id") int userId, @RequestBody User user) {
		Optional<User> userData = userRepository.findById(userId);
		if (userData.isPresent()) {
			User _user = userData.get();
			_user.setName(user.getName());
			_user.setEmail(user.getEmail());
			_user.setPassword(user.getPassword());
			_user.setRole(user.getRole());
			_user.setBio(user.getBio());
			return new ResponseEntity<>(userRepository.save(_user), HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	
//	Delete All
	@DeleteMapping("/delete")
	public void deleteAll() {
		userRepository.deleteAll();
		userRepository.resetIdentityColumn();
	}
	
//	Delete by Id
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<HttpStatus> deleteUserById(@PathVariable("id") int userId) {
		try {
			userRepository.deleteById(userId);
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}

