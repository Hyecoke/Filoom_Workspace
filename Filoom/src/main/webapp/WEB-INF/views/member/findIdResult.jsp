<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	/* 기본 스타일 초기화 */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
	    font-family: Arial, sans-serif;
	    background-color: #121212;
	    color: #ffffff;
	}

    .login-container {
        width: 600px;
        background-color: #1e1e1e;
        border-radius: 10px;
        padding: 50px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        margin: 100px auto;
    }

    .login-Header {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 20px;
        border-bottom: 1px solid #333;
        padding-bottom: 10px;
    }

	.result {
		font-size: 16px;
		padding: 30px 20px;
		color: #aaa;
	}

	.result strong, .result big {
		font-size: 20px;
		color: #fff;
	}

    hr {
        border: 0;
        border-top: 1px solid #333;
        margin: 30px 0;
    }

    .signup-text1 {
        font-size: 16px;
        font-weight: 600;
        color: #aaaaaa;
        padding-bottom: 10px;
    }

	.login-btn {
        background-color: #000000;
    }

    .signup-btn {
        background-color: #555555;
    }

    .login-btn, .signup-btn {
        width: 100%;
        padding: 10px;
		margin-top: 15px;
        border: none;
        font-size: 16px;
        font-weight: bold;
        color: #ffffff;
        border-radius: 60px;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease; /* 배경색과 글씨 색 변화를 위한 트랜지션 */
    }

    .signup-btn:hover, .login-btn:hover {
        background-color: #fff; /* 배경을 흰색으로 변경 */
        color: #000; /* 글씨 색을 검정색으로 변경 */
    }

	.find-button {
	    display: flex;
	    gap: 10px;
	}

</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

	<div class="login-container">
        <div class="login-box">
            <h1 class="login-Header">아이디 찾기 결과</h1>

			<div class="result">
				<p><big>${userName}</big>님의 아이디는 <strong>${userId}</strong> 입니다.</p>
			</div>

			<div class="find-button">
				<button type="button" class="login-btn"onclick="location.href='loginForm.me'">로그인</button>
				<button type="button" class="signup-btn" onclick="location.href='findPwdForm.me'">비밀번호 찾기</button>
			</div>

        </div>
    </div>
	
	<jsp:include page="../common/footer.jsp" />

</body>
</html>