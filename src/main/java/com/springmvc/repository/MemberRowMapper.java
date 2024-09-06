package com.springmvc.repository;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.member;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberRowMapper implements RowMapper<member> {
   
	@Override
    public member mapRow(ResultSet rs, int rowNum) throws SQLException {
		member mb = new member();
		mb.setId(rs.getString("id"));
		mb.setPw(rs.getString("pw"));
		mb.setName(rs.getString("name"));
		mb.setPostcode(rs.getString("postcode"));
		mb.setAddress(rs.getString("address"));
		mb.setDetailAddress(rs.getString("detailAddress"));
		mb.setExtraAddress(rs.getString("extraAddress"));
		mb.setBirth(rs.getString("birth"));
		mb.setPhone(rs.getString("phone"));
		mb.setDue(rs.getString("due")); // 추가된 컬럼
        return mb;
    }
}
