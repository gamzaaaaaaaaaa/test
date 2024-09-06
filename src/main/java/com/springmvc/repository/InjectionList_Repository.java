package com.springmvc.repository;

import java.util.List;

import com.springmvc.domain.InjectionList;

public interface InjectionList_Repository {

	public void saveList (List<InjectionList> InjectionList);
	public List<InjectionList> getInjectionList(String id, String birth);
}
