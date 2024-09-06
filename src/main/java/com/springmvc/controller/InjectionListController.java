package com.springmvc.controller;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.domain.InjectionList;
import com.springmvc.domain.member;
import com.springmvc.service.InjectionListService;

@Controller
public class InjectionListController {

	@Autowired 
	InjectionListService service;	
	
	@PostMapping("/saveInjectionList")
	@ResponseBody
	public void saveInjectionList(@RequestBody List<InjectionList> injectionList) {
	    System.out.println("Controller:"+injectionList);
		service.saveInjectionList(injectionList);
	    
	}


	@GetMapping("/getinjectionlist")
	@ResponseBody
	public List<InjectionList> getInjectionList(@RequestParam String userid, @RequestParam(required = false) String birth) {
	    System.out.println("check: userid=" + userid + ", birth=" + birth);
	    return service.getInjectionList(userid, birth);
	}

    
    @PostMapping("/checkInjectionList")
    @ResponseBody
    public boolean checkInjectionList(@RequestParam("userid") String userid, @RequestParam("title") String title, @RequestParam(value = "birth", required = false) String birth) {
        try {
            // URL 디코딩
            String decodedTitle = URLDecoder.decode(title, StandardCharsets.UTF_8.toString());
            
            System.out.println("Received request with userid: " + userid + ", title: " + decodedTitle + ", birth: " + birth);
            
            List<InjectionList> list = service.getInjectionList(userid, birth);
            
            for (InjectionList item : list) {
                if (item.getTitle().equals(decodedTitle)) {
                    System.out.println("check:"+item.getTitle());
                    System.out.println("check:"+decodedTitle);
                    return true; 
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	
}
