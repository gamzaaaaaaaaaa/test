package com.springmvc.domain;

public class product {
	private int product_id;
	private String name;
	private int price;
	private String brand;
	private String category;
	private String link;
	private String image;
	
	public product() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public product(String name, int price, String brand, String category, String link, String image) {
		super();
		this.name = name;
		this.price = price;
		this.brand = brand;
		this.category = category;
		this.link = link;
		this.image = image;
	}




	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
	
}
