package com.springmvc.repository;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.domain.mom;

@Repository
public class momrepositoryImpl implements momrepoitiroy{
	
	private List<mom> listmom = new ArrayList<mom>();
	
	private JdbcTemplate template;
	//database 연결하기 위해 servlet-context.xml에 지정해놓은 객체 초기화
	
	@Autowired
	public void setJdbctemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
		
	}

	@Override
	public void create(mom mother, HttpServletRequest request) {
        System.out.println("create 리파지토리");
        HttpSession session = request.getSession(false);
		String id = (String)session.getAttribute("sessionId");
        
        // nextVisitDate 계산
        String nextVisitDate = calculateNextVisitDate(mother.getFirst_visit(), mother.getVisitFrequency());
        //mother 객체에서 지정값을 가져가 calculateNextVisitDate함수 실행한 값을 String 타입으로 저장
        mother.setNextVisitDate(nextVisitDate);
        //앞의 실행한 값을 mother 객체에 저장.
        String sql = "insert into mom_visit(id,name,lastday, first_visit, visitFrequency, nextVisitDate) values(?,?,?,?,?,?)";
        //sql 구문을 String 타입으로 저장
        template.update(sql,id,mother.getName(),mother.getLastday(), mother.getFirst_visit(),mother.getVisitFrequency(), mother.getNextVisitDate());
        //mother 객체에서 가져온 값을 sql에 set함
        //JdbcTemplate을 실행하는 과정에 Resultset을 받아오는것이 포함되어 있음.
        System.out.println(mother.getLastday() + "_" + mother.getFirst_visit());
        listmom.add(mother);
        //생성된 객체를 Arraylist에 담음
		
	}

	@Override
	public List<mom> readall() {
		System.out.println("readall 리파지토리");
		String sql = "select * from mom_visit";
		listmom = template.query(sql, new MomoneRowMapper());
		return listmom;
	}
	
	@Override
	public mom readone(int num) {
		System.out.println("readone 리파지토리");
		mom motherone = new mom();
		String sql = "SELECT * FROM mom_visit WHERE num = ?";
		motherone =template.queryForObject(sql, new Object[]{num}, new MomoneRowMapper());
		return motherone;
	}
	
    @Override
    public void update(mom mother) {
        System.out.println("update 리파지토리");

        // nextVisitDate 계산
        String nextVisitDate = calculateNextVisitDate(mother.getFirst_visit(), mother.getVisitFrequency());
        mother.setNextVisitDate(nextVisitDate);

        String sql = "UPDATE mom_visit SET lastday = ?, first_visit = ?, visitFrequency = ?, nextVisitDate = ? WHERE num = ?";
        template.update(sql, mother.getLastday(), mother.getFirst_visit(), mother.getVisitFrequency(), mother.getNextVisitDate(), mother.getNum());
    }
    
    
    
    // 날짜 계산 메서드 추가
    private String calculateNextVisitDate(String firstVisit, int visitFrequency) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        //날짜의 형식을 년,월,일 로 받기위해 객체 생성.
        Calendar calendar = Calendar.getInstance();
        //현재 날짜와 시간 정보를 포함한 calendar 객체 생성
        
        try {
            Date firstVisitDate = dateFormat.parse(firstVisit);
            //String firstVisit 을 Date 타입으로 변경함.
            //parse는 주로 String타입을 변경할때 사용하는 함수.
            calendar.setTime(firstVisitDate);
            //calendar 변수에 firstVisitDate 값을 넣음.
            calendar.add(Calendar.DAY_OF_MONTH, visitFrequency);
            //DAY_OF_MONTH : 달력에서 '일' 부분을 나타냄.
            //Calendar.DAY_OF_MONTH 에서 지정한 날짜에서 visitFrequency만큼 일수를 더함.
            
            return dateFormat.format(calendar.getTime());
            // calendar의 날짜를 초기에 지정해둔 년,월,일 방식으로 포맷하여 문자열로 반환함.
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
	@Override
	public void delete(int num) {
		String sql = "delete from mom_visit where num=?";
		template.update(sql, num);
		
	}

	
	
}
