package com.springmvc.domain;

public class board {

    private int num;
    private String id;
    private String name;
    private String subject;
    private String content;
    private String registDay;
    private int hit;
    private String ip;
    private String target; //지원대상
    private String institute; //부서명

    // 기본 생성자
    public board() {
    }

    // 매개변수를 받는 생성자
    public board(int num, String id, String name, String subject, String content, String registDay, int hit, String ip, String target, String institute) {
        this.num = num;
        this.id = id;
        this.name = name;
        this.subject = subject;
        this.content = content;
        this.registDay = registDay;
        this.hit = hit;
        this.ip = ip;
        this.target = target;
        this.institute = institute;
    }

    // Getter 및 Setter 메서드
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
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

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getInstitute() {
		return institute;
	}

	public void setInstitute(String institute) {
		this.institute = institute;
	}
}
