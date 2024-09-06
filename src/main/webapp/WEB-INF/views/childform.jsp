 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아기 정보 입력</title>
    <link href="//fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&amp;display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/c6a9b9191d.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/childform.css">
</head>
<body>
    <div class="form-container">
        <div class="form-content">
            <h5 class="text-center"><i class="fa-solid fa-baby"></i> 아기 정보 입력</h5>
            <form:form modelAttribute="child" action="child" method="post" >

                <div class="mb-3">
                    <label for="name" class="form-label">이름</label>
                    <form:input path="name" type="text" class="form-control" id="name" name="name" required="required" />
                </div>
                <div class="mb-3 genders">
				    <label class="form-label">성별</label>
				    <div class="displayflex">
					    <div>
					        <form:radiobutton path="gender"  id="male" name="gender" value="male" required="required" />
					        <label for="male">남자</label>
					    </div>
					    <div>
					        <form:radiobutton path="gender"  id="female" name="gender" value="female" required="required" />
					        <label for="female">여자</label>
					    </div>
				    </div>
				    
				</div>
                <div class="mb-3">
                    <label for="birthdate" class="form-label">생년월일</label>
                    <form:input path="birth" type="date" class="form-control" id="birth" name="birth" required="required" />
                </div>
                <div class="mb-3">
                    <label for="measurement_date" class="form-label">측정일</label>
                    <form:input path="day" type="date" class="form-control" id="day" name="day" required="required" />
                </div>
                <div class="mb-3">
                    <label for="height" class="form-label">키 (cm)</label>
                    <form:input path="height" type="number" class="form-control" id="height" name="height" step="0.1" required="required" />
                </div>
                <div class="mb-3">
                    <label for="weight" class="form-label">몸무게 (kg)</label>
                    <form:input path="weight" type="number" class="form-control" id="weight" name="weight" step="0.1" required="required" />
                </div>
                <div class="mb-3">
                    <label for="head_circumference" class="form-label">머리둘레 (cm)</label>
                    <form:input path="head" type="number" class="form-control" id="head" name="head" step="0.1" required="required" />
                </div>
                <div class="button-container mb-4">
	                <button type="submit" class="btn-childform">제출</button>
	                <a href="/ibom" class="btn-back">홈으로</a>
                </div>
            </form:form>
        </div>
        <div class="image-container"></div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
