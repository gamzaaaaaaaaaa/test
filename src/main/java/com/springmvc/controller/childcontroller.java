package com.springmvc.controller;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.domain.child;
import com.springmvc.domain.childinfo;
import com.springmvc.service.childService;

@Controller
@RequestMapping("/childs")
public class childcontroller {
	 
	@Autowired 
	private childService childservice;
	 
	//Create
	@GetMapping("/child")
	public String getchild(Model model, HttpServletRequest request, child baby) {
		System.out.println("get child");
		
		HttpSession session = request.getSession(false);
		//System.out.println("session :"+ session.getAttribute("sessionId"));
		
	    if (session == null || session.getAttribute("sessionId") == null) {
	        System.out.println("세션이 없거나 로그인되지 않음");
	        return "redirect:/login";
	    }
		
		System.out.println("session 있음:"+ session.getAttribute("sessionId"));
		return "childform";
	}
	
	//Create
	@PostMapping("/child") 
	public String formchild(@ModelAttribute child baby, HttpServletRequest request) {
		childservice.create(baby, request);
		
		System.out.println("postchild");
		return "redirect:childlist";
	}
	
	//readall
	@GetMapping("/childlist")
	public String childAlllist(Model model, HttpServletRequest request) {
		System.out.println("readall 컨트롤러");
		
		HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("sessionId") == null) {
	        System.out.println("세션이 없거나 로그인되지 않음");
	        return "redirect:/login";
	    }
		
		System.out.println("session 있음:"+ session.getAttribute("sessionId"));
		
		List<child> childList = childservice.readAll();
		model.addAttribute("childmodel",childList);
		
		return "childlist";
	}
	
	//readone
	/*
	@GetMapping("/details")
	public String childone(@RequestParam("one")String childname, Model model) {
		System.out.println("디테일");
		child childone = childservice.readone(childname);
		model.addAttribute("readone",childone);
		return "childone";
	}
	*/
	
    @GetMapping("/details")
    public String childone(@RequestParam("one") int num, Model model) {
        System.out.println("디테일");

        // 자녀 정보 조회
        child childone = childservice.readone(num);

        // 생년월일을 개월 수로 변환
        int ageInMonths = calculateAgeInMonths(childone.getBirth());

        // 모델에 자녀 정보와 계산된 개월 수 추가
        model.addAttribute("readone", childone);
        model.addAttribute("ageInMonths", ageInMonths);
        
        childinfo childInfo = childservice.oneinfo(String.valueOf(ageInMonths));
        model.addAttribute("childInfo", childInfo);
        
        return "childone";
    }

    // 생년월일을 개월 수로 변환하는 메소드
    private int calculateAgeInMonths(String birthDateString) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate birthDate = LocalDate.parse(birthDateString, formatter);
        LocalDate currentDate = LocalDate.now();
        Period period = Period.between(birthDate, currentDate);
        
        System.out.println(period.getYears() * 12 + period.getMonths());
        return period.getYears() * 12 + period.getMonths();
    }
	
	//update
   
	@GetMapping("/update")
	public String updateform(@RequestParam("num")int num, Model model) {
		System.out.println("update getmapping");
		child childupdateform = childservice.readone(num);
		model.addAttribute("child",childupdateform);
		
		return "updateform";
	}
	

    
    @PostMapping("/update")
    public String updateChildAndShowForm(@ModelAttribute child baby, RedirectAttributes redirectAttributes) {
        System.out.println("update postmapping");

        // 자녀 정보 업데이트
        childservice.update(baby);
        System.out.println("번호:"+baby.getNum());

        // 업데이트된 자녀 정보를 다시 불러옴
        child childupdateform = childservice.readone(baby.getNum());
        System.out.println("업데이트된 자녀 번호"+childupdateform);
        // 생년월일을 개월 수로 변환
        int ageInMonths = calculateAgeInMonths(childupdateform.getBirth());

        // 개월 수를 바탕으로 추가 정보 조회
        childinfo updatedChildInfo = childservice.oneinfo(String.valueOf(ageInMonths));

        // 필요한 정보를 RedirectAttributes에 추가
        redirectAttributes.addAttribute("one", childupdateform.getNum());
        redirectAttributes.addAttribute("ageInMonths", ageInMonths);

        // 자녀 상세 정보 페이지로 리다이렉트
        return "redirect:details";
    }

    // 생년월일을 개월 수로 변환하는 메소드는 여전히 childone 메서드에 유지됩니다

	/*
	// Update 
	@PostMapping("/update")
	public String updateChild(@ModelAttribute("childmodel") child baby) {
		System.out.println("update controller");
	    childservice.update(baby);
	    return "redirect:/childs/childlist"; 
	}
	
	*/
	
	@PostMapping("/delete")
	public String delete(@RequestParam("num") int num) {
	
		System.out.println("delete controller");
		childservice.delete(num);
		 return "redirect:childlist"; 
	}
	
	@GetMapping("/info")
	public String childinfo(Model model) {
		System.out.println("info컨트롤러");
		List<childinfo> infochild = childservice.allread();
		model.addAttribute("info",infochild);
		
		return "childinfo";
	}
	
	@GetMapping("/oneinfo")
	public String oneinfo(@RequestParam("oneinfo")String age_info, Model model) {
		System.out.println("oneinfo");
		childinfo ChildInfo = childservice.oneinfo(age_info);
		model.addAttribute("oneinfo",ChildInfo);
		return "childone";
	}
	
}