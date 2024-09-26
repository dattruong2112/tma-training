package com.example.crud.model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "foods")
public class Food {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int foodId;
	
	@Column(name = "image")
	private String image;
	
	@Column(name = "name")
	private String name;
	
	@Column(name = "price")
	private float price;
	
	@Column(name = "rate")
	private float rate;
	
	@Column(name = "cookingTime")
	private String cookingTime;
	
	@Column(name = "description")
	private String description;
	
	@Column(name = "category")
	private String category;
	
	@Column(name = "isFavorite")
	private boolean isFavorite;
	
	@Column(name = "quantity")
	private int quantity;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "orderId")
	private Order order;
	
	public void setOrder(Order order) {
		this.order = order;
	}
	
	public Order getOrder() {
		return order;
	}
	
	public Food(int foodId, String image, String name, float price, float rate, String cookingTime, String description,
			String category, boolean isFavorite, int quantity) {
		super();
		this.foodId = foodId;
		this.image = image;
		this.name = name;
		this.price = price;
		this.rate = rate;
		this.cookingTime = cookingTime;
		this.description = description;
		this.category = category;
		this.isFavorite = isFavorite;
		this.quantity = quantity;
	}

	public Food() {
		super();
	}

	public int getId() {
		return foodId;
	}

	public void setId(int id) {
		this.foodId = id;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public float getRate() {
		return rate;
	}

	public void setRate(float rate) {
		this.rate = rate;
	}

	public String getCookingTime() {
		return cookingTime;
	}

	public void setCookingTime(String cookingTime) {
		this.cookingTime = cookingTime;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public boolean isFavorite() {
		return isFavorite;
	}
	

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public void setFavorite(boolean isFavorite) {
		this.isFavorite = isFavorite;
	}
	
	@Override
	public String toString() {
		return "Food "
				+ "[foodId=" + foodId +
				", name= " + name + 
				", price=" + price + 
				", rate=" + rate + 
				", cookingTime=" + cookingTime + 
				", desc=" + description + 
				", category=" + category + 
				", image=" + image +
				", quantity=" + quantity +
				", isFavorite=" + isFavorite +
				"]";	
	}
}
