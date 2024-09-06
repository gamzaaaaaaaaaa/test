<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.springmvc.domain.board"%>

<%
    // Request에서 속성을 가져오기 전에 null 체크를 추가합니다.
    board notice = (board) request.getAttribute("board");

    Integer numAttr = (Integer) request.getAttribute("num");
    int num = (numAttr != null) ? numAttr : 0; // 기본값 0

    Integer nowpageAttr = (Integer) request.getAttribute("pageNum");
    int nowpage = (nowpageAttr != null) ? nowpageAttr : 1; // 기본값 1

    String sessionId = (String) request.getAttribute("sessionId");
%>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/board_view.css">
    <style>
    
    </style>
    <title>Board</title>
</head>
<body>

    <jsp:include page="/navi.jsp" />
    
    <div class="p-5 mb-4 rounded-3 outer-container" style="margin-bottom: 5%">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">복지제도</h1>
            <p class="col-md-8 fs-4 subtitle">엄마와 아기를 위한 따뜻한 손길과 지원</p>      
        </div>
    </div>
    
	<div class="container py-4">

    <div class="row align-items-md-stretch text-center">    
        <form name="newUpdate" action="/board/update?num=<%= num %>&pageNum=<%= nowpage %>" method="post" class="form-section">
            <div class="form-row">
                <label class="form-label">성명</label>
                <div class="content form-content">
                    <%= (notice != null) ? notice.getName() : "" %>
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">부서</label>
                <div class="content form-content">
                    <%= (notice != null) ? notice.getInstitute() : "" %>
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">제목</label>
                <div class="content form-content">
                    <%= (notice != null) ? notice.getSubject() : "" %>
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">내용</label>
                <div class="content form-content form-content-textarea">
                    <%= (notice != null) ? notice.getContent() : "" %>
                </div>
            </div>
            <div class="form-row">
                <label class="form-label">지원 대상</label>
                <div class="content form-content form-content-textarea">
                    <%= (notice != null) ? notice.getTarget() : "" %>
                </div>
            </div>
            <div class="form-row">
			    <div class="col-sm-offset-2 col-sm-10 button-group">
			        <% if (sessionId != null && sessionId.equals(notice != null ? notice.getId() : "")) { %>
			            <a href="/ibom/board/delete?num=<%= num %>&pageNum=<%= nowpage %>" class="btn-custom">삭제</a> 
			            <a href="/ibom/board/update?num=<%= num %>&pageNum=<%= nowpage %>" class="btn-custom">수정</a>
			        <% } else { %>
			        <% } %>
			        <a href="/ibom/board/list?pageNum=<%= nowpage %>" class="btn-custom">목록</a>
			    </div>
			</div>
        </form>
    </div>
</div>
</body>
</html>
