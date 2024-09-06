package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.child;

public class ChildRowMapper implements RowMapper<child>{
	public child mapRow(ResultSet rs, int rowNum) throws SQLException {
		child baby = new child();
		baby.setNum(rs.getInt("num"));
		baby.setId(rs.getString("id"));
		baby.setBirth(rs.getString("birth"));
		baby.setDay(rs.getString("day"));
		baby.setHeight(rs.getString("height"));
		baby.setWeight(rs.getString("weight"));
		baby.setHead(rs.getString("head"));
		baby.setGender(rs.getString("gender"));
		baby.setName(rs.getString("name"));
		return baby;
	}
}
