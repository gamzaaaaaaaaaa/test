<%@page import="com.springmvc.domain.member"%>
<%@page import="org.apache.commons.collections.bag.SynchronizedSortedBag"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>산모 정보 입력</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	
	<style>
		body {
	        background-color: #f4efec;
	        display: flex;
	        justify-content: center;
	        align-items: center;
	        height: 100vh;
	        margin: 0;
	        font-family: "Noto Sans KR", sans-serif;
	    }
	    
	    .form-container {
	        display: flex;
	        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	        border-radius: 10px;
	        overflow: hidden;
	        background-color: white;
	        width: 800px;
	        max-width: 90%;
	    }
	    
	    
	    .form-content {
	        padding: 40px;
	        display: flex;
	        flex-direction: column;
	        justify-content: center;
	        flex: 1;
	    }
	    .form-content h5 {
	        margin-bottom: 20px;
	        color: #a87e6e;
	        font-size: 25px;
	        font-weight: 700;
	    }
	    .image-container {
	        width: 400px;
	        background-color: white;
	    }
	    .button-container {
	        display: flex;
	        justify-content: space-between;
   		}
		
		.btn-submit, .btn-back {
	        background-color: #a87e6e;
	        border-radius: 8px;
	        color: white;
	        width: 150px;
	        height: 40px;
	        margin-top: 10px;
	        border: none;
	        text-align: center;
	        font-size: 16px;
	        line-height: 40px;
	        transition: all 0.2s;
	    }
	    
	  	.btn-back {
	        margin-left: 10px;
	        text-decoration: none;
	    }
    	.btn-submit:hover, .btn-back:hover {
	        background-color: white;
	        color: black;
	    }
	</style>
</head>

<body>
<%
	String sessionName = (String)request.getAttribute("sessionName");
%>
    <div class="form-container">
        <div class="form-content">
            <h5 class="text-center"><i class="fa-solid fa-user"></i> 산모 정보 입력</h5>
            <form action="form" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">이름</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=sessionName %>" readonly required>
                </div>

                <div class="mb-3">
                    <label for="lastday" class="form-label">마지막 생리 시작일</label>
                    <input type="date" class="form-control" id="lastday" name="lastday" required>
                </div>

                <div class="mb-3">
                    <label for="first_visit" class="form-label">병원 방문일</label>
                    <input type="date" class="form-control" id="first_visit" name="first_visit" required>
                </div>

                <div class="button-container mb-4">
                    <button type="submit" class="btn-submit">제출</button>
                    <a href="/ibom" class="btn-back">뒤로가기</a>
                </div>
            </form>
        </div>
        <div class="image-container">
            <img src="<c:url value='/resources/images/logo2.png'/>"style="width: 100%; height: auto;">
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
