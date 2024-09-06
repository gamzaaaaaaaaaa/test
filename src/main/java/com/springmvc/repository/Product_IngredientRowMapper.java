package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.product_ingredient;

public class Product_IngredientRowMapper implements RowMapper<product_ingredient> {
	
	 @Override
	    public product_ingredient mapRow(ResultSet rs, int rowNum) throws SQLException {
		 	product_ingredient pdi = new product_ingredient();
		 	pdi.setIngredient_id(rs.getInt("ingredient_id"));
		 	pdi.setKorean(rs.getString("korean"));
		 	pdi.setEnglish(rs.getString("english"));
	        return pdi;
	    }

}
