package com.springmvc.repository;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import com.springmvc.domain.child;
import com.springmvc.domain.childinfo;

@Repository
public class childrepositoryImpl implements childrepository{
	
	private List<child> listChild = new ArrayList<child>();
	//baby 객체를 담기위해 ArrayList 생성
	
	private List<childinfo> infochild = new ArrayList<childinfo>();
	
	private JdbcTemplate template;
	//database 연결하기 위해 servlet-context.xml에 지정해놓은 객체 초기화
	
	@Autowired
	public void setJdbctemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
		
	}
	
	//데이터베이스 연결 구문
	
	public childrepositoryImpl() {
		
		/*
		 * child baby1 = new child(); baby1.getName(); baby1.getBirth(); baby1.getDay();
		 * baby1.getHeight(); baby1.getWeight(); baby1.getHead(); baby1.getGender();
		 * 
		 * listChild.add(baby1);
		 */
		
	}

	@Override
	public void create(child baby, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String id = (String)session.getAttribute("sessionId");
		System.out.println("부모아이디:"+id);
		String sql = "insert into child(id,name,birth,day,height,weight,head,gender)values(?,?,?,?,?,?,?,?)";
		template.update(sql ,id,baby.getName(), baby.getBirth(), baby.getDay(), baby.getHeight(), baby.getWeight(), baby.getHead(), baby.getGender());
		listChild.add(baby);
		
		System.out.println(baby.getBirth());
	}

	@Override
	public List<child> readAll() {
		 String sql = "select * from child";
		listChild = template.query(sql, new ChildRowMapper());
		
		return listChild;
	}

	@Override
	public child readone(int num) {
		System.out.println("readone 리파지토리 - num: " + num);
		child childone = new child();
		String sql = "select * from child where num=?";
		childone = template.queryForObject(sql,new Object[] {num},new ChildRowMapper());
		return childone;
	}

	@Override
	public void update(child baby) {
	    String sql = "update child set birth=?, day=?, height=?, weight=?, head=?, gender=? WHERE num=?";
	    template.update(sql,baby.getBirth(), baby.getDay(), baby.getHeight(), baby.getWeight(), baby.getHead(), baby.getGender(), baby.getNum());
	}

	@Override
	public void delete(int num) {
		System.out.println("delete 리파지토리");
		String sql = "delete from child where num=?";
		template.update(sql,num);	
	}
	
	//childinfo crud 시작

	@Override
	public List<childinfo> allread() {
		System.out.println("info allread 리파지토리");
		String sql = "select * from child_info";
		infochild = template.query(sql, new ChildinfoRowMapper());
		
		/*
		 * for (childinfo child : infochild) { System.out.println("ID: " +
		 * child.getId()); // 각 childinfo 객체의 ID 출력 }
		 */
		
		return infochild;		
	}

	@Override
	public childinfo oneinfo(String age_info) {
		System.out.println("oneinfo repository");
		String sql = "select * from child_info where age_info=?";
		return template.queryForObject(sql, new Object[] {age_info}, new ChildinfoRowMapper());
	}

    // 사용자 ID로 자녀 목록을 조회하는 메서드  
	@Override
    public List<child> readAllByMemberId(String id) {
        String sql = "select * from child where id=?";
        return template.query(sql, new Object[] { id }, new ChildRowMapper());
    }

}