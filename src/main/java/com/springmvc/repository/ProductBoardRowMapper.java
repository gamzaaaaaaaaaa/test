package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.productboard;

public class ProductBoardRowMapper implements RowMapper<productboard> {
	 
	@Override
	    public productboard mapRow(ResultSet rs, int rowNum) throws SQLException {
			productboard pd = new productboard();
			pd.setNum(rs.getInt("num"));
			pd.setId(rs.getString("id"));
			pd.setProduct_id(rs.getInt("product_id"));
			pd.setRegistDay(rs.getString("registDay"));
			pd.setHit(rs.getInt("hit"));
			pd.setIp(rs.getString("ip"));
	        return pd;
	}
}
