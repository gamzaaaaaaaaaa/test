<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.springmvc.domain.board"%>
<%@ page import="com.springmvc.domain.member"%>
<%
    member mb = (member) session.getAttribute("member");
    String sessionId = (mb != null) ? mb.getId() : null;
   
    ArrayList<board> boardList = (ArrayList<board>) request.getAttribute("boardList");
    
    int total_record = ((Integer) request.getAttribute("totalRecords")).intValue();
    
    int pageNum = 0;
    pageNum = ((Integer) request.getAttribute("pageNum")).intValue(); 
    if(pageNum == 0){
        pageNum = 1;
    }

    int limit = ((Integer) request.getAttribute("limit")).intValue();

    int total_page = (total_record + limit - 1) / limit;
%>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/board_list.css">
    <title>Board</title>
    <script type="text/javascript">
        function checkForm() {
            if (<%= (sessionId != null) ? "true" : "false" %>) {
                location.href = "/ibom/board/write"; // 게시물 작성 페이지로 이동
            } else {
                alert("글쓰기 권한이 없습니다.");
            }
        }

        // 테이블 행 클릭 시 게시글 상세 페이지로 이동
        $(document).ready(function() {
            $(".inserttable").on("click", "tr", function() {
                var num = $(this).data("num");
                var pageNum = "<%= pageNum %>";
                if (num) {
                    window.location.href = "/ibom/board/detailview?num=" + num + "&pageNum=" + pageNum;
                }
            });
        });
    </script>
</head>

<body>
<div>
    <jsp:include page="/navi.jsp" />
    
    <div class="p-5 mb-4 rounded-3 outer-container" style="margin-bottom: 5%">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">복지제도</h1>
            <p class="col-md-8 fs-4 subtitle">엄마와 아기를 위한 따뜻한 손길과 지원</p>      
        </div>
    </div>
    
    <div class="container">
	    <div class="row align-items-md-stretch text-center ">    
	        <form action="/ibom/board/list" method="get">
	            <div class="text-end"> 
	                <span class="badge btn-custom">전체 <%= total_record %>건</span>
	            </div>
	
	            <div style="padding-top: 20px">
	                <table class="table table-hover text-center">
	                    <tr>
	                        <th>번호</th>
	                        <th>제목</th>
	                        <th>작성일</th>
	                        <th>조회</th>
	                        <th>글쓴이</th>
	                    </tr>
	                    <tbody class="inserttable">
	                    <%
	                        for (board notice : boardList) {
	                    %>
	                    <tr data-num="<%= notice.getNum() %>">
	                        <td><%= notice.getNum() %></td>
	                        <td class="text-left"><%= notice.getSubject() %></td>
	                        <td><%= notice.getRegistDay() %></td>
	                        <td><%= notice.getHit() %></td>
	                        <td><%= notice.getName() %></td>
	                    </tr>
	                    <%
	                        }
	                    %>
	                    </tbody>
	                </table>
	            </div>
	            
	            <div class="pagination">
	                <%
	                    if (total_page > 0) { 
	                        for (int i = 1; i <= total_page; i++) {
	                %>
	                <a href="/ibom/board/list?pageNum=<%= i %>" class="<%= (pageNum == i) ? "active" : "" %>">
	                    <%= i %>
	                </a>
	                <%
	                    }
	                } else {
	                %>
	                    <span>페이지가 없습니다.</span>
	                <%
	                }
	                %>
	            </div>
	
	            <div class="search-bar">    
	                <a href="/ibom/board/write" onclick="checkForm();return false;" class="btn btn-primary">&laquo; 글쓰기</a>                
	                <div>
	                    <select name="items" class="txt" id="items">
	                        <option value="subject">제목에서</option>
	                        <option value="content">본문에서</option>
	                    </select> 
	                    <input name="search" type="text" id="search" /> 
	                    <button id="btnAdd" class="btn btn-primary">검색</button>                
	                </div>
	            </div>
	        </form>            
	    </div>
	</div>
</div>
<script>
    var btn = document.querySelector("#btnAdd");
    
    btn.addEventListener("click", search_item);
    
    function search_item(event){
        console.log("함수 in");
        
        event.preventDefault();
        
        var items = document.querySelector("#items").value;
        var search = document.querySelector("#search").value;
        
        $.ajax({
            url: "/ibom/board/search",
            type: "post",
            data: JSON.stringify({category: items, text: search}),
            contentType: "application/json",
            success: function(data) {
                console.log("서버 응답:", data);
                
                var tableBody = document.querySelector(".inserttable");
                
                // 테이블 비우기
                tableBody.innerHTML = "";

                // 받은 데이터가 비어 있지 않은 경우 테이블에 추가
                if (data.length > 0) {
                    data.forEach(function(item) {
                        // 테이블에 데이터 추가
                        var row = document.createElement("tr");
                        row.setAttribute("data-num", item.num);
                        row.innerHTML = `<td>`+ item.num + `</td>`+
                                        `<td class="text-left">`+ item.subject + `</td>`+
                                        `<td>`+ item.registDay + `</td>`+
                                        `<td>`+ item.hit + `</td>`+
                                        `<td>`+ item.name + `</td>`;
                        tableBody.appendChild(row);
                    });
                } else {
                    // 검색 결과가 없을 때 처리
                    var row = document.createElement("tr");
                    row.innerHTML = `<td colspan="5"><p>검색 결과가 없습니다</p></td>`;
                    tableBody.appendChild(row);
                }
            },
            error: function(xhr, status, error) {
                console.log("오류 발생:", error);
            }
        });    
    }
</script>

</body>
</html>
