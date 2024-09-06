package com.springmvc.domain;

public class product_connect {
	private int id;
	private int product_id;
	private int ingredient_id;
	private String warning_level;
	
	public product_connect() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getIngredient_id() {
		return ingredient_id;
	}

	public void setIngredient_id(int ingredient_id) {
		this.ingredient_id = ingredient_id;
	}

	public String getWarning_level() {
		return warning_level;
	}

	public void setWarning_level(String warning_level) {
		this.warning_level = warning_level;
	}
	
	
	
}
