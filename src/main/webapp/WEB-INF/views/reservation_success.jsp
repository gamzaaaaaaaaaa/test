<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.reservation" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 완료</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/reservation_success.css">
</head>
<body>
<%
    reservation rv = (reservation) request.getAttribute("reservation");
%>
    <div class="confirmation-container">
        <h5>예약이 완료되었습니다</h5>
        <div class="confirmation-details">
            <p><strong>병원명:</strong> <%= rv.getHospitalName() %></p>
            <p><strong>이름:</strong> <%= rv.getName() %></p>
            <p><strong>생년월일:</strong> <%= rv.getBirth() %></p>
            <p><strong>예약 날짜:</strong> <%= rv.getDate() %></p>
            <p><strong>예약 시간:</strong> <%= rv.getTime() %></p>
        </div>
        <div class="confirmation-buttons">
            <a href="/ibom/reservation/edit?id=<%= rv.getId() %>&date=<%=rv.getDate()%>&time=<%=rv.getTime() %>" class="btn btn-secondary">예약 수정</a>
            <a href="/ibom/reservation/cancel?id=<%= rv.getId() %>&date=<%=rv.getDate()%>&time=<%=rv.getTime() %>" class="btn btn-danger">예약 취소</a>
        </div>
        <a href="/ibom" class="btn btn-primary mt-3">메인 페이지로 이동</a>
    </div>
</body>
</html>
