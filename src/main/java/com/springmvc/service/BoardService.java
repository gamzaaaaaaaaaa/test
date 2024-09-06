package com.springmvc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.domain.board;
import com.springmvc.repository.Board_Repository;

@Service
public class BoardService {

	@Autowired
	Board_Repository dao;
	
	
	public List<board> listall(int offset, int limit){
		List<board> list = dao.listall(offset, limit);
		return list;
	}
	
	public int count_record() {
		int num = dao.count_record();
		return num;
	}
	
	public void create(board bd) {
		dao.create(bd);
	}
	
	public board listone(int num) {
		board bd = dao.listone(num);
		return bd;
	}
	
	public void updateHit(int num) {
		dao.updateHit(num);
	}
	
	public List<board> listAllPosts(){
		List<board> bd = dao.listAllPosts();
		return bd;
	}
	
	public void update(board bd) {
		dao.update(bd);
	}
	
	public void delete(int num) {
		dao.delete(num);
	}
	
	public List<board> searchItem(String category, String text){
		System.out.println("service:"+category);
		System.out.println("service:"+text);
		List<board> list = dao.searchItem(category, text);
		System.out.println("service:"+list);
		return list;
	}
}
