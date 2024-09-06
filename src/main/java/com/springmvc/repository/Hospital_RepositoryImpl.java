package com.springmvc.repository;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.domain.board;
import com.springmvc.domain.hospital;
import com.springmvc.domain.reservation;

@Repository
public class Hospital_RepositoryImpl implements Hospital_Repository{
    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    //병원 삽입
    public void create(hospital hp) {
        String sql = "insert into hospital (addr, postNo, telephone, XPos, YPos, yadmNm) values (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, hp.getAddr(), hp.getPostNo(), hp.getTelephone(), hp.getXPos(), hp.getYPos(), hp.getYadmNm());
    }
    
    //병원 모두 불러오기
    public List<hospital> findAllHospitals() {
        String sql = "select * from hospital";
        return jdbcTemplate.query(sql, new HospitalRowMapper());
    }
    
    public List<hospital> findFilteredHospitals(String keyword) {
        String sql = "select * from hospital where addr like ? or yadmNm like ?";
        return jdbcTemplate.query(sql, new Object[]{"%" + keyword + "%", "%" + keyword + "%"}, new HospitalRowMapper());
    }


    //병원 예약하기
    public void createReserve(reservation rv){
    	String sql  = "insert into reserve (id, hospitalName, name, birth, date, time) values (?, ?, ?, ?, ?, ?)";
    	jdbcTemplate.update(sql,rv.getId(), rv.getHospitalName(), rv.getName(), rv.getBirth(), rv.getDate(), rv.getTime());
    }
    
    //예약 불러오기 
    public reservation readreservation(String id, String date, String time) {
        String sql = "select * from reserve where id = ? and date = ? and time = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id, date, time}, new ReservationRowMapper());
    }
    
    //본인 예약 모두 불러오기 
    public List<reservation> findAllReserve(String id){
    	String sql = "select * from reserve where id=?";
    	return jdbcTemplate.query(sql, new Object[]{id}, new ReservationRowMapper());
    }
    
    //예약 수정하기 수정한 값을 받아와서 삭제하고 다시 만들어줘야함
    public void editreservation(reservation rv) {
        String sql = "update reserve set date = ?, time = ? where id = ? and hospitalNam";
        jdbcTemplate.update(sql, rv.getDate(), rv.getTime(), rv.getId(), rv.getDate(), rv.getTime());
    }
    
    
    public void editReservation(reservation rv) {
        // 기존 예약 삭제
    	deleteReservation(rv.getId(), rv.getDate(), rv.getTime());
        
        // 수정된 예약 추가
        createReserve(rv);
    }

    
    //예약 삭제하기 
    public void deleteReservation(String id, String date, String time) {
        String sql = "delete from reserve where id = ? and date = ? and time = ?";
        //영향 받은 행 숫자 세기
        int rowsAffected = jdbcTemplate.update(sql, id, date, time);
        System.out.println("Rows affected: " + rowsAffected);
    }

    public void saveHospital(hospital hp) {
    	String sql = "insert into hospital values (?, ?, ?, ?, ?, ?)";
    	jdbcTemplate.update(sql, hp.getAddr(), hp.getPostNo(), hp.getTelephone(), hp.getXPos(), hp.getYPos(), hp.getYadmNm());
    			
    }



}
