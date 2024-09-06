package com.springmvc.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.springmvc.domain.child;
import com.springmvc.domain.injection;

public interface Injection_Repository {
	
	public void insertBirth(String id, LocalDate birthdayDate, Map<String, LocalDate> injectionDates);
	public List<injection> getInjectionList(String id);
	public void deleteBirth(String id);
	public List<child> getChildBirth(String id);
	public List<injection> getInjections(String childId, LocalDate birth);
	public boolean existsByIdAndBirth(String id, LocalDate birth);
}
