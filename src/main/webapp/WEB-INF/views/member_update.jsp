<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.springmvc.domain.member"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/ibom/resources/css/member_update.css">
</head>
<body>
<%
    member mb = (member)request.getAttribute("member");
    System.out.println(mb.getId());
%>
<div class="container">
    <h1 class="text-center">회원 정보 수정</h1>
    <div class="card mb-4">
        <div class="card-header">User Information</div>
        <div class="card-body">
            <form:form modelAttribute="member" action="/ibom/editmember" method="post">
                <div class="mb-3">
                    <label for="id" class="form-label">아이디</label>
                    <form:input path="id" type="text" class="form-control" id="id" name="id" value="<%=mb.getId() %>" readonly="true"/> 
                </div>
                <div class="mb-3">
                    <label for="pw" class="form-label">패스워드</label>
                    <form:input path="pw" type="password" class="form-control" id="pw" name="pw" value="<%=mb.getPw() %>" required="true" />
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">이름</label>
                    <form:input path="name" type="text" class="form-control" id="name" name="name" value="<%=mb.getName() %>" required="true" />
                </div>
                <div class="mb-3">
                    <label for="postcode" class="form-label">우편번호</label>
                    <div class="input-group">
                        <form:input path="postcode" type="text" class="form-control" id="sample6_postcode" name="postcode" placeholder="우편번호" required="true"/>
                        <button type="button" class="btn btn-outline-secondary" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">주소</label>
                    <form:input path="address" type="text" class="form-control" id="sample6_address" name="address" placeholder="주소" required="true"/>
                </div>
                <div class="mb-3">
                    <label for="detailAddress" class="form-label">상세 주소</label>
                    <form:input path="detailAddress" type="text" class="form-control" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소"/>
                </div>
                <div class="mb-3">
                    <label for="extraAddress" class="form-label">참고 항목</label>
                    <form:input path="extraAddress" type="text" class="form-control" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목"/>
                </div>
                <div class="mb-3">
                    <label for="birth" class="form-label">생년월일</label>
                    <form:input path="birth" type="text" class="form-control" id="birth" name="birth" value="<%=mb.getBirth() %>" required="true"/>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">전화번호</label>
                    <form:input path="phone" type="text" class="form-control" id="phone" name="phone" value="<%=mb.getPhone() %>" required="true"/>
                </div>
                <div class="mb-3">
                    <label for="due" class="form-label">출산예정일</label>
                    <form:input path="due" type="date" class="form-control" id="due" name="due" value="<%=mb.getDue() %>"/>
                </div>
                <button type="submit" class="btn btn-primary w-100">회원정보 수정</button>
                <button type="button" class="btn btn-danger w-100 mt-3" onclick="confirmDeletion()">회원탈퇴</button>
            </form:form>
            <form id="delete-form" action="/ibom/deletemember" method="post" style="display:none;">
                <input type="hidden" name="id" value="<%=mb.getId() %>">
            </form>
        </div>
    </div>
</div>
<script>
    function confirmDeletion() {
        if (confirm("정말로 회원 탈퇴를 하시겠습니까?")) {
            document.getElementById("delete-form").submit();
        }
    }
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; 
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
