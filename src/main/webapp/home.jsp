<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/home.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/c6a9b9191d.js" crossorigin="anonymous"></script>
</head>
<body>
    <div>
        <%@ include file="navi.jsp" %>
        
        
        <div id="carouselExample" class="carousel slide">
            <!-- 인디케이터 추가 -->
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="/ibom/resources/images/home4.JPG" class="d-block w-100" alt="img1">
                    <div class="tit-wrap">
                        <p>
                            우리 아이의 건강과 행복을 담은 공간
                            <br>
                            아이봄으로 초대합니다.
                        </p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="/ibom/resources/images/hme2.JPG" class="d-block w-100" alt="img2">
                </div>
                <div class="carousel-item">
                    <img src="/ibom/resources/images/home7.jpg" class="d-block w-100" alt="img3">
                </div>
            </div>
            <!-- Optional: Add previous and next controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <div id="introduce" class="">
        <div class="txt_wrap">
            <div class="tit_box">
                <h3 class="s_tit">아이들이 모여 큰 행복을 만드는 곳, 아이봄</h3>
                <div class="tit lh-1">
                    <h1><span class="on tit lh-1">WE ARE</span></h1>
                    <h1><span class="on tit lh-1">IBOM</span></h1>
                </div>
                <p class="tit_desc">
                    <span class="on">WHERE CHILDREN GATHER TO CREATE GREAT HAPPINESS.</span>
                </p>
            </div>
            <div class="txt_box">
                <span class="on">우리 아이의 첫 걸음을 함께하고,</span>
                <span class="on">건강한 성장을 세심하게 돌보며,</span>
                <span class="on">산모와 아기를 위한 맞춤형 케어를 제공하는,</span>
                <span class="on">사랑과 전문성을 담은,</span>
                <span class="on">모든 것을 하나의 공간에서,</span>
                <span class="on">더 나은 미래를 위해 함께합니다.</span>
                <span class="on">우리는 아이봄입니다.</span>
            </div>
        </div>
       <!--  <img src="/ibom/resources/images/logo2.png" class="rounded float-end" alt="img"> -->
    </div>
    <!-- Bootstrap JS, Popper.js, and required dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
		<%@ include file="footer.jsp" %>
    	<%@ include file="joinbtn.jsp" %>
</body>
</html>
