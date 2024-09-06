<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.domain.member"%>
<%@ page import="com.springmvc.domain.board"%>

<%
    member user = (member) session.getAttribute("member");
%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/mypage.css">
</head>
<body>
    <div class="sidebar">
        <h4>Menu</h4>
        <a href="/ibom/mypage">내 정보 보기</a>
        <a href="/ibom/childpage">내 아이 정보</a>
        <a href="/ibom/hospitalinfo">병원 예약 확인</a>
    </div>
    <div class="content">
        <div class="container">
            <h1 class="text-center">My Page</h1>
            <div class="card mb-4">
                <div class="card-header">User Information</div>
                <div class="card-body">
                    <p><strong>ID:</strong> <%= user.getId() %></p>
                    <p><strong>Password:</strong> <%= user.getPw() %></p>
                    <p><strong>Name:</strong> <%= user.getName() %></p>
                    <p><strong>Postcode:</strong> <%= user.getPostcode() %></p>
                    <p><strong>Address:</strong> <%= user.getAddress() %></p>
                    <p><strong>Detail Address:</strong> <%= user.getDetailAddress() %></p>
                    <p><strong>Extra Address:</strong> <%= user.getExtraAddress() %></p>
                    <p><strong>Birth:</strong> <%= user.getBirth() %></p>
                    <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                    <p><strong>Due:</strong> <%= user.getDue() %></p>
                    <a href="/ibom/editmember" class="btn btn-primary w-100">Edit Profile</a>
                    <a href="/ibom" class="btn btn-primary w-100">Home</a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
