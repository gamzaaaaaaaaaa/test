package com.springmvc.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.springmvc.domain.mom;


public interface momservice {

	void create(mom mother,HttpServletRequest request);
	List<mom> readall();
	public void update(mom mother);
	public mom readone(int num);
	public Date calculDueDate(Date lastDay);
	void delete(int num);
	
	
}
