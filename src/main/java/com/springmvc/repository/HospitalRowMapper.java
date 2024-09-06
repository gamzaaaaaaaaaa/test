package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.hospital;

public class HospitalRowMapper implements RowMapper<hospital> {

    @Override
    public hospital mapRow(ResultSet rs, int rowNum) throws SQLException {
    	hospital hs = new hospital();
    	hs.setAddr(rs.getString("addr"));
    	hs.setPostNo(rs.getInt("postNo"));
    	hs.setTelephone(rs.getString("telephone"));
    	hs.setXPos(rs.getDouble("XPos"));
    	hs.setYPos(rs.getDouble("YPos"));
    	hs.setYadmNm(rs.getString("yadmNm"));
        return hs;
    }
}
