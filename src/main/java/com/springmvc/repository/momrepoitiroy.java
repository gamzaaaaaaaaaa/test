package com.springmvc.repository;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.springmvc.domain.mom;

public interface momrepoitiroy {
	
	void create(mom mother,HttpServletRequest request);
	List<mom> readall();
	public void update(mom mother);
	public mom readone(int num);
	public void delete(int num);
	

}
