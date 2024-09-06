package com.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.domain.product;
import com.springmvc.domain.product_connect;
import com.springmvc.domain.product_detail;
import com.springmvc.domain.product_ingredient;
import com.springmvc.repository.Product_Repository;

@Service
public class ProductService {

    @Autowired
    Product_Repository dao;

    public boolean isProductExist(int productId) {
        return dao.isProductExist(productId);
    }

    public boolean isIngredientExist(int ingredientId) {
        return dao.isIngredientExist(ingredientId);
    }

    public boolean isConnectExist(int connectId) {
        return dao.isConnectExist(connectId);
    }

    public void processProduct(product pd) {
        System.out.println("product: " + pd);
        dao.saveProduct(pd);
    }

    public void processIngredient(product_ingredient ingredient) {
        System.out.println("ingredient: " + ingredient);
        dao.saveIngredient(ingredient);
    }

    public void processConnect(product_connect connect) {
        System.out.println("connect: " + connect);
        dao.saveConnect(connect);
    }

    public List<product_detail> getProductDetail(int offset, int limit){
        return dao.getProductDetail(offset, limit);
    }

    public List<product_detail> getProductDetailByCategory(String category, int offset, int limit) {
    	return dao.getProductDetailByCategory(category, offset, limit);
    }

    public int countProductByCategory(String category) {
    	return dao.countProductByCategory(category);
    }
    
    public int countProduct() {
    	int num = dao.countProduct();
    	return num;
    }
    
    public List<product> getProduct(int offset, int limit){
    	return dao.getProduct(offset, limit);
    }
    
    public List<product> getProductByCategory(int limit, int offset, String category){
    	return dao.getProductByCategory(limit, offset, category);
    }
}
