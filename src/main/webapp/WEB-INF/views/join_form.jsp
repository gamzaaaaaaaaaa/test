<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/e561738355.js" crossorigin="anonymous"></script>
    <style>
        main{height:400px;}
    </style>
</head>
<body>
  <header class="p-3 text-bg-dark">
    <div class="container">
      <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
        <a href="/board" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
          <i class="fa-solid fa-keyboard"></i>
        </a>

        <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
          <li><a href="/board" class="nav-link px-2 text-secondary">Home</a></li>
          <li><a href="board" class="nav-link px-2 text-white">게시판</a></li>
          <li><a href="#" class="nav-link px-2 text-white">...</a></li>
          <li><a href="#" class="nav-link px-2 text-white">...</a></li>
          <li><a href="#" class="nav-link px-2 text-white">...</a></li>
        </ul>

        <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
          <input type="search" class="form-control form-control-dark text-bg-dark" placeholder="Search..." aria-label="Search">
        </form>

        <div class="text-end">
          <button type="button" role="link" class="btn btn-outline-light me-2" onclick="location.href='login';">로그인</button>
          <button type="button" class="btn btn-warning" role="link" onclick="location.href='join';">회원가입</button>
        </div>
      </div>
    </div>
  </header>
  
 <div class="container">
    <main>
        <div class="py-5 text-center">
            <h2>회원가입</h2>
            <p class="lead">테스트를 진행할 아이디와 패스워드 이름을 입력해주세요.</p>
        </div>
        <div class="row g-8">
            <div class="col-md-7 col-lg-8">
	            <h4 class="mb-3">회원가입양식</h4>
	            <form:form modelAttribute="member" class="needs-validation" method="post" action="join">
	                <div class="row g-3">          
	                    <div class="col-12">
	                        <label for="name" class="form-label">이름</label>
			                <div class="input-group has-validation">
			                    <span class="input-group-text">1</span>
			                    <form:input path="name" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요."  required="required" />
			                    <div class="invalid-feedback">Valid name is required.</div>
			                </div>
	                    </div>
	
	                    <div class="col-12">
	                        <label for="id" class="form-label">아이디</label>
	                        <div class="input-group has-validation">
	                            <span class="input-group-text">2</span>
	                            <form:input path="id"  class="form-control" id="id" name="id" placeholder="아이디를 입력해주세요" required="required" />
	                            <div class="invalid-feedback">
	                                Your id is required.
	                            </div>
	                        </div>
	                    </div>
	                    
	                    <div class="col-12">
	                        <label for="pw" class="form-label">패스워드</label>
	                        <div class="input-group has-validation">
	                            <span class="input-group-text">3</span>
	                            <form:password path="pw"  class="form-control" id="pw" name="pw" placeholder="패스워드를 입력해주세요" required="required" />
	                            <div class="invalid-feedback">
	                                Your password is required.
	                            </div>
	                        </div>
	                    </div>
	                </div> 
	                <br><br>
	                <button class="w-100 btn btn-primary btn-lg" type="submit">회원가입하기</button>
	            </form:form>
            </div>
        </div>
    </main>
</div>

</body>
</html>