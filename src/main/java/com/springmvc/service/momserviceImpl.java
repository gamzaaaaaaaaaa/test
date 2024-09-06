package com.springmvc.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.domain.mom;
import com.springmvc.repository.momrepoitiroy;

@Service
public class momserviceImpl implements momservice {

    @Autowired
    private momrepoitiroy momRepository;

    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    Calendar calendar = Calendar.getInstance();


    @Override
    public void create(mom mother,HttpServletRequest request) {
        System.out.println("create service");
        momRepository.create(mother,request);
    }

    @Override
    public List<mom> readall() {
        System.out.println("readall service(mom)");
        List<mom> moms = momRepository.readall();

        System.out.println("readall(mom): " + moms.size());


        for (mom mother : moms) {
        	//mom객체의 리스트가 담겨있는 moms를 하나씩 접근한다.
        	
            try {
                // 문자열을 Date로 변환
                if (mother.getLastday() != null && !mother.getLastday().isEmpty()) {
                	//getLastday가 null이 아니고 getLastday가 빈 문자열이 아닐때
                    Date lastDay = formatter.parse(mother.getLastday());
                    Date firstVisit = formatter.parse(mother.getFirst_visit());

                    // 현재 날짜
                    Date now = new Date();

                    // 임신 주수 계산
                    long weeks = firstVisit.getTime() - lastDay.getTime();
                    //현재 날짜에서 마지막 월경일 날짜를 뺌
 
                    long weeksPregnant = TimeUnit.DAYS.convert(weeks, TimeUnit.MILLISECONDS) / 7;
                    // TimeUnit : 시간 단위를 정의, DAYS: 시간을 day 단위로 표현
                    // convert : 주어진 시간 값을 다른 시간단위로 변환한다.
                    // weeks의 단위를 밀리초로 바꾸고 그 결과를 days 단위로 변환,7로 나누어서 주 단위로 변경
                    mother.setWeeksPregnant(weeksPregnant);
                    //mother 객체에 계산한 단위를 set

                    // 출산 예정일 계산
                    Date dueDate = calculDueDate(lastDay);
                    //calculDueDate 함수 실행후 Date 타입으로 저장.
                    mother.setDueDate(formatter.format(dueDate)); 
                    //계산한 출산 예정일을 formatter에서 초기화 한 방식으로 문자열 저장

                    // 병원 방문 주기 계산 및 다음 방문 예정일 계산
                    Date nextVisitDate = calculateNextVisitDate(firstVisit, weeksPregnant);
                    //첫 방문일과 임신주수를 가지고  calculateNextVisitDate 함수 계산후 변수에  닫음.
                    
                    mother.setNextVisitDate(formatter.format(nextVisitDate)); // 문자열로 저장
                    //nextVisitDate를 년,월,일 방식으로 초기화 하고 mother 객체에 set함
                    
                    
                    // 방문 주기 설명 저장
                    mother.setVisitFrequency(calculateVisitFrequency(weeksPregnant));
                    //계산된 방문주기를 mother 객체에 저장
                    
                } else {
                    throw new IllegalArgumentException("Invalid date format: null or empty");
                }
            } catch (Exception e) {
                // 날짜 파싱 실패 시
                System.out.println("날짜 파싱 중 오류 발생: " + e.getMessage());
                mother.setVisitFrequency(0);
                mother.setNextVisitDate("계산 불가");
                mother.setDueDate("계산 불가"); // 출산 예정일 계산 불가 시
            }
        }

        return moms;
    }
    

    @Override
    public Date calculDueDate(Date lastDay) {
    	// 임신주수 계산
    	calendar = Calendar.getInstance();
    	//시스템의 현재 시각 정보를 바탕으로 초기화된 calendar 객체를 반환한다.
    	//현재의 연도, 월, 일, 시, 분, 초 등의 정보를 가지고 있다.
        
        calendar.setTime(lastDay);
        //lastDay를 calendar에 set한다
        
        calendar.add(Calendar.DAY_OF_YEAR, 280); 
        //Calendar.DAY_OF_YEAR : 1년중에서 현재 날짜가 몇번째 날인지 나타냄.
        //280일은 더하거나 뺄 숫자를 의미함.
        return calendar.getTime();
    }

	// 임신 주수에 따른 방문 주기 계산
    private int calculateVisitFrequency(long weeksPregnant) {
        if (weeksPregnant <= 11) { //11주차까지
            return 2; // 2주에 1회 방문
        } else if (weeksPregnant <= 27) {  //12~27주차까지
            return 4; // 4주에 1회 방문
        } else if (weeksPregnant <= 36) { //28~36주차까지
            return 2; // 2주에 1회 방문
        } else {
            return 1; // 1주에 1회 방문
        }
    }

    // 다음 방문 예정일 계산

private Date calculateNextVisitDate(Date firstVisit, long weeksPregnant) {
    calendar.setTime(firstVisit);
    if (weeksPregnant <= 11) {
        calendar.add(Calendar.WEEK_OF_YEAR, 2); // 2주 후
    } else if (weeksPregnant <= 27) {
        calendar.add(Calendar.WEEK_OF_YEAR, 4); // 4주 후
    } else if (weeksPregnant <= 36) {
        calendar.add(Calendar.WEEK_OF_YEAR, 2); // 2주 후
    } else {
        calendar.add(Calendar.WEEK_OF_YEAR, 1); // 1주 후
    }
    return calendar.getTime();
}
   
	
	//update
	@Override
    public void update(mom mother) {
        momRepository.update(mother);
    }

	//read
    @Override
    public mom readone(int num) {
        return momRepository.readone(num);
    }
    
    //delete
	@Override
	public void delete(int num) {
		momRepository.delete(num);
	}
    
    
}
