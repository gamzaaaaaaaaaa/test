<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springmvc.domain.injection" %>
<%
    String sessionId = (String)request.getAttribute("id");

    if(sessionId == null || sessionId.equals("null")){    
        response.sendRedirect("/ibom/login");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<title>예방 접종</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" type="text/css" href="/ibom/resources/css/injection_calendar.css">
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js'></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
  <div>
    <div class="container" >
      <div class="info-section">
            <p class="info-text">아이의 예방 접종 이력을 확인하세요. 아래 버튼을 눌러 아이를 선택하세요.</p>
            <button type="button" id="test" class="select-button">아이 선택</button>
        </div>
      <div id="child-modal" class="modal" style="display:none;">
		  <div class="modal-content">
		    <h2>아이 정보 선택</h2>
		    <ul id="child-list"></ul>
		    <button id="no-child-info" style="display:none;">아이의 정보를 입력해주세요</button>
		    <button id="close-modal">닫기</button>
		  </div>
		</div>
    </div>
    <div class="main-content">
      <ul class="list-container" id="injection-list-upload">
        <li>
          <span>예방접종 이력 불러오기</span>
          <button class="icon-button" id="injection-list-upload"><i class="fas fa-sync-alt"></i></button>
        </li>
      </ul>
      <div id="calendar"></div>
      <ul class="list-container" id="injection-list">
        <li><button id="save-list" class="save-list">예방접종 이력저장</button></li>
      </ul>
    </div>
  </div>
  
  <%@ include file="homebtn.jsp" %>
 
<script>
  var sessionId = '<%=sessionId %>';
  var birthdayDate;



  function stringFormat(value) {
    return value < 10 ? '0' + value : value;
  }

  function transformData(data) {
    const keyToTitleMap = {
        'birth': '아기 태어난 날',
        'bcg': '[결핵] BCG',
        'hepb_1': '[B형간염] HepB 1차',
        'hepb_2': '[B형간염] HepB 2차',
        'hepb_3': '[B형간염] HepB 3차',
        'dtap_1': '[디프테리아ㆍ파상풍ㆍ백일해] DTaP 1차',
        'dtap_2': '[디프테리아ㆍ파상풍ㆍ백일해] DTaP 2차',
        'dtap_3': '[디프테리아ㆍ파상풍ㆍ백일해] DTaP 3차',
        'dtap_4': '[디프테리아ㆍ파상풍ㆍ백일해] DTaP 4차',
        'ipv_1': '[폴리오] IPV 1차',
        'ipv_2': '[폴리오] IPV 2차',
        'ipv_3': '[폴리오] IPV 3차',
        'hib_1': '[b형헤모필루스인플루엔자] Hib 1차',
        'hib_2': '[b형헤모필루스인플루엔자] Hib 2차',
        'hib_3': '[b형헤모필루엔자] Hib 3차',
        'hib_4': '[b형헤모필루엔자] Hib 4차',
        'pcv_1': '[폐렴구균] PCV 1차',
        'pcv_2': '[폐렴구균] PCV 2차',
        'pcv_3': '[폐렴구균] PCV 3차',
        'pcv_4': '[폐렴구균] PCV 4차',
        'ppsv': '[폐렴구균] PPSV (고위험군에 한하여 접종)',
        'rv_1': '[로타바이러스 감염증] RV(로타릭스) 1차',
        'rv_2': '[로타바이러스 감염증] RV(로타릭스) 2차',
        'rv2_1': '[로타바이러스 감염증] RV(로타텍) 1차',
        'rv2_2': '[로타바이러스 감염증] RV(로타텍) 2차',
        'rv2_3': '[로타바이러스 감염증] RV(로타텍) 3차',
        'mmr_1': '[홍역ㆍ유행성이하선염ㆍ풍진] MMR 1차',
        'var_1': '[수두] VAR',
        'hepa_1': '[A형간염] HepA 1차',
        'hepa_2': '[A형간염] HepA 2차',
        'ijev_1': '[일본뇌염] IJEV 1차',
        'ijev_2': '[일본뇌염] IJEV 2차',
        'ijev_3': '[일본뇌염] IJEV 3차',
        'ljev_1': '[일본뇌염] LJEV 1차',
        'ljev_2': '[일본뇌염] LJEV 2차'
    };

    let events = [];
    data.forEach(record => {
      for (let key in record) {
        if (record.hasOwnProperty(key) && key !== 'id') {
          let foundTitle = null;
          for (let mapKey in keyToTitleMap) {
            if (key.includes(mapKey)) {
              foundTitle = keyToTitleMap[mapKey];
              break;
            }
          }
          
          events.push({
            id: 'event-' + new Date().getTime() + '-' + key, // 유일한 ID 생성 (키 포함)
            title: foundTitle || key,
            start: record[key],
            color: '#F08080', // 주사 일정 색상
            checked: false // 체크 상태 추가
          });
        }
      }
    });
    return events;
  }

  $(document).ready(function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        headerToolbar: {
	            left: 'prevYear,prev,next,nextYear today',
	            center: 'title',
	            right: 'dayGridMonth,dayGridWeek,dayGridDay'
	        },
	        initialView: 'dayGridMonth',
	        editable: true,
	        dayMaxEvents: true,
	        events: [], // 빈 이벤트로 초기화
	        eventDidMount: function(info) {
	            if (info.event.title === '아기 태어난 날') {
	                return;
	            }

	            var checkButton = document.createElement('button');
	            checkButton.innerHTML = '✔️';
	            checkButton.style.border = 'none';
	            checkButton.style.background = 'transparent';
	            checkButton.style.color = 'green';
	            checkButton.style.cursor = 'pointer';
	            checkButton.style.fontSize = '16px';
	            checkButton.style.marginLeft = '10px';

	            checkButton.addEventListener('click', function() {
	                var eventElement = info.el;
	                var listContainer = document.getElementById('injection-list');
	                var existingItems = listContainer.querySelectorAll('li[data-id="' + info.event.id + '"]');

	                if (existingItems.length === 0) {
	                    var listItem = document.createElement('li');
	                    listItem.textContent = info.event.title + ' - ' + info.event.start.toISOString().split('T')[0];
	                    listItem.dataset.id = info.event.id;
	                    listItem.dataset.userid = sessionId;

	                    var deleteButton = document.createElement('button');
	                    deleteButton.innerHTML = '❌';
	                    deleteButton.style.border = 'none';
	                    deleteButton.style.background = 'transparent';
	                    deleteButton.style.color = 'red';
	                    deleteButton.style.cursor = 'pointer';
	                    deleteButton.style.fontSize = '16px';
	                    deleteButton.style.marginLeft = '10px';

	                    deleteButton.addEventListener('click', function() {
	                        if (confirm('해당 이력을 삭제하시겠습니까?')) {
	                            listItem.remove();
	                        }
	                    });

	                    listItem.appendChild(deleteButton);
	                    listContainer.appendChild(listItem);
	                    eventElement.style.margin = '0';

	                    info.event.setProp('color', '#808080');
	                } else {
	                    alert('이 항목은 이미 리스트에 추가되었습니다.');
	                }
	            });

	            info.el.querySelector('.fc-event-title').appendChild(checkButton);
	        }
	    });

	    calendar.render();

	    // 예방접종 이력 불러오기 버튼 클릭 이벤트 처리
	    $('#injection-list-upload').on('click', function() {
	        var button = $(this);

	        if (button.data('requestInProgress')) {
	            console.log('요청이 이미 진행 중입니다.');
	            return; // 이미 요청이 진행 중인 경우 추가 클릭을 무시
	        }

	        button.data('requestInProgress', true);
	        console.log('AJAX 요청 시작');

	        $.ajax({
	            url: '/ibom/getinjectionlist', // 올바른 엔드포인트
	            type: 'GET',
	            data: { userid: sessionId, birth: birthdayDate }, // 필요한 데이터
	            dataType: 'json',
	            success: function(data) {
	                console.log('AJAX 요청 성공:', data);

	                $('#injection-list-upload').find('li').not(':first').remove();

	                data.forEach(function(injectionList) {
	                    var listItem = $('<li></li>').text(injectionList.title + ' - ' + injectionList.date);
	                    $('#injection-list-upload').append(listItem);
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error('Error:', error);
	                alert('데이터를 불러오는 중 오류가 발생했습니다.');
	            },
	            complete: function() {
	                console.log('AJAX 요청 완료');
	                button.data('requestInProgress', false);
	            }
	        });
	    });

	    // 예방접종 이력 저장 버튼 클릭 이벤트 처리
	  $('#save-list').on('click', function() {
    var injectionList = [];
    var promises = [];

    $('#injection-list li').each(function() {
        var listItem = $(this);
        var eventId = listItem.data('id');
        var eventText = listItem.text().trim();
        var eventParts = eventText.split(' - ');
        var eventTitle = eventParts.length > 0 ? eventParts[0].trim() : '';
        var eventDate = eventParts.length > 1 ? eventParts[1].split('❌')[0].trim() : '';

        if (eventTitle && eventDate) {
            var title = encodeURIComponent(eventTitle);
            var promise = $.ajax({
                url: '/ibom/checkInjectionList',
                type: 'POST',
                data: {
                    userid: sessionId,
                    title: title,
                    birth: birthdayDate
                },
                success: function(isDuplicate) {
                    if (isDuplicate) {
                        alert('중복된 예방접종 이력이 있습니다: ' + eventTitle);
                    } else {
                        injectionList.push({
                            listid: eventId,
                            userid: sessionId,
                            title: eventTitle,
                            date: eventDate,
                            birth: birthdayDate
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
            promises.push(promise);
        }
    });

    $.when.apply($, promises).done(function() {
        if (injectionList.length > 0) {
            $.ajax({
                type: 'POST',
                url: '/ibom/saveInjectionList',
                contentType: 'application/json',
                data: JSON.stringify(injectionList),
                success: function(response) {
                    alert('리스트가 저장되었습니다.');
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }
    });
});
	    // 모달 창 열기/닫기
	    var modal = document.getElementById("child-modal");
	    var closeModalBtn = document.getElementById("close-modal");

	    $('#test').on('click', function() {
	        $.ajax({
	            type: 'POST',
	            url: '/ibom/testinjection',
	            data: { id: sessionId },
	            success: function(children) {
	                if (children.length > 0) {
	                    var childList = document.getElementById("child-list");
	                    childList.innerHTML = ""; // 기존 목록 초기화
	                    
	                    children.forEach(function(child) {
	                        var listItem = document.createElement("div");
	                        listItem.classList.add("child-item");

	                        var childInfo = document.createElement("span");
	                        childInfo.textContent = child.name + " - " + child.birth;

	                        var selectBtn = document.createElement("button");
	                        selectBtn.textContent = "선택";
	                        selectBtn.classList.add("select-btn");
	                        selectBtn.addEventListener("click", function() {
	                            birthdayDate = child.birth;
	                            childInjectionInfo(child.id, child.birth);
	                            modal.style.display = "none";
	                        });

	                        listItem.appendChild(childInfo);
	                        listItem.appendChild(selectBtn);
	                        childList.appendChild(listItem);
	                    });

	                    modal.style.display = "block"; 
	                } else {
	                    alert("아이 정보가 없습니다. 아이 정보를 입력해주세요.");
	                    window.location.href = "/ibom/childs/child"; 
	                }
	            },
	            error: function(xhr, status, error) {
	                if (xhr.status === 404) {
	                    alert("아이 정보를 찾을 수 없습니다. 아이 정보를 입력해주세요.");
	                    window.location.href = "/ibom/childs/child"; 
	                } else {
	                    console.error('Error:', error);
	                }
	            }
	        });
	    });

	    closeModalBtn.addEventListener("click", function() {
	        modal.style.display = "none";
	    });

	    function childInjectionInfo(childId, birth) {
	        $.ajax({
	            type: 'POST',
	            url: '/ibom/getChildInjection',
	            data: { childId: childId, birth: birth },
	            success: function(injections) {
	                console.log('Received injections data:', injections);
	                var events = transformData(injections);
	                console.log('Transformed events:', events);
	                calendar.getEvents().forEach(event => event.remove()); // 기존 이벤트 제거
	                events.forEach(event => calendar.addEvent(event)); // 새로운 이벤트 추가
	            },
	            error: function(err) {
	                alert('아이의 예방 접종 정보를 불러오는 데 실패했습니다.');
	            }
	        });
	    }
	});

</script>

</body>
</html>
