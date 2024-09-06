<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>산모 정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">산모 정보 수정</h2>
        <form action="update" method="post">
            <input type="hidden" name="id" value="${mommodel.id}">
            <div class="form-group">
                <label for="lastday">마지막 월경일:</label>
                <input type="date" id="lastday" name="lastday" class="form-control" value="${mommodel.lastday}">
            </div>
            <div class="form-group">
                <label for="first_visit">첫 병원 방문일:</label>
                <input type="date" id="first_visit" name="first_visit" class="form-control" value="${mommodel.first_visit}">
            </div>
            <!-- 추가 정보 수정 항목들 -->
            <button type="submit" class="btn btn-primary mt-3">수정 완료</button>
        </form>
        <a href="momlist" class="btn btn-secondary mt-3">목록으로 돌아가기</a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
