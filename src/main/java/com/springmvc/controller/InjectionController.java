package com.springmvc.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.domain.child;
import com.springmvc.domain.injection;
import com.springmvc.domain.member;
import com.springmvc.service.InjectionListService;
import com.springmvc.service.InjectionService;


@Controller
public class InjectionController {

    @Autowired
    InjectionListService listservice;

    @Autowired
    InjectionService service;
    
    @GetMapping("/calendar")
    public String showCalendar(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("member") == null) {
            return "redirect:/login";
        }

        member mb = (member) session.getAttribute("member");
        String sessionId = mb.getId();
        model.addAttribute("id", sessionId);
        return "injection_calendar";
    }

 
    @GetMapping("/injectionlist")
    @ResponseBody
    public ResponseEntity<List<injection>> getInjectionList(HttpServletRequest request) {
        member mb = getMemberFromSession(request);
        if (mb == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        List<injection> injectionList = service.getInjectionList(mb.getId());
        return ResponseEntity.ok(injectionList);
    }

 
    @PostMapping("/testinjection")
    @ResponseBody
    public ResponseEntity<List<child>> getChildBirth(@RequestParam String id) {
        System.out.println(id);
    	
    	List<child> child = service.getChildBirth(id);
        System.out.println(child);
        
        if (child == null || child.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(child);
        }
        return ResponseEntity.ok(child);
    }

    private member getMemberFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        return (member) session.getAttribute("member");
    }

    private LocalDate parseDate(String dateStr) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        try {
            return LocalDate.parse(dateStr, formatter);
        } catch (Exception e) {
            return null;
        }
    }

    private void insertBirthAndInjections(String id, LocalDate birthdayDate) {
        Map<String, LocalDate> injectiondate = service.injectiondate(birthdayDate);
        service.insertBirth(id, birthdayDate, injectiondate);
    }
    
    @PostMapping("/getChildInjection")
    @ResponseBody
    public ResponseEntity<List<injection>> getChildInjection(@RequestParam("childId") String id, @RequestParam("birth") String birth) {
        LocalDate birthdayDate = parseDate(birth);
        insertBirthAndInjections(id, birthdayDate);
        List<injection> injections = service.getInjections(id, birthdayDate);

        return ResponseEntity.ok(injections);
    }

}
