package com.springmvc.domain;

public class InjectionList {
	private String listid;
	private String userid;
	private String birth;
	private String title;
	private String date;
	
	
	public InjectionList() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public String getBirth() {
		return birth;
	}



	public void setBirth(String birth) {
		this.birth = birth;
	}



	public String getListid() {
		return listid;
	}


	public void setListid(String listid) {
		this.listid = listid;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}
	
    @Override
    public String toString() {
        return "InjectionList{" +
                "listid='" + listid + '\'' +
                ", title='" + title + '\'' +
                ", date='" + date + '\'' +
                ", userId='" + userid + '\'' +
                '}';
    }
	
	
}
