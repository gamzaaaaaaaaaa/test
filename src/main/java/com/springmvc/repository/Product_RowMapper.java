package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.product_row;

public class Product_RowMapper implements RowMapper<product_row> {
    
	@Override
    public product_row mapRow(ResultSet rs, int rowNum) throws SQLException {
    	product_row row = new product_row();
        row.setProductId(rs.getInt("product_id"));
        row.setName(rs.getString("name"));
        row.setPrice(rs.getInt("price"));
        row.setBrand(rs.getString("brand"));
        row.setCategory(rs.getString("category"));
        row.setLink(rs.getString("link"));
        row.setImage(rs.getString("image"));
        row.setIngredientKorean(rs.getString("ingredient_korean"));
        row.setIngredientEnglish(rs.getString("ingredient_english"));
        row.setWarningLevel(rs.getString("warning_level"));
        return row;
    }
}
