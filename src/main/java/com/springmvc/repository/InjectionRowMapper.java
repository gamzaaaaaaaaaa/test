package com.springmvc.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springmvc.domain.injection;

public class InjectionRowMapper implements RowMapper<injection> {

    @Override
    public injection mapRow(ResultSet rs, int rowNum) throws SQLException {
    	injection ij = new injection();
    	ij.setId(rs.getString("id"));
    	ij.setBirth(rs.getString("birth"));
    	ij.setBCG(rs.getString("BCG"));
    	ij.setHEPB_1(rs.getString("HEPB_1"));
    	ij.setHEPB_2(rs.getString("HEPB_2"));
    	ij.setHEPB_3(rs.getString("HEPB_3"));
    	ij.setDTAP_1(rs.getString("DTAP_1"));
    	ij.setDTAP_2(rs.getString("DTAP_2"));
    	ij.setDTAP_3(rs.getString("DTAP_3"));
    	ij.setDTAP_4(rs.getString("DTAP_4"));
    	ij.setIPV_1(rs.getString("IPV_1"));
    	ij.setIPV_2(rs.getString("IPV_2"));
    	ij.setIPV_3(rs.getString("IPV_3"));
    	ij.setHib_1(rs.getString("Hib_1"));
    	ij.setHib_2(rs.getString("Hib_2"));
    	ij.setHib_3(rs.getString("Hib_3"));
    	ij.setHib_4(rs.getString("Hib_4"));
    	ij.setPCV_1(rs.getString("PCV_1"));
    	ij.setPCV_2(rs.getString("PCV_2"));
    	ij.setPCV_3(rs.getString("PCV_3"));
    	ij.setPCV_4(rs.getString("PCV_4"));
    	ij.setPPSV(rs.getString("PPSV"));
    	ij.setRV_1(rs.getString("RV_1"));
    	ij.setRV_2(rs.getString("RV_2"));
    	ij.setRV2_1(rs.getString("RV2_1"));
    	ij.setRV2_2(rs.getString("RV2_2"));
    	ij.setRV2_3(rs.getString("RV2_3"));
    	ij.setMMR_1(rs.getString("MMR_1"));
    	ij.setVAR_1(rs.getString("VAR_1"));
    	ij.setHEPA_1(rs.getString("HEPA_1"));
    	ij.setHEPA_2(rs.getString("HEPA_2"));
    	ij.setIJEV_1(rs.getString("IJEV_1"));
    	ij.setIJEV_2(rs.getString("IJEV_2"));
    	ij.setIJEV_3(rs.getString("IJEV_3"));
    	ij.setLJEV_1(rs.getString("LJEV_1"));
    	ij.setLJEV_2(rs.getString("LJEV_2"));

    	
        return ij;
    }
}
