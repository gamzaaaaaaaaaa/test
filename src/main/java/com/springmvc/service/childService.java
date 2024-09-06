package com.springmvc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.springmvc.domain.child;
import com.springmvc.domain.childinfo;

public interface childService{
	   void create(child baby,HttpServletRequest request);
	   List<child> readAll();
	   child readone(int num);
	   void update(child baby);
	   void delete(int num);
	   
	   public List<childinfo> allread();
	   childinfo oneinfo(String age_info);
	   List<child> readAllByMemberId(String id);
	}
