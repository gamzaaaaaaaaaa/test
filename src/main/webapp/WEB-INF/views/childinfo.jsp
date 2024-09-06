<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Child Info</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/childinfo.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center list-color">Child Info List</h2>
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Height (cm)</th>
                    <th>Weight (kg)</th>
                    <th>Development</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="child" items="${info}">
                    <tr>
                        <td>${child.age_info}</td>
                        <td>${child.height}cm</td>
                        <td>${child.weight}kg</td>
                        <td>${child.development}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="text-center">
            <a href="/ibom" class="btn-view">홈으로</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
