package com.springmvc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.domain.product;
import com.springmvc.domain.product_detail;
import com.springmvc.domain.productboard;
import com.springmvc.domain.review;
import com.springmvc.repository.ProductBoard_Repository;
import com.springmvc.repository.Product_Repository;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductBoardService {

    @Autowired
    private Product_Repository productDAO;

    @Autowired
    private ProductBoard_Repository productBoardDAO;

    // 제품 및 게시물 저장
    public void addProductAndBoard(product product, productboard productBoard) {
        // 제품 저장
        productDAO.addProduct(product);
        int productId = productDAO.getLastInsertId(); // 저장 후 생성된 product_id 반환
        product.setProduct_id(productId);

        // 게시물 저장
        productBoard.setProduct_id(productId); // 외래키 설정
        productBoardDAO.addProductBoard(productBoard);
    }


    // 게시물 목록 조회
    public List<product_detail> listProductDetails(int offset, int limit) {
        List<product_detail> productDetails = productDAO.getProductDetail(offset, limit);
        return productDetails; 
    }
    
    // 카테고리별 제품 상세 정보 조회
    public List<product_detail> listProductDetailsByCategory(String category, int offset, int limit) {
        return productDAO.getProductDetailByCategory(category, offset, limit);
    }

    // 전체 게시물 수 조회
    public int countRecord() {
        return productBoardDAO.count();
    }

    // 단일 게시물 조회
    public product_detail getProductDetailById(int productId) {
        return productDAO.getProductDetailById(productId);
    }

    // 게시물 업데이트
    public void update(productboard productBoard) {
        productBoardDAO.update(productBoard);
    }

    // 게시물 삭제
    public void delete(int num) {
        productBoardDAO.delete(num);
    }

    // 카테고리별 게시물 목록 조회
    public List<productboard> listByCategory(String category, int offset, int limit) {
        return productBoardDAO.findByCategory(category, offset, limit);
    }

    // 카테고리별 게시물 수 조회
    public int countRecordByCategory(String category) {
        return productBoardDAO.countByCategory(category);
    }

    // 조회수 증가
    public void updateHit(int num) {
        productBoardDAO.incrementHit(num);
    }
    
    public void createReview(review rv){
    	productBoardDAO.createReview(rv);
    }
    
    public ArrayList<review> readReview(int parents_num){
    	ArrayList<review> review = productBoardDAO.readReview(parents_num);
    	return review;
    }
    
    public void updateReview(review review) {
    	productBoardDAO.updateReview(review);
    }
    
    public review readOneReview(int num) {
    	return productBoardDAO.readOneReview(num);
    }
    
}
