package com.springmvc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.domain.board;
import com.springmvc.domain.member;
import com.springmvc.repository.Board_RepositoryImpl;
import com.springmvc.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
  
    @Autowired
    BoardService service;

    // 게시물 목록 보기
    @GetMapping("/list")
    public String list(@RequestParam(value="pageNum", defaultValue="1") int pageNum, @RequestParam(value="items", required=false) String items, @RequestParam(value="search", required=false) String search, Model model) {
    	
    	ArrayList<board> board_list=null; 
    	int limit = 10;	
    	int offset = (pageNum - 1) * limit; 
        List<board> boardList = service.listall(offset, limit);
        int totalRecords = service.count_record();
        int totalPages = (int) Math.ceil((double) totalRecords / limit); //1. 실수로 나눈 뒤 2.Math.ceil을 통해 소수점 올림 3. 다시 정수로 변환

        
        model.addAttribute("limit", limit);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("boardList", boardList);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPages", totalPages);

        return "board_list"; // JSP 뷰 이름
    }

    // 게시물 작성 폼 보기
    @GetMapping("/write")
    public String write(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        member mb = (member) (session != null ? session.getAttribute("member") : null);

        if (mb != null) {
            model.addAttribute("name", mb.getName());
            model.addAttribute("id", mb.getId());
        } else {
            return "redirect:/ibom/board/board_list"; // 세션이 없으면 목록으로 리다이렉트
        }

        return "board_form"; // JSP 뷰 이름
    }

    // 게시물 작성 처리
    @PostMapping("/write")
    public String write(@RequestParam("id") String id,
                        @RequestParam("name") String name,
                        @RequestParam("institute") String institute,
                        @RequestParam("subject") String subject,
                        @RequestParam("content") String content,
                        @RequestParam("target") String target,
                        HttpServletRequest request) {
        
        HttpSession session = request.getSession(false);
        member mb = (member) (session != null ? session.getAttribute("member") : null);

        if (mb == null) {
            return "redirect:/ibom/board/board_list"; // 세션이 없으면 목록으로 리다이렉트
        }
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String registDay = formatter.format(new Date());
        String ip = request.getRemoteAddr();

        board newBoard = new board();
        newBoard.setId(mb.getId());
        newBoard.setName(name);
        newBoard.setSubject(subject);
        newBoard.setContent(content);
        newBoard.setRegistDay(registDay);
        newBoard.setHit(0); // 초기 조회수는 0
        newBoard.setIp(ip);
        newBoard.setTarget(target);
        newBoard.setInstitute(institute);

        service.create(newBoard);

        return "redirect:/board/list"; // 작성 후 목록으로 리다이렉트
    }

    // 게시물 상세 보기
    @GetMapping("/detailview")
    public String detailview(@RequestParam int num, @RequestParam int pageNum, HttpServletRequest request, Model model) {
        board bd = service.listone(num);

        HttpSession session = request.getSession(false);
        member mb = (member) (session != null ? session.getAttribute("member") : null);
        String sessionId = (mb != null) ? mb.getId() : null;

        model.addAttribute("board", bd);
        model.addAttribute("num", num);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("sessionId", sessionId);

        // 조회수 증가
        service.updateHit(num);

        return "board_view"; // JSP 뷰 이름
    }

    // 모든 게시물 보기 (관리자용 등)
    @GetMapping("/alllist")
    public String allPosts(Model model) {
        List<board> boardList = service.listAllPosts();
        model.addAttribute("boardList", boardList);
        return "board_list"; // JSP 뷰 이름
    }

    // 게시물 수정 폼 보기
    @GetMapping("/update")
    public String update(@RequestParam int num, @RequestParam int pageNum, Model model, HttpServletRequest request) {
        board bd = service.listone(num);
        model.addAttribute("board", bd);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("num", num);
        
        HttpSession session = request.getSession(false);
        member mb = (member) (session != null ? session.getAttribute("member") : null);
        String sessionId = (mb != null) ? mb.getId() : null;
        model.addAttribute("sessionId", sessionId);

        return "board_update"; // JSP 뷰 이름
    }

    // 게시물 수정 처리
    @PostMapping("/update")
    public String updateSubmit(@RequestParam int num, @RequestParam int pageNum, board bd) {
    	service.update(bd);
        return "redirect:/board/board_view?num=" + num + "&pageNum=" + pageNum;
    }


    // 게시물 삭제 처리
    @GetMapping("/delete")
    public String delete(@RequestParam int num, @RequestParam int pageNum) {
    	service.delete(num);
        return "redirect:/board/board_list?pageNum=" + pageNum;
    }
    
    //검색
    @ResponseBody
    @PostMapping("/search")
    public List<board> searchItem(@RequestBody HashMap<String, Object> map){
    	String category = (String)map.get("category");
    	String text = (String)map.get("text");
    	
    	System.out.println(category);
    	System.out.println(text); 
    	
    	//읽어서 가져오기
    	List<board> list = new ArrayList<board>();
    	list = service.searchItem(category, text);
    	System.out.println(list);
    	
    	return list;
    	
    }

}
