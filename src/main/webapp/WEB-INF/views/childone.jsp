<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이 상세 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/childone.css">
</head>
<body>
    <div class="container">
        <h2>아이 상세 정보</h2>
		<table class="table table-bordered">
		    <tr>
		        <th>이름</th>
		        <td>${readone.name}</td>
		        <th>성별</th>
		        <td>
		            <c:choose>
		                <c:when test="${readone.gender == 'male'}">남자</c:when>
		                <c:otherwise>여자</c:otherwise>
		            </c:choose>
		        </td>
		    </tr>
		    <tr>
		        <th>나이 (개월 수)</th>
		        <td>${ageInMonths} 개월</td>
		        <th>생년월일</th>
		        <td>${readone.birth}</td>
		    </tr>
		    <tr>
		        <th>측정일</th>
		        <td>${readone.day}</td>
		        <th>키 (cm)</th>
		        <td>${readone.height}cm</td>
		    </tr>
		    <tr>
		        <th>몸무게 (kg)</th>
		        <td>${readone.weight}kg</td>
		        <th>머리둘레 (cm)</th>
		        <td>${readone.head}cm</td>
		    </tr>
		</table>


        <c:if test="${not empty childInfo}">
            <h3>평균 성장표</h3>
            <table class="table table-bordered">
                <tr>
                    <th>개월수</th>
                    <th>키 (cm)</th>
                    <th>몸무게 (kg)</th>
                    <th>발달정보</th>
                </tr>
                <tr>
                    <td>${childInfo.age_info}</td>
                    <td>${childInfo.height}cm</td>
                    <td>${childInfo.weight}kg</td>
                    <td>${childInfo.development}</td>
                </tr>
            </table>
        </c:if>
        
		<h3>성장 비교 그래프</h3>
		<canvas id="growthChart" width="400" height="200"></canvas>
		<script>
		    const ctx = document.getElementById('growthChart').getContext('2d');
		
		    // 아이 상세 정보
		    const childHeight = ${readone.height}; // 아이 키
		    const childWeight = ${readone.weight}; // 아이 몸무게
		
		    // 평균 성장표 정보
		    const averageHeight = ${childInfo.height}; // 평균 키
		    const averageWeight = ${childInfo.weight}; // 평균 몸무게
		
		    // 그래프 데이터
		    const labels = ['키 (cm)', '몸무게 (kg)'];
		    const childData = [childHeight, childWeight];
		    const averageData = [averageHeight, averageWeight];
		
		    const growthChart = new Chart(ctx, {
		        type: 'bar',
		        data: {
		            labels: labels,
		            datasets: [
		                {
		                    label: '아이',
		                    data: childData,
		                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
		                    borderColor: 'rgba(255, 99, 132, 1)',
		                    borderWidth: 1
		                },
		                {
		                    label: '평균',
		                    data: averageData,
		                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
		                    borderColor: 'rgba(54, 162, 235, 1)',
		                    borderWidth: 1
		                }
		            ]
		        },
		        options: {
		            scales: {
		                y: {
		                    beginAtZero: true
		                }
		            }
		        }
		    });
		</script>
        

        <div class="button-container">
            <a href="/ibom/childs/childlist" class="btn">돌아가기</a>
            <a href="/ibom/childs/update?num=${readone.num}" class="btn update">수정하기</a>
            <form action="/ibom/childs/delete" method="post" style="display:inline;">
                <input type="hidden" name="num" value="${readone.num}">
                <input type="submit" value="삭제하기" class="btn delete">
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    
	<script>
	    // updatebtn이라는 클래스를 가진 모든 요소를 선택
	    var updatebtn = document.querySelectorAll(".update");
	
	    // 각 버튼에 클릭 이벤트 리스너 추가
	    updatebtn.forEach(function(btn) {
	        btn.addEventListener("click", function(event) {
	            if (!confirm("정보를 수정하시겠습니까?")) {
	                // 사용자가 '취소'를 클릭하면 이벤트의 기본 동작을 막음
	                event.preventDefault();
	            }
	        });
	    });
	    
	    
	    var deletebtn = document.querySelectorAll(".delete");
	    
	    deletebtn.forEach(function(btns){
	    	btns.addEventListener("click", function(del){
	    		   if (!confirm("정보를 삭제하시겠습니까?")) {
		                // 사용자가 '취소'를 클릭하면 이벤트의 기본 동작을 막음
		                del.preventDefault();
		            }
	    	});
	    });
	</script>
</body>
</html>
