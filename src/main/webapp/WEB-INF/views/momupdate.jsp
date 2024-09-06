<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>산모 정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/momupdate.css">
</head>
<body>
    <div class="container">
        <h2>산모 정보 수정</h2>
        <form action="update" method="post">
            <input type="hidden" name="num" value="${mommodel.num}" />
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" name="name" value="${mommodel.name}" required readonly>
            </div>

            <div class="mb-3">
                <label for="lastday" class="form-label">마지막 월경일</label>
                <input type="date" class="form-control" id="lastday" name="lastday" value="${mommodel.lastday}" required>
            </div>

            <div class="mb-3">
                <label for="first_visit" class="form-label">병원 방문일</label>
                <input type="date" class="form-control" id="first_visit" name="first_visit" value="${mommodel.first_visit}" required>
            </div>

            <div class="mb-3">
                <label for="weeksPregnant" class="form-label">임신 주수</label>
                <input type="text" class="form-control" id="weeksPregnant" name="weeksPregnant" value="${mommodel.weeksPregnant}" readonly>
            </div>

            <div class="mb-3">
                <label for="nextVisitDate" class="form-label">다음 방문 예정일</label>
                <input type="date" class="form-control" id="nextVisitDate" name="nextVisitDate" value="${mommodel.nextVisitDate}" readonly>
            </div>

            <div class="mb-3">
                <label for="dueDate" class="form-label">출산 예정일</label>
                <input type="date" class="form-control" id="dueDate" name="dueDate" value="${mommodel.dueDate}" readonly>
            </div>

            <div class="mb-3">
                <label for="visitFrequency" class="form-label">추천 방문 주기</label>
                <input type="text" class="form-control" id="visitFrequency" name="visitFrequency" value="${mommodel.visitFrequency}" readonly>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary">저장하기</button>
                <a href="momlist" class="btn btn-primary">취소</a>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
