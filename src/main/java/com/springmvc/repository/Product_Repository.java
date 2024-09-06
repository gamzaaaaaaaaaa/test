package com.springmvc.repository;

import java.util.List;

import com.springmvc.domain.product;
import com.springmvc.domain.product_connect;
import com.springmvc.domain.product_detail;
import com.springmvc.domain.product_ingredient;

public interface Product_Repository {
	
	public void saveProduct(product pd);
	public void saveIngredient(product_ingredient ingredient);
	public void saveConnect(product_connect connect);
	public boolean isProductExist(int productId);
	public boolean isIngredientExist(int ingredientId);
	public boolean isConnectExist(int connectId);
	public List<product_detail> getProductDetail(int offset, int limit);
	public void addProduct(product product);
	public int getLastInsertId();
    List<product_detail> getProductDetailByCategory(String category, int offset, int limit);
    int countProductByCategory(String category);
    public product_detail getProductDetailById(int productId);
    public int countProduct();
    public List<product> getProduct(int offset, int limit);
    public List<product> getProductByCategory(int limit, int offset, String category);
}
