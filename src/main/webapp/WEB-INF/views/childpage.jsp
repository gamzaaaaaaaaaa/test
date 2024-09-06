<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.domain.member"%>
<%@ page import="com.springmvc.domain.child"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    

<%
    member user = (member) session.getAttribute("member");
   
%>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>childpage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/childpage.css">
</head>
<body>
    <div class="container">
        <div class="card mb-4">
            <div class="card-header"><h5>User Information</h5></div>
            <div class="card-body">
                <p><strong>Name:</strong> <%= user.getName() %></p>
            </div>
        </div>

        <div class="card">
            <div class="card-header"><h5>My Children</h5></div>
            <div class="card-body">
                <c:if test="${not empty childmodel}">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>이름</th>
                                <th>생년월일</th>
                                <th>측정일</th>
                                <th>키(cm)</th>
                                <th>몸무게(kg)</th>
                                <th>머리둘레(cm)</th>
                                <th>성별</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="child" items="${childmodel}">
                                <tr>
                                    <td>${child.name}</td>
                                    <td>${child.birth}</td>
                                    <td>${child.day}</td>
                                    <td>${child.height} cm</td>
                                    <td>${child.weight} kg</td>
                                    <td>${child.head} cm</td>
                                    <td>${child.gender}</td>
                                    <td><a href="/ibom/childs/details?one=${child.num}" class="btn-info">상세보기</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty childmodel}">
                    <p>No children registered.</p>
                </c:if>
            </div>
        </div>

        <a href="/ibom" class="btn btn-primary mt-4">Home</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
