<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js" integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="/ibom/resources/css/login.css">
    <script>
  		Kakao.init('c0c6ff281532271c9f839fe95b16a793'); 
	</script>
    <style>
        body {
            background-color: #f4efec;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container { 
            display: flex;
            flex-direction: row;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
            background-color: white;
            width: 800px; /* 크기 조정 */
            max-width: 90%; /* 반응형 조정 */
        }
        .login-form {
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            flex: 1;
        }
        .login-form h5 {
            margin-bottom: 20px;
        }
        .login-form .btn-google, .login-form .btn-kakao {
            margin-bottom: 15px;
        }
        .login-form .btn-google {
            background-color: #4285F4;
            color: white;
        }
        .login-form .btn-kakao {
            background-color: #FEE500;
            color: black;
            background-image: url('/ibom/resources/images/kakao_login.png'); /* 이미지 경로 설정 */
            background-size: contain; /* 이미지 크기 조절 */
            background-repeat: no-repeat;
            background-position: center;
            height: 50px; /* 버튼 높이 설정 */
            padding: 0; /* 패딩 제거 */
            border: none; /* 테두리 제거 */
        }
        .login-form .btn-primary {
            background-color: #a87e6e;
            border-color: #a87e6e;
        }
        .image-container {
            background: url('/ibom/resources/images/logo3.png') no-repeat center center;
            background-size: cover;
            width: 400px;
            height: auto;
        }
        .error-message {
            color: #dc3545; /* Bootstrap의 에러 색상 */
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h5 class="text-center">로그인</h5>
            <button type="button" class="btn btn-kakao w-100" onclick="loginWithKakao()"></button>
            <p id="token-result"></p>
            <!-- 오류 메시지 출력 -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger error-message">
                    ${errorMessage}
                </div>
            </c:if>
            
			<form action="/ibom/login" method="post">
			    <div class="mb-3">
   					<input type="hidden" name="redirect" value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "" %>" />
			        <label for="id" class="form-label">아이디</label>
			        <input type="text" class="form-control" id="id" name="id" required>
			    </div>
			    <div class="mb-3">
			        <label for="pw" class="form-label">비밀번호</label>
			        <input type="password" class="form-control" id="pw" name="pw" required>
			    </div>
			    <button type="submit" class="btn btn-primary w-100">로그인</button>
			</form>

            <div class="mt-3 text-center">
                아직 회원이 아니신가요? <a href="/ibom/join">회원가입</a>
            </div>
        </div>
        <div class="image-container"></div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8080/ibom',
    });
  }

  function requestUserInfo() {
    Kakao.API.request({
      url: '/v2/user/me',
    })
      .then(function(res) {
        alert(JSON.stringify(res));
      })
      .catch(function(err) {
        alert(
          'failed to request user information: ' + JSON.stringify(err)
        );
      });
  }
  
  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
  
  $.ajax({
	    type : "POST"
	    , url : 'https://kauth.kakao.com/oauth/token'
	    , data : {
	        grant_type : 'authorization_code',
	        client_id : '80639075337b40257d7381eec2f39de6',
	        redirect_uri : 'http://localhost:8080/login',
	        code : kakaoCode
	    }
	    , contentType:'application/x-www-form-urlencoded;charset=utf-8'
	    , dataType: null
	    , success : function(response) {
	        Kakao.Auth.setAccessToken(response.access_token);
	        document.querySelector('button.api-btn').style.visibility = 'visible';
	    }
	    ,error : function(jqXHR, error) {

	    }
	});
  
  	function requestUserInfo() {
	    Kakao.API.request({
	      url: '/v2/user/me',
	    })
	      .then(function(res) {
	        alert(JSON.stringify(res));
	      })
	      .catch(function(err) {
	        alert(
	          'failed to request user information: ' + JSON.stringify(err)
	        );
	      });
	  }
  	
  	const urlParams = new URLSearchParams(window.location.search);
  	const kakaoCode = urlParams.get('code');

  	if (kakaoCode) {
  	    $.ajax({
  	        type: "POST",
  	        url: 'https://kauth.kakao.com/oauth/token',
  	        data: {
  	            grant_type: 'authorization_code',
  	            client_id: 'dc92091a3ccad1db19071404a1ec4922',  // 클라이언트 ID (REST API 키)
  	            redirect_uri: 'http://localhost:8080/ibom',  // 리다이렉트 URI
  	            code: kakaoCode  // 받은 인가 코드
  	        },
  	        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
  	        dataType: 'json',
  	        success: function(response) {
  	            // Access Token을 성공적으로 받아온 경우
  	            Kakao.Auth.setAccessToken(response.access_token);
  	            requestUserInfo();  // 사용자 정보 요청 함수 호출
  	        },
  	        error: function(jqXHR, error) {
  	            alert('로그인 실패: ' + error);
  	        }
  	    });
  	}
  	
  	 window.onload = function() {
         const urlParams = new URLSearchParams(window.location.search);
         const kakaoCode = urlParams.get('code');

         if (kakaoCode) {
             // 인증 코드를 서버에 전달하여 토큰을 요청
             fetch(`/ibom/kakao/callback?code=${kakaoCode}`, {
                 method: 'GET',
             })
             .then(response => response.json())
             .then(data => {
                 if (data.success) {
                     // 성공적으로 로그인 처리됨 (후처리: 예를 들어 메인 페이지로 리다이렉트)
                     window.location.href = '/ibom';
                 } else {
                     alert('로그인 처리에 실패했습니다.');
                 }
             })
             .catch(error => {
                 console.error('Error:', error);
             });
         }
     };
     
     window.onload = function() {
    	    const urlParams = new URLSearchParams(window.location.search);
    	    const kakaoCode = urlParams.get('code');

    	    if (kakaoCode) {
    	        fetch(`/ibom/kakao/callback?code=${kakaoCode}`, {
    	            method: 'GET',
    	        })
    	        .then(response => response.json())
    	        .then(data => {
    	            if (data.success) {
    	                // 로그인 성공 시
    	                alert('로그인 성공');
    	                window.location.href = '/ibom/main'; // 성공 시 메인 페이지로 리다이렉트
    	            } else {
    	                // 로그인 실패 시
    	                alert('로그인 실패');
    	            }
    	        })
    	        .catch(error => {
    	            console.error('Error:', error);
    	            alert('로그인 중 오류가 발생했습니다.');
    	        });
    	    }
    	};


</script>
    
</body>
</html>
