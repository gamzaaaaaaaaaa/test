package com.springmvc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import com.springmvc.domain.hospital;
import com.springmvc.domain.reservation;
import com.springmvc.repository.Hospital_Repository;

@Service
public class HospitalService {

    @Autowired
    private Hospital_Repository dao;
    
    public void create(hospital hp) {
    	dao.create(hp);
    }
    
    public List<hospital> findAllHospitals(){
    	List<hospital> list = dao.findAllHospitals();
    	return list;
    }
    
    public void createReserve(reservation rv) {
    	dao.createReserve(rv);
    }
    
    public reservation readreservation(String id, String date, String time) {
    	reservation rv = dao.readreservation(id, date, time);
    	return rv;
    }
    
    public List<reservation> findAllReserve(String id){
    	List<reservation> list = dao.findAllReserve(id);
    	return list;
    }
    
    public void deleteReservation(String id, String date, String time) {
    	dao.deleteReservation(id, date, time);
    }
    
    
    public List<hospital> getAllHospitals() {
        return dao.findAllHospitals();
    }
    
    public List<hospital> findFilteredHospitals(String keyword){
    	return dao.findFilteredHospitals(keyword);
    }
    
    public void saveHospital(hospital hospital) {
    	dao.saveHospital(hospital);
    }
}