package com.springmvc.repository;

import com.springmvc.domain.productboard;
import com.springmvc.domain.review;

import java.util.ArrayList;
import java.util.List;

public interface ProductBoard_Repository {
	public void addProductBoard(productboard productBoard);
    public List<productboard> findAll(int offset, int limit);
    public List<productboard> findByCategory(String category, int offset, int limit);
    public int count();
    public int countByCategory(String category);
    public productboard findById(int num);
    public void update(productboard productBoard);
    public void delete(int num);
    public void incrementHit(int num);
    public void createReview(review rv);
    public ArrayList<review> readReview(int parents_num);
    public boolean reviewExists(int num, String id);
    public void updateReview(review review);
    public review readOneReview(int num);
}
