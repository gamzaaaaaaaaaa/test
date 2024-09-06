package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.mom;

public class momRowMapper implements RowMapper<mom>{
	public mom mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		mom mother = new mom();
		mother.setLastday(rs.getString("lastday"));
        mother.setFirst_visit(rs.getString("first_visit"));
		mother.setName(rs.getString("name"));
		return mother;
	}

}
