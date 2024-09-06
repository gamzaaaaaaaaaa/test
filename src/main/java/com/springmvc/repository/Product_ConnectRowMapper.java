package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.product_connect;


public class Product_ConnectRowMapper implements RowMapper<product_connect> {
	
	 @Override
	    public product_connect mapRow(ResultSet rs, int rowNum) throws SQLException {
		 	product_connect pdc = new product_connect();
			pdc.setId(rs.getInt("id"));
			pdc.setProduct_id(rs.getInt("product_id"));
			pdc.setIngredient_id(rs.getInt("ingredient_id"));
			pdc.setWarning_level(rs.getString("warning_level"));
	        return pdc;
	    }

}
