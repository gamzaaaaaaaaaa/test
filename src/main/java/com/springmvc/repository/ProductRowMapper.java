package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.product;

public class ProductRowMapper implements RowMapper<product> {
	
	 @Override
	    public product mapRow(ResultSet rs, int rowNum) throws SQLException {
		 product pd = new product();
	    	pd.setProduct_id(rs.getInt("product_id"));
	    	pd.setName(rs.getString("name"));
	    	pd.setPrice(rs.getInt("price"));
	    	pd.setBrand(rs.getString("brand"));
	    	pd.setCategory(rs.getString("category"));
	    	pd.setLink(rs.getString("link"));
	    	pd.setImage(rs.getString("image"));
	        return pd;
	    }

}
