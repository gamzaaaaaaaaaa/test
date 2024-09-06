<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.reservation"%>
<%@ page import="com.springmvc.domain.member"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/reservation_update.css">
</head>
<body>
<%
    reservation rv = (reservation) request.getAttribute("reservation");
%>
    <div class="reservation-container">
        <div class="reservation-form">
            <h5 class="text-center">예약 수정</h5>
            <form:form modelAttribute="reservation" action="/ibom/updatereserve" method="post">
                <form:input path="id" type="hidden" />
                <form:input path="oldDate" type="hidden" value="${reservation.date}" />
                <form:input path="oldTime" type="hidden" value="${reservation.time}" />
                <div class="mb-3">
                    <label class="form-label">병원명</label>
                    <form:input path="hospitalName" class="form-control" readonly="true" />
                </div>
                <div class="mb-3">
                    <label class="form-label">이름</label>
                    <form:input path="name" class="form-control" readonly="true" />
                </div>
                <div class="mb-3">
                    <label class="form-label">생년월일</label>
                    <form:input path="birth" class="form-control" readonly="true" />
                </div>
                <div class="mb-3">
                    <label class="form-label">예약 날짜</label>
                    <form:input id="datePicker" path="date" type="date" class="form-control" required="true" />
                </div>
                <div class="mb-3">
                    <label class="form-label">예약 시간</label>
                    <form:select id="timePicker" path="time" class="form-control" required="true" >
                        <form:option value="">시간을 선택하세요</form:option>
                        <form:options items="${availableTimes}" />
                    </form:select>
                </div>
                <button type="submit" class="btn btn-primary">수정하기</button>
            </form:form>
        </div>
        <div class="reservation-image"></div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var today = new Date().toISOString().split('T')[0];
            var datePicker = document.getElementById('datePicker');
            var timePicker = document.getElementById('timePicker');

            datePicker.setAttribute('min', today);

            datePicker.addEventListener('change', function() {
                var date = this.value;
                timePicker.innerHTML = ''; 

                if (date) {
                    var availableTimes = ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00', '17:00', '18:00'];
                    availableTimes.forEach(time => {
                        var option = document.createElement('option');
                        option.value = time;
                        option.textContent = time;
                        timePicker.appendChild(option);
                    });
                }
            });
        });
    </script>
</body>
</html>
