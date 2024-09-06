package com.springmvc.controller;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.domain.hospital;
import com.springmvc.domain.member;
import com.springmvc.domain.reservation;
import com.springmvc.repository.Hospital_RepositoryImpl;
import com.springmvc.repository.Member_RepositoryImpl;
import com.springmvc.service.HospitalService;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class HospitalController {

	@Autowired
	HospitalService service;

    @GetMapping("/api")
    public String getApi(Model model) throws Exception {
    	
    	//필요 정보 : 주소, 우편번호, 전화번호, X, Y, 병원 이름
    	String addr;
    	int postNo;
    	String telephone;
    	double XPos;
    	double YPos;
    	String yadmNm;
    	
        String urlstr = "https://apis.data.go.kr/B551182/MadmDtlInfoService2.6/getSpclDiaginfo2.6?serviceKey=Y5jzZvqGJI9kwMTrCq2d1vEfSr5WPvA8quh4D31Re%2BXjPDU6pi2OiV49q0n6EM1%2F3iTIW%2FJcTYy93lmbjm5oog%3D%3D&dgsbjtCd=10&_type=json";
        URL url = new URL(urlstr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("응답코드:" + conn.getResponseCode());

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }
        br.close();

        String xmlData = response.toString();
        JSONObject jsonObject = XML.toJSONObject(xmlData);
        System.out.println(jsonObject.toString()); 

        JSONTokener tokener = new JSONTokener(jsonObject.toString());
        JSONObject object = new JSONObject(tokener);
        //System.out.println(object.toString());
        
        JSONObject resp = object.getJSONObject("response");
        //System.out.println(resp.toString());
	 
        JSONObject body = resp.getJSONObject("body");
        //System.out.println(body.toString());
        
        JSONObject items = body.getJSONObject("items");
        //System.out.println(items.toString());
        
        JSONArray item = items.getJSONArray("item");
        for(int i=0; i<item.length(); i++) {
        	JSONObject temp = item.getJSONObject(i);
        	hospital dto = new hospital();
        	
        	addr = temp.getString("addr");
        	System.out.println(addr);
        	postNo = temp.getInt("postNo");
        	System.out.println(postNo);
        	telephone = temp.getString("telno");
        	System.out.println(telephone);
        	XPos = temp.getDouble("XPos");
        	System.out.println(XPos);
        	YPos = temp.getDouble("YPos");
        	System.out.println(YPos);
        	yadmNm = temp.getString("yadmNm");
        	System.out.println(yadmNm);
        	
        	dto.setAddr(addr);
        	dto.setPostNo(postNo);
        	dto.setTelephone(telephone);
        	dto.setXPos(XPos);
        	dto.setYPos(YPos);
        	dto.setYadmNm(yadmNm);
        	
        	service.create(dto);
        	
        }
        return "api";
    }

    
    @GetMapping("/hospitalreservation")
    public String hospitalform(@RequestParam String name, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        member mb = (member) session.getAttribute("member");

        if (mb == null) {
            return "redirect:/login"; 
        }

        List<String> availableTimes = Arrays.asList("09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00");

        model.addAttribute("member", mb);
        model.addAttribute("name", name);
        model.addAttribute("availableTimes", availableTimes);

        model.addAttribute("reservation", new reservation());

        return "hospital_reservation";
    }


    
    @PostMapping("/reserve")
    public String reserveSuccess(@ModelAttribute reservation rv, Model model, HttpServletRequest request){
        HttpSession session = request.getSession(false);
        member mb = (member)session.getAttribute("member");
        		
        rv.setId(mb.getId());
        rv.setName(mb.getName());
        rv.setBirth(mb.getBirth());
        
    	service.createReserve(rv);
    	
        model.addAttribute("reservation", rv);
        return "reservation_success";
    }

    @GetMapping("/reservation/edit")
    public String reserveRead(@RequestParam String id, @RequestParam String date, @RequestParam String time, Model model) {
        reservation rv = service.readreservation(id, date, time);

        if (rv == null) {
            return "redirect:/error"; // 예약 정보가 없는 경우 처리
        }

        model.addAttribute("reservation", rv);
        return "reservation_update";
    }
    
    @GetMapping("/hospitalinfo")
    public String allreserve(HttpServletRequest request, Model model) {
    	HttpSession session = request.getSession(false);
    	member mb = (member)session.getAttribute("member");
    	String id = mb.getId();
    	System.out.println(id);
    	
    	List<reservation> rv = service.findAllReserve(id);
    	
    	model.addAttribute("reserve", rv);
    	
    	return "hospital_info";
    }
    
    
    
    @PostMapping("/updatereserve")
    public String reserveUpdate(@ModelAttribute reservation rv, Model model) {

    	service.deleteReservation(rv.getId(), rv.getOldDate(), rv.getOldTime());

        service.createReserve(rv);

        model.addAttribute("reservation", rv);
        return "reservation_success";
    }


    @GetMapping("/reservation/cancel")
    public String reserveDelete(@RequestParam String id, @RequestParam String date, @RequestParam String time, Model model) {
    	 service.deleteReservation(id, date, time);
    	 return "redirect:/";
    }
    

    @GetMapping("/reservation/delete")
    public String reserveDelete2(@RequestParam String id, @RequestParam String date, @RequestParam String time, Model model) {
    	 service.deleteReservation(id, date, time);
         System.out.println(id + date + time);
         return "redirect:/hospitalinfo";
    }
    
    
    @GetMapping("/apimap")
    public String showMap(HttpServletRequest request, Model model) throws Exception {
    	
    	List<hospital> allhospital = service.getAllHospitals();
    	model.addAttribute("allhospital", allhospital);
    	return "apimap";
    	
    }
    
    @PostMapping("/searchHospital")
    @ResponseBody
    public List<hospital> searchHospital(@RequestParam(value = "keyword", defaultValue = "") String keyword) {
        List<hospital> filteredHospital = service.findFilteredHospitals(keyword);
        return filteredHospital;
    }

   
}
    
