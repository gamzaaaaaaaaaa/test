package com.springmvc.service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.domain.child;
import com.springmvc.domain.injection;
import com.springmvc.repository.Injection_Repository;

@Service
public class InjectionService {
	
	@Autowired
	Injection_Repository dao;
	
	public void insertBirth(String id, LocalDate birthdayDate, Map<String, LocalDate> injectionDates) {
		if (!dao.existsByIdAndBirth(id, birthdayDate)) {
            dao.insertBirth(id, birthdayDate, injectionDates);
        } else {
            System.out.println("Data already exists for id: " + id + " and birth: " + birthdayDate);
        }
    }
	
	public Map<String, LocalDate> injectiondate(LocalDate birthdayDate){
		 Map<String, LocalDate> schedule = new HashMap<>();
		
		 //0개월
		 schedule.put("BCG", birthdayDate);
		 schedule.put("HepB_1", birthdayDate);
		 
		 //1개월
		 schedule.put("HepB_2", birthdayDate.plusMonths(1));
		 
		 //2개월
		 schedule.put("DTaP_1", birthdayDate.plusMonths(2));
		 schedule.put("IPV_1", birthdayDate.plusMonths(2));
		 schedule.put("Hib_1", birthdayDate.plusMonths(2));
		 schedule.put("PCV_1", birthdayDate.plusMonths(2));
		 schedule.put("RV_1", birthdayDate.plusMonths(2));
		 schedule.put("RV2_1", birthdayDate.plusMonths(2));
		 
		 //4개월
		 schedule.put("DTaP_2", birthdayDate.plusMonths(4));
		 schedule.put("IPV_2", birthdayDate.plusMonths(4));
		 schedule.put("Hib_2", birthdayDate.plusMonths(4));
		 schedule.put("PCV_2", birthdayDate.plusMonths(4));
		 schedule.put("RV_2", birthdayDate.plusMonths(4));
		 schedule.put("RV2_2", birthdayDate.plusMonths(4));
		 
		 //6개월
		 schedule.put("HepB_3", birthdayDate.plusMonths(6));
		 schedule.put("DTaP_3", birthdayDate.plusMonths(6));
		 schedule.put("IPV_3", birthdayDate.plusMonths(6));
		 schedule.put("Hib_3", birthdayDate.plusMonths(6));
		 schedule.put("PCV_3", birthdayDate.plusMonths(6));
		 schedule.put("RV2_3", birthdayDate.plusMonths(6));
		 
		 //12개월
		 schedule.put("Hib_4", birthdayDate.plusMonths(12));
		 schedule.put("PCV_4", birthdayDate.plusMonths(12));
		 schedule.put("MMR_1", birthdayDate.plusMonths(12));
		 schedule.put("VAR_1", birthdayDate.plusMonths(12));
		 schedule.put("HepA_1", birthdayDate.plusMonths(12));
		 schedule.put("IJEV_1", birthdayDate.plusMonths(12));
		 schedule.put("LJEV_1", birthdayDate.plusMonths(12));
		 
		 //13개월
		 schedule.put("IJEV_2", birthdayDate.plusMonths(13));
		 
		 //15개월
		 schedule.put("DTaP_4", birthdayDate.plusMonths(15));
		 
		 //18개월
		 
		 //24개월
		 schedule.put("PPSV", birthdayDate.plusMonths(24));
		 schedule.put("HepA_2", birthdayDate.plusMonths(24));
		 schedule.put("IJEV_3", birthdayDate.plusMonths(24));
		 
		 //36개월
		 schedule.put("LJEV_2", birthdayDate.plusMonths(36));
		 
		 
		 return schedule;
	}

	public List<injection> getInjectionList(String id){
		return dao.getInjectionList(id);
	}
	
	public void deleteBirth(String id) {
		dao.deleteBirth(id);
	}
	
	public List<child> getChildBirth(String id){
		return dao.getChildBirth(id);
	}
	
	 public List<injection> getInjections(String childId, LocalDate birth) {
	        return dao.getInjections(childId, birth);
	 }

}
