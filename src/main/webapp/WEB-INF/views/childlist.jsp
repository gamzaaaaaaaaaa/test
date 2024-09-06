<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기록 리스트</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/childlist.css">   
</head>
<body>
    <div class="container">
        <h2 class="text-center list-color">기록 리스트</h2>
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th>이름</th>
                    <th>성별</th>
                    <th>생년월일</th>
                    <th>측정일</th>
                    <th>키 (cm)</th>
                    <th>몸무게 (kg)</th>
                    <th>머리둘레 (cm)</th>
                    <th>상세보기</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty childmodel}">
                        <c:forEach var="childfor" items="${childmodel}">
                            <tr>
                                <td>${childfor.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${childfor.gender == 'male'}">남자</c:when>
                                        <c:otherwise>여자</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${childfor.birth}</td>
                                <td>${childfor.day}</td>
                                <td>${childfor.height}cm</td>
                                <td>${childfor.weight}kg</td>
                                <td>${childfor.head}cm</td>
                                <td>
                                    <a href="/ibom/childs/details?one=${childfor.num}" class="btn-view">상세보기</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8">데이터가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <div class="text-center">
            <a href="/ibom" class="btn-view">홈으로</a>
            <a href="/ibom/childs/child" class="btn-view">기록 추가하기</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
