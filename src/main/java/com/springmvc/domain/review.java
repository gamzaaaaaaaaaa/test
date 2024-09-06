package com.springmvc.domain;

public class review {
	private int num;
	private String id;
	private int parentsNum;
	private int score;
	private String content;
	private String registDay;
	  
	
	
	public review() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public int getParentsNum() {
		return parentsNum;
	}

	public void setParentsNum(int parentsNum) {
		this.parentsNum = parentsNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegistDay() {
		return registDay;
	}

	public void setRegistDay(String registDay) {
		this.registDay = registDay;
	}
	
	
	
}
