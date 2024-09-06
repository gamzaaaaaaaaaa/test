<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="com.springmvc.domain.hospital" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>병원 지도</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c0c6ff281532271c9f839fe95b16a793"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/apimap.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</head>
<body>

<%
    // request에서 병원 리스트를 가져옵니다.
    List<hospital> allhospital = (List<hospital>) request.getAttribute("allhospital");
%>
<%@ include file="homebtn.jsp" %>
<div class="base">
    <div id="map"></div>

    <div id="menu_wrap">
        <div class="option">
            <form onsubmit="return false;">
    			<input type="text" id="keyword" placeholder="병원 이름 또는 주소 입력">
    			<button type="button" id="keywordbtn">검색하기</button>
			</form>
            <p class="guide-text">&nbsp; ex) 서울특별시 강남구 / 강남구</p>
        </div>
        <div id="noResultsMessage">
            <p>검색결과 (총 0건)</p>
            <p>※ 내 위치와 가까운 병원 또는 약국의 검색결과입니다.</p>
        </div>
        <ul id="placesList" style="display:none">
            <% for (hospital hs : allhospital) { %>
                <li>
                    <strong><%= hs.getYadmNm() %></strong>
                    <div><%= hs.getAddr() %></div>
                    <div><%= hs.getTelephone() %></div>
                    <button onclick="confirmReservation('<%= hs.getYadmNm() %>')">예약하기</button>
                </li>
            <% } %>
        </ul>
    </div>
</div>

<!-- 커스터마이즈된 알림창 모달 -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">예약 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="confirmMessage">예약하시겠습니까?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="confirmYes()">예</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
var markers = [];
var infowindow = new kakao.maps.InfoWindow();
var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(37.498, 127.027),
        level: 2
    };
var map = new kakao.maps.Map(mapContainer, mapOption);

var hospitalPositions = [
    <% for (hospital hs : allhospital) { %>
    {
        content: '<div class="info-window"><strong><%= hs.getYadmNm() %></strong><br/><%= hs.getAddr() %><br/><%= hs.getTelephone() %><br/><button onclick="confirmReservation(\'<%= hs.getYadmNm() %>\')">예약하기</button></div>',
        latlng: new kakao.maps.LatLng(<%= hs.getYPos() %>, <%= hs.getXPos() %>)
    },
    <% } %>
];

function createHospitalMarker(position) {
    var marker = new kakao.maps.Marker({
        map: map,
        position: position.latlng
    });

    kakao.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(position.content);
        infowindow.open(map, marker);
    });

    markers.push(marker);
}

function clearMarkers() {
    markers.forEach(function(marker) {
        marker.setMap(null);
    });
    markers = [];
}

var keywordbtn = document.querySelector("#keywordbtn");

keywordbtn.addEventListener("click", function(){
	var keyword = document.querySelector("#keyword").value;
	
	$.ajax({
		type:"POST",
		url:"/ibom/searchHospital",
		data : {keyword: keyword},
		success: function(data){
			console.log(data);
			updateMap(data);
			updateList(data);
			updateResultsCount(data.length);
		},
		error: function(err){
			alert("필터링 실패");
		}
	});
});

function updateResultsCount(count) {
    var noResultsMessage = document.querySelector("#noResultsMessage p");
    noResultsMessage.textContent = "검색결과 (총 " + count + "건)";
}

function updateMap(hospitals) {
    clearMarkers(); // 기존 마커 제거

    console.log(hospitals); // 서버에서 받은 데이터 확인

    if (hospitals.length > 0) {
        var firstHospital = hospitals[0];
        var position = new kakao.maps.LatLng(firstHospital.ypos, firstHospital.xpos);
        map.setCenter(position);
        map.setLevel(4);

        hospitals.forEach(function(hospital) {
            var position = {
                content: '<div class="info-window"><strong>' + hospital.yadmNm + '</strong><br/>' + hospital.addr + '<br/>' + hospital.telephone + '<br/><button onclick="confirmReservation(\'' + hospital.yadmNm + '\')">예약하기</button></div>',
                latlng: new kakao.maps.LatLng(hospital.ypos, hospital.xpos)
            };
            createHospitalMarker(position);
        });
    } else {
        alert("해당 조건에 맞는 병원이 없습니다.");
    }
}

function updateList(hospitals) {
    var placesList = document.querySelector("#placesList");
    placesList.innerHTML = ''; // 기존 리스트 항목 제거
    placesList.style.display="block";

    hospitals.forEach(function(hospital) {
        // 리스트 항목 생성
        var listItem = document.createElement('li');

        // 리스트 항목 내용 설정
        listItem.innerHTML = 
            '<strong>' + hospital.yadmNm + '</strong>' +
            '<div>' + hospital.addr + '</div>' +
            '<div>' + hospital.telephone + '</div>' +
            '<button onclick="confirmReservation(\'' + hospital.yadmNm + '\')">예약하기</button>';

        // 클릭 이벤트 핸들러 추가
        listItem.onclick = function() {
            moveToLocation(hospital.ypos, hospital.xpos, hospital.yadmNm, hospital.addr, hospital.telephone);
        };

        // 리스트 항목을 리스트에 추가
        placesList.appendChild(listItem);
    });
}


 // 페이지 로드 시 리스트 업데이트
 document.addEventListener("DOMContentLoaded", function() {
     updateList(hospitals);
 });


function clearMarkers() {
    markers.forEach(function(marker) {
        marker.setMap(null);
    });
    markers = [];
}

hospitalPositions.forEach(createHospitalMarker);

function createHospitalMarker(position) {
    var marker = new kakao.maps.Marker({
        map: map,
        position: position.latlng
    });

    kakao.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(position.content);
        infowindow.open(map, marker);
    });

    markers.push(marker);
}

// 예약하기 버튼 클릭 시 모달 표시
function confirmReservation(hospitalName) {
    document.getElementById('confirmMessage').innerText = hospitalName + '에 예약하시겠습니까?';
    var myModal = new bootstrap.Modal(document.getElementById('confirmModal'), {
        keyboard: false
    });
    myModal.show();

    window.confirmYes = function() {
        window.location.href = "/ibom/hospitalreservation?name=" + encodeURIComponent(hospitalName);
    }
}



</script>

</body>
</html>
