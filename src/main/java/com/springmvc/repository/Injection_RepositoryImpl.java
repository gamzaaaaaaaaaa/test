package com.springmvc.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.domain.child;
import com.springmvc.domain.injection;
import com.springmvc.service.InjectionService;

@Repository
public class Injection_RepositoryImpl implements Injection_Repository{
	
	private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
    //데이터 삽입
    public void insertBirth(String id, LocalDate birthdayDate, Map<String, LocalDate> injectionDates) {
    	
        String sql = "insert into injection (id, birth, BCG, HepB_1, HepB_2, DTaP_1, IPV_1, Hib_1, PCV_1, RV_1, RV2_1, DTaP_2, IPV_2, Hib_2, PCV_2, RV_2, RV2_2, HepB_3, DTaP_3, IPV_3, Hib_3, PCV_3, RV2_3, Hib_4, PCV_4, MMR_1, VAR_1, HepA_1, IJEV_1, LJEV_1, IJEV_2, DTaP_4, PPSV, HepA_2, IJEV_3, LJEV_2) "
        		+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            jdbcTemplate.update(sql, id, birthdayDate, 
            		injectionDates.get("BCG"), 
            		injectionDates.get("HepB_1"), 
            		injectionDates.get("HepB_2"), 
            		injectionDates.get("DTaP_1"), 
            		injectionDates.get("IPV_1"),
            		injectionDates.get("Hib_1"),
            		injectionDates.get("PCV_1"),
            		injectionDates.get("RV_1"),
            		injectionDates.get("RV2_1"),
            		injectionDates.get("DTaP_2"),
            		injectionDates.get("IPV_2"), 
            		injectionDates.get("Hib_2"), 
            		injectionDates.get("PCV_2"), 
            		injectionDates.get("RV_2"), 
            		injectionDates.get("RV2_2"), 
            		injectionDates.get("HepB_3"),
            		injectionDates.get("DTaP_3"),
            		injectionDates.get("IPV_3"), 
            		injectionDates.get("Hib_3"), 
            		injectionDates.get("PCV_3"), 
            		injectionDates.get("RV2_3"), 
            		injectionDates.get("Hib_4"), 
            		injectionDates.get("PCV_4"), 
            		injectionDates.get("MMR_1"),
            		injectionDates.get("VAR_1"), 
            		injectionDates.get("HepA_1"),
            		injectionDates.get("IJEV_1"), 
            		injectionDates.get("LJEV_1"), 
            		injectionDates.get("IJEV_2"), 
            		injectionDates.get("DTaP_4"),
            		injectionDates.get("PPSV"),
            		injectionDates.get("HepA_2"),
            		injectionDates.get("IJEV_3"),
            		injectionDates.get("LJEV_2"));
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로그 출력
            // 필요 시 추가적인 예외 처리 로직
        }
    }


    //데이터 불러오기
    public List<injection> getInjectionList(String id){
    	String sql = "select * from injection where id=?";
    	return jdbcTemplate.query(sql, new Object[]{id}, new InjectionRowMapper());
    }

    
    //데이터 삭제하기
    public void deleteBirth(String id) {
    	String sql = "delete from injection where id=?";
    	jdbcTemplate.update(sql, id);
    }
    
    public List<child> getChildBirth(String id){
    	String sql = "select * from child where id=?";
    	return jdbcTemplate.query(sql, new Object[] {id}, new ChildRowMapper());
    }
    
    public List<injection> getInjections(String id, LocalDate birth){
    	String sql = "select * from injection where id=? and birth=?";
    	return jdbcTemplate.query(sql, new Object[] {id, birth}, new InjectionRowMapper());
    }
    
    public boolean existsByIdAndBirth(String id, LocalDate birth) {
        String sql = "select count(*) from injection where id = ? and birth = ?";
        int count = jdbcTemplate.queryForObject(sql, new Object[]{id, birth}, Integer.class);
        return count > 0;
    }



}