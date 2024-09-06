package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.review;

public class ReviewRowMapper implements RowMapper<review> {

    @Override
    public review mapRow(ResultSet rs, int rowNum) throws SQLException {
    	review rv = new review();
    	rv.setNum(rs.getInt("num"));
    	rv.setId(rs.getString("id"));
    	rv.setParentsNum(rs.getInt("parentsNum"));
    	rv.setScore(rs.getInt("score"));
    	rv.setContent(rs.getString("content"));
    	rv.setRegistDay(rs.getString("registDay"));
        return rv;
    }
}
