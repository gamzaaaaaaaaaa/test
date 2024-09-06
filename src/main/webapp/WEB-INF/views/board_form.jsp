<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="/ibom/resources/css/board_form.css">
<title>Board</title>
</head>
<script type="text/javascript">
    function checkForm() {
        if (!document.newWrite.name.value) {
            alert("성명을 입력하세요.");
            return false;
        }
        if (!document.newWrite.subject.value) {
            alert("제목을 입력하세요.");
            return false;
        }
        if (!document.newWrite.content.value) {
            alert("내용을 입력하세요.");
            return false;
        }
    }
</script>
<body>
<div class="container py-4">
    <jsp:include page="/navi.jsp" />
    
    <div class="p-5 mb-4 rounded-3 outer-container">
    	<div class="container-fluid py-5">
        	<h1 class="display-5 fw-bold">게시판</h1>
       		 <p class="col-md-8 fs-4">Board</p>      
    	</div>
	</div>
    <div class="row align-items-md-stretch text-center">     
        <form name="newWrite" action="/ibom/board/write" method="post" onsubmit="return checkForm()">
            <input name="id" type="hidden" class="form-control" value="${id}">
            <div class="mb-3 row" style="padding-top:20px">
                <label class="col-sm-2 control-label">성명</label>
                <div class="col-sm-3""> <!-- 나중에 readonly 추가해주기 -->
                    <input name="name" type="text" class="form-control" value="${name}" placeholder="name">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">부서</label>
                <div class="col-sm-3">
                    <input name="institute" type="text" class="form-control" value="${institute}" placeholder="institute">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">제목</label>
                <div class="col-sm-5">
                    <input name="subject" type="text" class="form-control" placeholder="subject">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">내용</label>
                <div class="col-sm-8">
                    <textarea name="content" cols="50" rows="5" class="form-control" placeholder="content"></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 control-label">지원 대상</label>
                <div class="col-sm-8">
                    <textarea name="target" cols="50" rows="5" class="form-control" placeholder="target"></textarea>
                </div>
            </div>
            <div class="mb-3 row" style="padding-top:2%">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="등록" style="background-color:#a87e6e; border:none; padding:12px 20px;">                
                    <input type="reset" class="btn btn-primary" value="취소" style="background-color:#a87e6e; border:none; padding:12px 20px">
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
