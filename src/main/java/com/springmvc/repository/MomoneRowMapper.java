package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.mom;


public class MomoneRowMapper implements RowMapper<mom>{
	public mom mapRow(ResultSet rs, int rowNum) throws SQLException {
		mom mother = new mom();
		mother.setName(rs.getString(1));
		mother.setLastday(rs.getString(2));
		mother.setFirst_visit(rs.getString(3));
		mother.setWeeksPregnant(rs.getLong(4));
		mother.setVisitFrequency(rs.getInt(5));
		mother.setNextVisitDate(rs.getString(6));
		mother.setDueDate(rs.getString(7));
		return mother;
	}
}
