package com.springmvc.repository;

import org.springframework.jdbc.core.RowMapper;
import com.springmvc.domain.reservation;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ReservationRowMapper implements RowMapper<reservation> {
    @Override
    public reservation mapRow(ResultSet rs, int rowNum) throws SQLException {
        reservation rv = new reservation();
        rv.setId(rs.getString("id"));
        rv.setHospitalName(rs.getString("hospitalName"));
        rv.setName(rs.getString("name"));
        rv.setBirth(rs.getString("birth"));
        rv.setDate(rs.getString("date")); 
        rv.setTime(rs.getString("time"));
        
        return rv;
    }
}
