package com.springmvc.repository;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.domain.InjectionList;

@Repository
public class InjectionList_RepositoryImpl implements InjectionList_Repository{
	
	private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    public void saveList (List<InjectionList> InjectionList) {
    	String sql = "insert into injectionlist (listid, userid, birth, title, date) values (?, ?, ?, ?, ?)";
    	for(InjectionList item : InjectionList) {
    		jdbcTemplate.update(sql, item.getListid(), item.getUserid(), item.getBirth(), item.getTitle(), item.getDate());
    	}
    }
    
    public List<InjectionList> getInjectionList(String id, String birth){
    	System.out.println("리파지토리"+id);
    	String sql = "select * from injectionlist where userid=? and birth=?";
    	return jdbcTemplate.query(sql, new Object[]{id, birth}, new InjectionListRowMapper());
    }
    
}
