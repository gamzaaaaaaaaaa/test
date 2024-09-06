<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/join.css">
</head>
<body>
    <div class="signup-container">
        <h5>회원가입</h5>
         <form id="signup-form" action="/ibom/join" method="post">
            <div class="form-group">
                <label for="id" class="form-label">아이디</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="id" name="id" required>
                    <button type="button" class="btn btn-outline-secondary" onclick="idCheck()">중복검사</button>
                </div>
                <p id="check_result"></p>
            </div>
            <div class="form-group">
                <label for="pw" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="pw" name="pw" required>
            </div>
            <div class="form-group">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="postcode" class="form-label">우편번호</label>
                <div class="input-group mb-3">
                    <input type="text" class="form-control" id="sample6_postcode" name="postcode" placeholder="우편번호" readonly>
                    <button type="button" class="btn btn-outline-secondary" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
                </div>
            </div>
            <div class="form-group">
                <label for="address" class="form-label"></label>
                <input type="text" class="form-control" id="sample6_address" name="address" placeholder="주소" readonly>
            </div>
            <div class="form-group">
                <label for="detailAddress" class="form-label"></label>
                <input type="text" class="form-control" id="sample6_detailAddress" name="detailAddress" placeholder="상세주소">
            </div>
            <div class="form-group">
                <label for="extraAddress" class="form-label"></label>
                <input type="text" class="form-control" id="sample6_extraAddress" name="extraAddress" placeholder="참고항목">
            </div>
            <div class="form-group">
                <label for="birth" class="form-label">생년월일</label>
                <input type="date" class="form-control" id="birth" name="birth" required>
            </div>
            <div class="form-group">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" name="phone" required 
                pattern="\d{3}-\d{4}-\d{4}" title="전화번호는 010-1234-1123 형식으로 입력해주세요">
                <small class="form-text optional-note">전화번호는 010-1234-1123 형식으로 입력해주세요</small>
            </div>
            <div class="form-group">
                <label for="due" class="form-label">출산 예정일</label>
                <input type="date" class="form-control" id="due" name="due">
                <small class="form-text optional-note">선택 사항입니다.</small>
            </div>
            <button type="submit" class="btn btn-primary" id="signup_btn">가입하기</button>
        </form>
    </div>
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
</body>

<script>
var idCheck = () => {
    var id = document.querySelector("#id").value.trim(); // 입력한 아이디 값
    if (id === "") {
        console.log("아이디를 입력하세요");
        document.querySelector("#id").focus();
        return false;
    }

    var idresult = document.querySelector("#check_result"); // 아이디 체크 값
    console.log("입력한 아이디", id);
    
    // JSON으로 데이터 전송
    $.ajax({
        type: "POST",
        url: "/ibom/idCheck",
        contentType: "application/json", // JSON으로 전송
        data: JSON.stringify({
            "id": id
        }),
        success: function(res) {
            console.log("요청 성공", res);
            if (res === "ok") {
                console.log("사용가능한 아이디");
                idresult.style.color = "green";
                idresult.innerHTML = "사용가능한 아이디입니다";
                idresult.dataset.isAvailable = "true";
            } else {
                console.log("이미 사용중인 아이디");
                idresult.style.color = "red";
                idresult.innerHTML = "이미 사용중인 아이디입니다";
                idresult.dataset.isAvailable = "false";
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log("요청 실패", textStatus, errorThrown);
        }
    });
};

// 가입하기 버튼 클릭 시 중복 체크 결과 확인
document.querySelector("#signup-form").addEventListener("submit", function(event) {
    var idresult = document.querySelector("#check_result");
    if (idresult.dataset.isAvailable !== "true") {
        alert("이미 사용 중인 아이디입니다. 다른 아이디를 입력해주세요.");
        document.querySelector("#id").focus();
        event.preventDefault(); // 폼 제출 막기
    }
});
</script>
</html>
