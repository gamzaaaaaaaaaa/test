package com.springmvc.repository;

import com.springmvc.domain.productboard;
import com.springmvc.domain.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductBoard_RepositoryImpl implements ProductBoard_Repository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 게시물 저장
    @Override
    public void addProductBoard(productboard productBoard) {
        String sql = "INSERT INTO product_board (id, product_id, registDay, hit, ip) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, productBoard.getId(), productBoard.getProduct_id(),
                productBoard.getRegistDay(), productBoard.getHit(), productBoard.getIp());
    }

    // 전체 게시물 조회
    @Override
    public List<productboard> findAll(int offset, int limit) {
        String sql = "SELECT * FROM product_board LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, new ProductBoardRowMapper(), limit, offset);
    }

    // 카테고리별 게시물 조회
    @Override
    public List<productboard> findByCategory(String category, int offset, int limit) {
        String sql = "SELECT pb.* FROM product_board pb JOIN product p ON pb.product_id = p.product_id WHERE p.category = ? LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, new ProductBoardRowMapper(), category, limit, offset);
    }

    // 게시물 수 조회
    @Override
    public int count() {
        String sql = "SELECT COUNT(*) FROM product_board";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // 카테고리별 게시물 수 조회
    @Override
    public int countByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM product_board pb JOIN product p ON pb.product_id = p.product_id WHERE p.category = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, category);
    }

    // 단일 게시물 조회
    @Override
    public productboard findById(int num) {
        String sql = "SELECT * FROM product_board WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new ProductBoardRowMapper(), num);
    }

    // 게시물 업데이트
    @Override
    public void update(productboard productBoard) {
        String sql = "UPDATE product_board SET registDay = ?, hit = ?, ip = ? WHERE id = ?";
        jdbcTemplate.update(sql, productBoard.getRegistDay(), productBoard.getHit(),
                productBoard.getIp(), productBoard.getId());
    }

    // 게시물 삭제
    @Override
    public void delete(int num) {
        String sql = "DELETE FROM product_board WHERE id = ?";
        jdbcTemplate.update(sql, num);
    }

    // 조회수 증가
    @Override
    public void incrementHit(int num) {
        String sql = "UPDATE productboard SET hit = hit + 1 WHERE id = ?";
        jdbcTemplate.update(sql, num);
    }
    
    public void createReview(review rv) {
    	String sql = "insert into review (id, parentsNum, score, content, registDay) values (?, ?, ?, ?, ?)";
    	jdbcTemplate.update(sql, rv.getId(), rv.getParentsNum(), rv.getScore(), rv.getContent(), rv.getRegistDay());
    }

    public ArrayList<review> readReview(int parents_num){
        String sql = "select * from review where parentsNum = ? ORDER BY num DESC";
    	return (ArrayList<review>) jdbcTemplate.query(sql,new Object[]{parents_num}, new ReviewRowMapper());
    	
    }
    
    public boolean reviewExists(int num, String id) {
        String sql = "select count(*) from review where num = ? and id = ? ";
        Integer count = jdbcTemplate.queryForObject(sql, new Object[]{num, id}, Integer.class);
        return count != null && count > 0;
    }

    public void updateReview(review review) {
        String sql = "update review set score = ?, content = ? where id = ? and num = ?";
        jdbcTemplate.update(sql, review.getScore(), review.getContent(), review.getId(), review.getNum());

    }
    
    public review readOneReview(int num) {
    	String sql = "select * from review where num = ?";
    	return jdbcTemplate.queryForObject(sql, new Object[]{num}, new ReviewRowMapper());
    }
    
    
    
}
