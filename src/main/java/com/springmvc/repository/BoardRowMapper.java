package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.board;

public class BoardRowMapper implements RowMapper<board> {

    @Override
    public board mapRow(ResultSet rs, int rowNum) throws SQLException {
        board bd = new board();
        bd.setNum(rs.getInt("num"));
        bd.setId(rs.getString("id"));
        bd.setName(rs.getString("name"));
        bd.setSubject(rs.getString("subject"));
        bd.setContent(rs.getString("content"));
        bd.setRegistDay(rs.getString("registDay"));
        bd.setHit(rs.getInt("hit"));
        bd.setIp(rs.getString("ip"));
        return bd;
    }
}
