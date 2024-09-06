package com.springmvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springmvc.domain.member;
import com.springmvc.domain.product;
import com.springmvc.domain.product_detail;
import com.springmvc.domain.productboard;
import com.springmvc.domain.review;
import com.springmvc.repository.Product_Repository;
import com.springmvc.service.ProductBoardService;
import com.springmvc.service.ProductService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductBoardController {

    @Autowired
    ProductBoardService service;

    @Autowired
    ProductService productService;

    @GetMapping("/list")
    public String list(@RequestParam(value="pageNum", defaultValue = "1") int pageNum,
                       @RequestParam(defaultValue = "all") String category,
                       Model model) {
    	
    	List<product> productDetails= null;
        int limit = 6; 
        int offset = (pageNum - 1) * limit; 
        int totalRecords;
  
        // 카테고리에 따른 게시물 필터링
        if ("all".equals(category)) {
            //게시물 가져오기(특정페이지)
        	productDetails = productService.getProduct(offset, limit);
        	//게시물 수 세기
        	totalRecords = productService.countProduct(); // 전체 제품 수
        } else {
            productDetails = productService.getProductByCategory(limit, offset, category);
            totalRecords = productService.countProductByCategory(category); // 카테고리별 제품 수
        }


        // 페이지 계산
        int totalPages = (int) Math.ceil((double) totalRecords / limit);
        
        
        // 모델에 데이터 추가
        model.addAttribute("limit", limit);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("productDetails", productDetails);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("category", category);

        return "product_list"; // JSP 뷰 이름
    }

    // 제품 등록 폼 처리
    @PostMapping("/write")
    public String write(@RequestParam("id") String id,
                        @RequestParam("name") String name,
                        @RequestParam("price") int price,
                        @RequestParam("brand") String brand,
                        @RequestParam("category") String category,
                        @RequestParam("link") String link,
                        @RequestParam("image") String image,
                        HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        member mb = (member) (session != null ? session.getAttribute("member") : null);

        if (mb == null) {
            return "redirect:/product/list"; // 세션이 없으면 목록으로 리다이렉트
        }

        // 제품 정보와 게시판 정보를 저장
        product newProduct = new product(name, price, brand, category, link, image);
        productboard newProductBoard = new productboard(mb.getId(), newProduct.getProduct_id(), new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date()), 0, request.getRemoteAddr());

        // 제품과 게시글 저장
        service.addProductAndBoard(newProduct, newProductBoard);

        return "redirect:/product/list"; // 작성 후 목록으로 리다이렉트
    }


    @PostMapping("/update")
    public String updateSubmit(@RequestParam int num, @RequestParam int pageNum, productboard pd) {
        service.update(pd);
        return "redirect:/product/detailview?num=" + num + "&pageNum=" + pageNum;
    }

    // 제품 삭제
    @GetMapping("/delete")
    public String delete(@RequestParam int num, @RequestParam int pageNum) {
        service.delete(num);
        return "redirect:/product/list?pageNum=" + pageNum;
    }
    
    @RequestMapping(value = "/productDetail/{productId}", method = RequestMethod.GET)
    public String getProductDetail(@PathVariable("productId") int productId, Model model, HttpServletRequest request) {
      
    	HttpSession session = request.getSession(false);
    	member mb = null;
    	    
    	if (session != null) {
    	    mb = (member) session.getAttribute("member");
    	}
    	
        product_detail product = service.getProductDetailById(productId);
        
        List<review> rv = service.readReview(productId);
        
        System.out.println(product);
        

        if (product == null) {
            return "error"; 
        }
        
        model.addAttribute("review", rv);
        model.addAttribute("product", product);
        
        if (mb != null) {
            model.addAttribute("id", mb.getId());
        }
        
        return "product_view";
    }
    
    
    @ResponseBody
    @PostMapping("/review")
    public List<review> createReview(@RequestBody HashMap<String, Object> map) {
        int parents_num = (int) map.get("num");
        String sessionId = (String) map.get("sessionId");
        int score = (int) map.get("score");
        String content = (String) map.get("content");

        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd (HH:mm:ss)");
        String registDay = formatter.format(new java.util.Date());

        review rv = new review();
        rv.setParentsNum(parents_num);
        rv.setId(sessionId);
        rv.setScore(score);
        rv.setContent(content);
        rv.setRegistDay(registDay);

        service.createReview(rv);
        
        List<review> review = new ArrayList<review>();
        review = service.readReview(parents_num);
        
        return review;
    }
    
    @GetMapping("/reviewread")
    @ResponseBody
    public review readOneReview(@RequestParam("num") int num) {
        return service.readOneReview(num);
    }
    
    
    
    @ResponseBody
    @PostMapping("/reviewupdate")
    public List<review> updateReview(@RequestBody HashMap<String, Object> map) {
    	int num = (int)map.get("num");
    	int parents_num = (int) map.get("parents_num");
        String sessionId = (String) map.get("sessionId");
        int score = (int) map.get("score");
        String content = (String) map.get("content");
    	
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd (HH:mm:ss)");
        String registDay = formatter.format(new java.util.Date());
        
        review rv = new review();
        rv.setNum(num);
        rv.setParentsNum(parents_num);
        rv.setId(sessionId);
        rv.setScore(score);
        rv.setContent(content);
        rv.setRegistDay(registDay);

        service.updateReview(rv);
        
    	List<review> review = new ArrayList<review>();
    	review = service.readReview(parents_num);

        return review;
    }


}
