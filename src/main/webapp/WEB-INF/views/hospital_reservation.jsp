<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.member"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 예약</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/hospital_reservation.css">
</head>
<body>
<%
    member mb = (member) session.getAttribute("member");
    String hospitalname = (String) request.getAttribute("name");

    if (mb == null) {
        // 세션에 멤버 정보가 없는 경우 로그인 페이지로 리다이렉트
        response.sendRedirect("/ibom/login");
    }
%>
    <div class="reservation-container">
        <div class="reservation-form">
            <h5 class="text-center">병원 예약</h5>
            <form:form modelAttribute="reservation" action="reserve" method="post" accept-charset="UTF-8">
                <!-- primary-key로 아이디 사용해야 함 -->
                <form:input path="id" name="id" type="hidden" class="form-control" value="<%= mb.getId() %>" />
                <div class="mb-3">
                    <label class="form-label">병원명</label>
                    <form:input path="hospitalName" type="text" class="form-control" id="hospitalName" name="hospitalName" value="<%= hospitalname %>" readonly="true" />
                </div>
                <div class="mb-3">
                    <label class="form-label">이름</label>
                    <form:input path="name" type="text" class="form-control" id="name" name="name" value="<%= mb.getName() %>" readonly="true" />
                </div>
                <div class="mb-3">
                    <label class="form-label">생년월일</label>
                    <form:input path="birth" type="date" class="form-control" id="birth" name="birth" value="<%= mb.getBirth() %>" readonly="true" />
                </div>
                <div class="mb-3">
                    <label for="datePicker" class="form-label">예약 날짜</label>
                    <form:input path="date" type="date" class="form-control" id="datePicker" name="date" required="true" />
                </div>
                <div class="mb-3">
                     <label for="timePicker" class="form-label">예약 시간</label>
                    <form:select path="time" id="timePicker" name="time" class="form-control" required="true">
                        <form:option value="">날짜를 먼저 선택하세요</form:option>
                        <form:options items="${availableTimes}" />
                    </form:select>
                </div>
                <button type="submit" class="btn btn-primary w-100">예약하기</button>
            </form:form>
        </div>
        <div class="reservation-image"></div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 현재 날짜를 가져옴
        var today = new Date().toISOString().split('T')[0];

        // 날짜 입력 필드에 현재 날짜를 최소값으로 설정
        document.getElementById('datePicker').setAttribute('min', today);

        // 생년월일 입력 필드에 현재 날짜를 최대값으로 설정
        document.getElementById('birth').setAttribute('max', today);

        document.getElementById('datePicker').addEventListener('change', function() {
            var date = this.value;
            var timePicker = document.getElementById('timePicker');
            timePicker.innerHTML = ''; // 시간 목록 초기화

            if (date) {
                // 실제로는 서버에서 가능한 시간을 가져와야 합니다.
                // 여기서는 예시로 하드코딩된 시간대를 사용합니다.
                var availableTimes = ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00', '17:00', '18:00'];
                availableTimes.forEach(time => {
                    var option = document.createElement('option');
                    option.value = time;
                    option.textContent = time;
                    timePicker.appendChild(option);
                });
            }
        });
    </script>
</body>
</html>
