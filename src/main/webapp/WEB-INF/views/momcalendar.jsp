<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.springmvc.domain.mom"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat, java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>산모 방문 주기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/momcalendar.css">
	

</head>
<body>
	
    <div class="container">
		<%
			// mommodel 리스트를 가져옴
		    List<mom> momList = (List<mom>) request.getAttribute("mommodel");
		
		    // 리스트가 비어있지 않다면 첫 번째 객체의 출산 예정일을 가져옴
		    LocalDate dueDate = null;
		    String dueDateString = null;
		    long daysUntilDueDate = -1; // 초기화

		    if (momList != null && !momList.isEmpty()) {
		        mom firstMom = momList.get(0);
		        dueDateString = firstMom.getDueDate();
		
		        if (dueDateString != null && !dueDateString.isEmpty()) {
		            // DateTimeFormatter를 사용하여 출산 예정일을 LocalDate로 변환
		            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		            dueDate = LocalDate.parse(dueDateString, formatter);
		            
		            // D-Day 계산
		            LocalDate today = LocalDate.now();
		            daysUntilDueDate = ChronoUnit.DAYS.between(today, dueDate);
		        }
		    }
		    
		    // daysUntilDueDate 값을 request에 저장
		    request.setAttribute("daysUntilDueDate", daysUntilDueDate);
		%>
                                                                                                                                                                                                                        
		<c:choose>
			<c:when test="${daysUntilDueDate >= 0}">
				<div class="alert alert-warning alert-custom list-color" role="alert">
				    <strong>출산 예정일 :</strong>D- ${daysUntilDueDate} 일
				</div>
			</c:when>
			<c:otherwise>
				<div class="alert alert-danger alert-custom list-color" role="alert">
				    출산 예정일을 계산할 수 없습니다.
				</div>
			</c:otherwise>
		</c:choose>

        <h2 class="text-center list-color">병원 방문 수첩</h2>
        <table class="table table-bordered">
            <thead class="table-light">
                <tr> 
                    <th>넘버</th>
                    <th>이름</th>
                    <th>마지막 월경일</th>
                    <th>병원 방문일</th>
                    <th>임신 주수</th>
                    <th>추천 방문 주기</th>
                    <th>다음 방문 예정일</th>
                    <th>출산 예정일</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="mom" items="${mommodel}">
                    <tr>
                        <td>${mom.num}</td>
                        <td>${mom.name}</td>
                        <td>${mom.lastday}</td>
                        <td>${mom.first_visit}</td>
                        <td>${mom.weeksPregnant}주</td>
                        <td>${mom.visitFrequency}주에 1회</td>
                        <td>${mom.nextVisitDate}</td>
                        <td>${mom.dueDate}</td>
                        <td>
                            <a href="delete?num=${mom.num}" class="btn-view delete">삭제</a>
                            <a href="update?num=${mom.num}" class="btn-view update">수정</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

		<nav aria-label="Page navigation">
		    <ul class="pagination justify-content-center">
		        <c:forEach var="i" begin="1" end="${totalPages}">
		            <li class="page-item ${i == currentPage ? 'active' : ''}">
		                <a class="page-link" href="?page=${i}">${i}</a>
		            </li>
		        </c:forEach>
		    </ul>
		</nav>
        <!-- 달력이 표시될 위치 -->
        <div id="calendar"></div>
        
        <div class="text-center">
            <a href="form" class="btn-view">새 방문 추가하기</a>
            <a href="/ibom" class="btn-view">홈으로</a>
        </div>
    </div>

	
    <!-- Bootstrap 및 FullCalendar, jQuery 스크립트 로드 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- JavaScript 코드 추가 -->
    <script>
        $(document).ready(function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                initialView: 'dayGridMonth',
                events: []
            });

            calendar.render();

            // AJAX로 산모 데이터를 가져와서 캘린더에 추가
            $.ajax({
                url: '/ibom/mom/momData',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var eventMap = {};

                    data.forEach(function(mom) {
                        // 마지막 월경일 이벤트 추가
                         if (mom.lastday) {
                            if (!eventMap[mom.lastday]) {
                                calendar.addEvent({
                                    title: '마지막 월경일',
                                    start: mom.lastday,
                                    description: '마지막 월경일: ' + mom.lastday,
                                    color: '#FFA07A'
                                });
                                // 이벤트 추가됨을 기록
                                eventMap[mom.lastday] = true;
                            }
                        }

                        // 첫 병원 방문일 이벤트 추가
                        if (mom.first_visit) {
                            calendar.addEvent({
                                title: '병원 방문일',
                                start: mom.first_visit,
                                description: '병원 방문일: ' + mom.first_visit,
                                color: '#20B2AA'
                            });
                        }

                        // 다음 방문 예정일 이벤트 추가
                        if (mom.nextVisitDate) {
                            calendar.addEvent({
                                title: '다음 방문 예정일 (' + mom.weeksPregnant + '주)',
                                start: mom.nextVisitDate,
                                description: '다음 방문 예정일: ' + mom.nextVisitDate + ' (' + mom.weeksPregnant + '주)',
                                color: '#F08080'
                            });
                        }

                        // 출산 예정일 이벤트 추가 (중복 방지)
                        if (mom.dueDate) {
                            if (!eventMap[mom.dueDate]) {
                                calendar.addEvent({
                                    title: '출산 예정일',
                                    start: mom.dueDate,
                                    description: '출산 예정일: ' + mom.dueDate,
                                    color: '#87CEFA'
                                });
                                // 이벤트 추가됨을 기록
                                eventMap[mom.dueDate] = true;
                            }
                        }
                    });

                    calendar.render();
                },

                error: function(xhr, status, error) {
                    console.error('데이터를 가져오는 중 오류가 발생했습니다.', error);
                }
            });
        });
    </script>

	<script>
    //수정
    document.querySelectorAll(".update").forEach(function(btn) {
        btn.addEventListener("click", function(event) {
            update(event);
        });
    });
    
    // 삭제
    document.querySelectorAll(".delete").forEach(function(btn) {
        btn.addEventListener("click", function(event) {
            deleteConfirmation(event);
        });
    });

    function update(event) {
        console.log("update");

        if (confirm("정보를 수정하시겠습니까?")) {
			// a태그를 사용한거여서 확인을 누르면 지정페이지로 이동.
        } else {

            event.preventDefault();
        }
    }
    
    function deleteConfirmation(event) {
        console.log("delete");
        if (confirm("삭제하시겠습니까?")) {

        } else {

            event.preventDefault();
        }
    }
    </script>
</body>
</html>
