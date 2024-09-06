package com.springmvc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.domain.member;
import com.springmvc.repository.Member_Repository;
import com.springmvc.repository.Member_RepositoryImpl;

@Service
public class MemberService {
	
	@Autowired
	Member_Repository dao;
	
	public void create(member mb) {
		dao.create(mb);
	}
	
	
	public String idcheck(String id) {
		member mb = dao.findId(id);
		if(mb == null) {
			return "ok";
		}else {
			return "no";
		}
	}

	public member usercheck(String id, String pw) {
		member mb = dao.usercheck(id, pw);
		return mb;
	}
	
	public void update(member mb) {
		dao.update(mb);
	}
	
	public void delete(String id) {
		dao.delete(id);
	}
	
	
}
