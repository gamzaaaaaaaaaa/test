package com.springmvc.domain;

import java.util.List;

public class product_detail {
	private int productId;
	private String name;
	private int price;
	private String brand;
	private String category;
	private String link;
	private String image;
    private List<product_connect_detail> ingredients; // 성분과 경고 수준을 함께 담는 리스트
	
	public product_detail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
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

	public List<product_connect_detail> getIngredients() {
        return ingredients;
    }

    public void setIngredients(List<product_connect_detail> ingredients) {
        this.ingredients = ingredients;
    }
	

    @Override
    public String toString() {
        return "product_detail{" +
               "productId=" + productId +
               ", name='" + name + '\'' +
               ", price=" + price +
               ", brand='" + brand + '\'' +
               ", category='" + category + '\'' +
               ", link='" + link + '\'' +
               ", image='" + image + '\'' +
               ", ingredients=" + ingredients +
               '}';
    }
	
	
}
