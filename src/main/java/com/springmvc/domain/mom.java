package com.springmvc.domain;

public class mom {
	private int num;
	private String id; //로그인이 되어있어야 하기 때문에 필요함
	private String name; 
	private String lastday; // 마지막 월경일
	private String first_visit; 
	//병원방문일(첫 방문일에서 임신 주수 계산 때문에 병원방문일로 수정)
	private long weeksPregnant; // 임신 주수
	private int visitFrequency; // 방문 주기
    private String nextVisitDate; // 다음 방문 예정일
    private String dueDate; // D-Day (일수)
	
	public mom() {
		super();
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

	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getLastday() {
		return lastday;
	}

	public void setLastday(String lastday) {
		this.lastday = lastday;
	}

	public String getFirst_visit() {
		return first_visit;
	}

	public void setFirst_visit(String first_visit) {
		this.first_visit = first_visit;
	}

	public long getWeeksPregnant() {
		return weeksPregnant;
	}

	public void setWeeksPregnant(long weeksPregnant) {
		this.weeksPregnant = weeksPregnant;
	}

	public int getVisitFrequency() {
		return visitFrequency;
	}

	public void setVisitFrequency(int visitFrequency) {
		this.visitFrequency = visitFrequency;
	}

	public String getNextVisitDate() {
		return nextVisitDate;
	}

	public void setNextVisitDate(String nextVisitDate) {
		this.nextVisitDate = nextVisitDate;
	}


	public String getDueDate() {
		return dueDate;
	}


	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
		
	}

}
