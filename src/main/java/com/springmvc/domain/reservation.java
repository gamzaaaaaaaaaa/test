package com.springmvc.domain;

public class reservation {
	private String id;
	private String hospitalName;
	private String name;
	private String birth;
	private String date;
	private String time;

	
	private String oldDate;
    private String oldTime;

	
	public reservation() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}



	public String getOldDate() {
		return oldDate;
	}



	public void setOldDate(String oldDate) {
		this.oldDate = oldDate;
	}



	public String getOldTime() {
		return oldTime;
	}



	public void setOldTime(String oldTime) {
		this.oldTime = oldTime;
	}
	
	
}
