package com.springmvc.domain;

public class productboard {

    private int num;
    private String id;
    private int product_id;
    private String registDay; 
    private int hit;
    private String ip;


    public productboard() {
    }

	public productboard(String id, int product_id, String registDay, int hit, String ip) {
		super();
		this.id = id;
		this.product_id = product_id;
		this.registDay = registDay;
		this.hit = hit;
		this.ip = ip;
	}

	public int getNum() {
		return num;
	}


	public void setNum(int num) {
		this.num = num;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public int getProduct_id() {
		return product_id;
	}


	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}


	public String getRegistDay() {
		return registDay;
	}


	public void setRegistDay(String registDay) {
		this.registDay = registDay;
	}


	public int getHit() {
		return hit;
	}


	public void setHit(int hit) {
		this.hit = hit;
	}


	public String getIp() {
		return ip;
	}


	public void setIp(String ip) {
		this.ip = ip;
	}

	  @Override
	    public String toString() {
	        return "productboard{" +
	               "id=" + id +
	               ", product_id='" + product_id + '\'' +
	               ", registDay=" + registDay +
	               ", hit=" + hit +
	               ", ip='" + ip + '\'' +
	               '}';
	    }

}
