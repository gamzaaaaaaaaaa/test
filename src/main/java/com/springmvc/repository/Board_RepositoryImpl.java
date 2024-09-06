package com.springmvc.repository;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.domain.board;

@Repository
public class Board_RepositoryImpl implements Board_Repository{

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    // create: 새 게시물 생성
    public void create(board bd) {
        String sql = "insert into board (id, name, subject, content, registDay, hit, ip, target, institute) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, bd.getId(), bd.getName(), bd.getSubject(), bd.getContent(), bd.getRegistDay(), bd.getHit(), bd.getIp(), bd.getTarget(), bd.getInstitute());
    }

    // read: 전체 테이블의 개수
    public int count_record() {
        String sql = "select count(*) from board";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // read: 특정 페이지의 게시물 조회
    public List<board> listall(int offset, int limit) {
        String sql = "select * from board order by num desc limit ?, ?";
        return jdbcTemplate.query(sql, new Object[] { offset, limit }, new BeanPropertyRowMapper<>(board.class));
    }

    // read: 전체 게시물 조회
    public List<board> listAllPosts() {
        String sql = "select * from board order by num desc";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(board.class));
    }

    // read: 특정 게시물 조회
    public board listone(int num) {
        String sql = "select * from board where num = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(board.class), num);
    }

    // update: 조회수 증가
    public void updateHit(int num) {
        String sql = "update board set hit = hit + 1 where num = ?";
        jdbcTemplate.update(sql, num);
    }

    // update: 게시물 수정
    public void update(board bd) {
        String sql = "update board set subject = ?, content = ?, registDay = ?, ip = ?, target = ?, institute = ? where num = ?";
        jdbcTemplate.update(sql, bd.getSubject(), bd.getContent(), bd.getRegistDay(), bd.getIp(), bd.getTarget(), bd.getInstitute(), bd.getNum());
    }

    // delete: 게시물 삭제
    public void delete(int num) {
        String sql = "delete from board where num = ?";
        jdbcTemplate.update(sql, num);
    } 
    
    public List<board> searchItem(String category, String text) {
    	System.out.println("repository:"+category);
    	System.out.println("repository:"+text);
    	
    	String sql = "select * from board where " + category + " like ?";
        String plustext = "%" + text + "%";
        
        System.out.println("repository:"+plustext);
        
        try {
            return jdbcTemplate.query(sql, new Object[]{plustext}, new BoardRowMapper());
        } catch (DataAccessException e) {
            // 예외 처리: 예를 들어, 로그를 남기거나 사용자에게 오류 메시지를 전달
            e.printStackTrace();
            throw e;
        }
    }

    
}
