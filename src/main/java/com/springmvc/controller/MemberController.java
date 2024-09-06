package com.springmvc.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.domain.child;
import com.springmvc.domain.member;
import com.springmvc.service.MemberService;
import com.springmvc.service.childService;


@Controller
public class MemberController {
	
	@Autowired
	MemberService service;
	
	@Autowired
	childService childservice;

	
	@GetMapping("/join")
	public String joinform() {
		return "join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute member mb) {
		
		service.create(mb);
		  
		return "redirect:/";
	}
	
	@PostMapping("/idCheck")
	public @ResponseBody String idcheck(@RequestBody Map<String, String> payload) {
	    String id = payload.get("id");
	    System.out.println("id값: " + id);
	    String idcheck = service.idcheck(id);
	    return idcheck;
	}
	
	
	
	@GetMapping("/login")
	public String loginform(@RequestParam(value = "redirect", required = false) String redirect, Model model) {
	    model.addAttribute("redirect", redirect);
	    return "login"; 
	}
	@PostMapping("/login")
	public String login(Model model, HttpServletRequest request, @RequestParam String id, @RequestParam String pw, @RequestParam(required = false) String redirect) {
	    member mb = service.usercheck(id, pw);

	    System.out.println("로그인 확인 멤버: " + mb);

	    if (mb != null) {
	        HttpSession session = request.getSession(true);
	        session.setAttribute("member", mb);
	        session.setAttribute("sessionId", mb.getName());

	        System.out.println("Session : " + session.getAttribute("member"));

	        // redirect 값이 있을 때만 리다이렉트 수행
	        if (redirect != null && !redirect.trim().isEmpty()) {
	            return "redirect:" + redirect;
	        } else {
	            return "redirect:/"; // 기본적으로 홈 페이지로 리다이렉트
	        }
	    } else {
	        model.addAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");

	        System.out.println("로그인 실패" + id);

	        return "login";
	    }
	}

	
	@PostMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/mypage")
	public String mypage(@ModelAttribute member mb) {
		return "mypage";
	}
	
	@GetMapping("/childpage")
	public String childpage(Model model, HttpServletRequest request) {
	    // 현재 세션에서 로그인된 사용자 정보 가져오기
	    HttpSession session = request.getSession(false);
	    member mb = (member) session.getAttribute("member");

	    if (mb != null) {
	        // 로그인된 사용자의 자녀 목록 가져오기
	        List<child> childList =null;
			try {
				childList = childservice.readAll();
				System.out.println("Retrieved children list: " + childList);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        model.addAttribute("childmodel", childList);
	    }

	    // 사용자의 정보도 함께 전달
	    model.addAttribute("member", mb);

	    return "childpage";
	}
	
	
	@GetMapping("/editmember")
	public String editpage(Model model, HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    member mb = (member) session.getAttribute("member");
	    model.addAttribute("member", mb);
	      
	    return "member_update";
	}

	
	@PostMapping("/editmember")
	public String updatemember(@ModelAttribute member mb, HttpServletRequest request) {

		System.out.println("컨트롤러 멤버:"+ mb);
		
		service.update(mb);
		
		HttpSession session = request.getSession(false);
		session.setAttribute("member", mb);
		
		return "redirect:/mypage";
		
		
	}

	@PostMapping("/deletemember")
	public String deletemember(@RequestParam String id, HttpServletRequest request) {
		
		service.delete(id);
		
		HttpSession session = request.getSession(false);
		session.invalidate();
		
		return "redirect:/";
	}

}
