package com.springmvc.domain;

public class hospital {
	private String addr;
	private int postNo;
	private String telephone;
	private double XPos;
	private double YPos;
	private String yadmNm;
	
	public hospital() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public hospital(String addr, int postNo, String telephone, double xPos, double yPos, String yadmNm) {
		super();
		this.addr = addr;
		this.postNo = postNo;
		this.telephone = telephone;
		XPos = xPos;
		YPos = yPos;
		this.yadmNm = yadmNm;
	}


	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public double getXPos() {
		return XPos;
	}
	public void setXPos(double xPos) {
		XPos = xPos;
	}
	public double getYPos() {
		return YPos;
	}
	public void setYPos(double yPos) {
		YPos = yPos;
	}
	public String getYadmNm() {
		return yadmNm;
	}
	public void setYadmNm(String yadmNm) {
		this.yadmNm = yadmNm;
	}
	
	
}
