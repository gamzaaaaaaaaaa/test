package com.springmvc.repository;

import java.util.List;

import com.springmvc.domain.hospital;
import com.springmvc.domain.reservation;

public interface Hospital_Repository {
	
	public void create(hospital hp);
	public List<hospital> findAllHospitals();
	public void createReserve(reservation rv);
    public reservation readreservation(String id, String date, String time);
    public List<reservation> findAllReserve(String id);
    public void editreservation(reservation rv);
    public void editReservation(reservation rv);
    public void deleteReservation(String id, String date, String time);
    public void saveHospital(hospital hospital);
    public List<hospital> findFilteredHospitals(String keyword);
}
