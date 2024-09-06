package com.springmvc.repository;

import com.springmvc.domain.member;

public interface Member_Repository {

	public void create(member mb);
	public member usercheck(String id, String pw);
	public member findId(String id);
	public void update(member mb);
	public void delete(String id);
}
