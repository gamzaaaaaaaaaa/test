<!DOCTYPE html>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Navbar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/navi.css">
    <style>
        .logout-btn {
            margin-top: auto; /* 메뉴의 맨 아래로 이동시키기 위한 스타일 */
        }
        .nav-item {
  		  margin-bottom: 5px; /* 항목 간 간격 조정 */
		}
    </style>
</head>
<body>
    <nav class="navbar bg-body-tertiary fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="/ibom">
                <img src="/ibom/resources/images/logo2.png" alt="Logo" height="150" style="padding-left:20px">
            </a>
            <button class="navbar-toggler custom-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation" style="margin-right:30px">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="offcanvasNavbarLabel">아이봄</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                        <li class="nav-item">
                            <!-- 로그인 후 사용자 정보 및 링크 추가 -->
                            <c:if test="${not empty sessionScope.member}">
                                <div class="user-info">
                                    <span>${sessionScope.member.name}님 반갑습니다!</span>
                                    <div>
                                        <a class="nav-link" href="/ibom/mypage">마이페이지</a>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${empty sessionScope.member}">
                                <a class="nav-link" href="/ibom/login">로그인</a>
                            </c:if>
                        </li>
                            <li class="nav-item">
                            <a class="nav-link" href="/ibom/calendar">캘린더</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/board/list?pageNum=1">복지제도</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/apimap">전국산부인과</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/processCsv">아이제품</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/childs/child">아기정보입력</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/childs/childlist">아기정보보기</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/mom/form">병원일정입력</a>
                        </li>   
                        <li class="nav-item">
                            <a class="nav-link" href="/ibom/mom/momlist">병원방문수첩</a>
                        </li>                                                

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                링크2
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">세부링크1</a></li>
                                <li><a class="dropdown-item" href="#">세부링크2</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="#">세부링크3</a></li>
                            </ul>
                        </li>

                        <!-- 로그아웃 버튼을 메뉴 목록의 맨 아래로 이동 -->
                        <c:if test="${not empty sessionScope.member}">
                            <li class="nav-item logout-btn" style="margin-left:auto;">
							    <form action="/ibom/logout" method="post" class="d-inline">
							        <button type="submit" class="btn btn-outline-secondary" style="border-radius: 20px; padding: 5px 10px;">
							            로그아웃 <span style="font-size: 1.2em;">→</span>
							        </button>
							    </form>
							</li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div>
        <!-- 페이지 내용 -->
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
