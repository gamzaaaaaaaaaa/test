package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.InjectionList;

public class InjectionListRowMapper implements RowMapper<InjectionList> {

    @Override
    public InjectionList mapRow(ResultSet rs, int rowNum) throws SQLException {
    	InjectionList il = new InjectionList();
    	il.setListid(rs.getString("listid"));
    	il.setUserid(rs.getString("userid"));
    	il.setBirth(rs.getString("birth"));
    	il.setTitle(rs.getString("title"));
    	il.setDate(rs.getString("date"));
        return il;
    }
}
