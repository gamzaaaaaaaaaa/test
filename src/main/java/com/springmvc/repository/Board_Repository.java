package com.springmvc.repository;

import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.board;

public interface Board_Repository {
	
	 public void create(board bd) ;
	 public int count_record();
	 public List<board> listall(int offset, int limit);
	 public List<board> listAllPosts();
	 public board listone(int num);
	 public void updateHit(int num);
	 public void update(board bd);
	 public void delete(int num);
	 public List<board> searchItem(String category, String text);
}
