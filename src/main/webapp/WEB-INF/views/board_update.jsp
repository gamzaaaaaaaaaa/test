<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.springmvc.domain.board"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="/ibom/resources/css/board_update.css">
<title>게시글 수정</title>

<script type="text/javascript">
    function checkForm() {
        if (!document.editForm.name.value) {
            alert("성명을 입력하세요.");
            return false;
        }
        if (!document.editForm.subject.value) {
            alert("제목을 입력하세요.");
            return false;
        }
        if (!document.editForm.content.value) {
            alert("내용을 입력하세요.");
            return false;
        }
    }
</script>
</head>
<body>
<%
    board bd = (board)request.getAttribute("board");
    String sessionId = (String)request.getAttribute("sessionId");
    int pageNum = (Integer)request.getAttribute("pageNum"); // JSP에서 pageNum 가져오기
%>
<div class="container py-4">
    <jsp:include page="/navi.jsp" />
    
    <div class="p-5 mb-4 rounded-3 outer-container">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">게시판</h1>
            <p class="col-md-8 fs-4">게시글 수정</p>      
        </div>
    </div>
    
    <div class="row align-items-md-stretch text-center">     
        <form name="editForm" action="/ibom/board/update" method="post" onsubmit="return checkForm()">
            <input name="num" type="hidden" value="<%= bd.getNum() %>">
            <input name="id" type="hidden" value="<%= bd.getId() %>">
            <input name="pageNum" type="hidden" value="<%= pageNum %>"> <!-- pageNum을 hidden 필드로 추가 -->
            
            <div class="mb-3 row" style="padding-top:20px">
                <label class="col-sm-2 control-label">성명</label>
                <div class="col-sm-3">
                    <input name="name" type="text" class="form-control" value="<%= bd.getName() %>" placeholder="name">
                </div>
            </div>
            
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">부서</label>
                <div class="col-sm-3">
                    <input name="institute" type="text" class="form-control" value="<%= bd.getInstitute() %>" placeholder="institute">
                </div>
            </div>
            
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">제목</label>
                <div class="col-sm-5">
                    <input name="subject" type="text" class="form-control" value="<%= bd.getSubject() %>" placeholder="subject">
                </div>
            </div>
            
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">내용</label>
                <div class="col-sm-8">
                    <textarea name="content" cols="50" rows="5" class="form-control" placeholder="content"><%= bd.getContent() %></textarea>
                </div>
            </div>
            
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">지원 대상</label>
                <div class="col-sm-8">
                    <textarea name="target" cols="50" rows="5" class="form-control" placeholder="target"><%= bd.getTarget() %></textarea>
                </div>
            </div>
            
            <div class="mb-3 row" style="padding-top:2%">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-success" value="수정">                
                    <input type="reset" class="btn btn-danger" value="취소">
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
