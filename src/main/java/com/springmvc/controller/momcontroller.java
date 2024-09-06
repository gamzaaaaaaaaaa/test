package com.springmvc.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.domain.member;
import com.springmvc.domain.mom;
import com.springmvc.service.momservice;

@Controller
@RequestMapping("/mom")
public class momcontroller {
	
	@Autowired
	private momservice momService;
	
	//create
	@GetMapping("/form")
	public String momform(Model model,HttpServletRequest request) {
		
		HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("sessionId") == null) {
	        System.out.println("세션이 없거나 로그인되지 않음");
	        return "redirect:/login";
	    }
		
	    member mb = (member)session.getAttribute("member");
	    String sessionName = mb.getName();
	    
	    model.addAttribute("sessionName", sessionName);
	    System.out.println(sessionName);
		System.out.println("session 있음:"+ session.getAttribute("sessionId"));
		return "momform";
	}
	
	//create
	@PostMapping("/form")
	public String momview(@ModelAttribute mom mother, @RequestParam("name") String name,HttpServletRequest request) {
		System.out.println("form 컨트롤러");
		System.out.println(name);

		
		mother.setName(name);

		momService.create(mother,request);
		
		
		return "redirect:momlist";
	}
	
	//readall
	@GetMapping("/momlist")
	public String momlist(@RequestParam(value = "page", defaultValue = "1") int page,Model model, HttpServletRequest request) {
	    
		HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("sessionId") == null) {
	        System.out.println("세션이 없거나 로그인되지 않음");
	        return "redirect:/login";
	    }
	    
	    int pageSize = 5; // 한 페이지에 보여줄 항목 수
	    List<mom> momlist = momService.readall(); // 전체 목록을 가져옵니다.
	    
	    // 페이징에 필요한 데이터 계산
	    int totalItems = momlist.size();
	    int totalPages = (int) Math.ceil((double) totalItems / pageSize);
	    
	    int startItem = (page - 1) * pageSize;
	    List<mom> paginatedList;
	    
	    if (totalItems < startItem) {
	        paginatedList = Collections.emptyList();
	    } else {
	        int toIndex = Math.min(startItem + pageSize, totalItems);
	        paginatedList = momlist.subList(startItem, toIndex);
	    }
	    
	    model.addAttribute("mommodel", paginatedList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);
	    
	    return "momcalendar";
	}
	
	//update
	@GetMapping("/update")
	public String getupdate(@RequestParam("num") int num, Model model) {
		System.out.println("파라미터 :"+num);
		mom momupdateform = momService.readone(num);
		model.addAttribute("mommodel", momupdateform);
		return "momupdate";
	}
	
	//update
	@PostMapping("/update")
	public String updateMom(@ModelAttribute("mommodel") mom mother) {
	    momService.update(mother);
	    return "redirect:momlist"; // 수정 후 목록으로
	}
	//delete 
	@GetMapping("/delete")
	public String delete(@RequestParam("num") int num) {
		momService.delete(num);
		return "redirect:momlist";
	}
	
	@GetMapping("/momData")
	@ResponseBody
	public List<mom> getMomData(HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("sessionId") == null) {
	        System.out.println("로그인하세요");
	    	return Collections.emptyList(); // 로그인되지 않은 경우 빈 리스트 반환
	    }
	    return momService.readall(); // 모든 산모 데이터를 반환
	}

}
