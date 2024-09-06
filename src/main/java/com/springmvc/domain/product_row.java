package com.springmvc.domain;

public class product_row {
    private int productId;
    private String name;
    private int price;
    private String brand;
    private String category;
    private String link;
    private String image;
    private String ingredientKorean;
    private String ingredientEnglish;
    private String warningLevel;
    
	public product_row() {
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

	public String getIngredientKorean() {
		return ingredientKorean;
	}

	public void setIngredientKorean(String ingredientKorean) {
		this.ingredientKorean = ingredientKorean;
	}

	public String getIngredientEnglish() {
		return ingredientEnglish;
	}

	public void setIngredientEnglish(String ingredientEnglish) {
		this.ingredientEnglish = ingredientEnglish;
	}

	public String getWarningLevel() {
		return warningLevel;
	}

	public void setWarningLevel(String warningLevel) {
		this.warningLevel = warningLevel;
	}
    
    
}
