<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이 정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/childupdate.css">
</head>
<body>
    <div class="container">
        <h2>아이 정보 수정</h2>
        <form:form modelAttribute="child" action="update" method="post">
        	<input type="hidden" name="num" value="${child.num}">
            <div class="form-group">
                <label for="name">이름</label>
               <form:input path="name" type="text" id="name" name="name" class="form-control" />
            </div>
            <div class="form-group">
                <label for="birth">생년월일</label>
                <form:input path="birth" type="date" id="birth" name="birth" class="form-control" />
            </div>
            <div class="form-group">
                <label for="day">측정일</label>
                <form:input path="day" type="date" id="day" name="day" class="form-control" />
            </div>
            <div class="form-group">
                <label for="height">키 (cm)</label>
                <form:input path="height" type="number" id="height" name="height" class="form-control" />
            </div>
            <div class="form-group">
                <label for="weight">몸무게 (kg)</label>
                <form:input path="weight" type="number" id="weight" name="weight" class="form-control" />
            </div>
            <div class="form-group">
                <label for="head">머리둘레 (cm)</label>
                 <form:input path="head" type="number" id="head" name="head" class="form-control" />
            </div>
        <div class="form-group">
            <label for="gender">성별</label>
            <form:select path="gender" id="gender" class="form-control">
                <form:option value="male" label="남자" />
                <form:option value="female" label="여자" />
            </form:select>
        </div>
            <div class= "button">
	            <input type="submit" value="수정하기" class="btn btn-primary">
		        <a href="childlist" class="btn btn-primary">이전으로</a>
            </div>
        </form:form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
