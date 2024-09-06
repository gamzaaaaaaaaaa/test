package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.childinfo;

public class ChildinfoRowMapper implements RowMapper<childinfo> {
    @Override
    public childinfo mapRow(ResultSet rs, int rowNum) throws SQLException {
    	childinfo info = new childinfo();
    	info.setAge_info(rs.getString("age_info"));
    	info.setHeight(rs.getString("height"));
    	info.setWeight(rs.getString("weight"));
    	info.setDevelopment(rs.getString("development"));
        return info;
    }
}
