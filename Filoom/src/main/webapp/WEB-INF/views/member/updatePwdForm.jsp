<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
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
	
	.form-group {
	    margin-bottom: 15px;
	}
	
	.form-group label {
	    display: block;
	    font-size: 14px;
	    margin-bottom: 10px;
	    font-weight: 500;
	}
	
	input {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #333;
	    border-radius: 5px;
	    background-color: #2b2b2b;
	    color: #ffffff;
	    font-size: 14px;
		flex: 1;
	}
	
	input::placeholder {
	    color: #777;
	}
	
	input:focus {
	  outline: none;
	}
	
	.findId-btn {
	    background-color: #000000;
	    margin-top: 15px;
	}
	
	.findPwd-btn {
	    background-color: #555555;
	    margin-top: 15px;
	}
	
	.check-btn {
        padding: 10px 15px;
        background-color: #493628;
        color: #ffffff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }

    .check-btn:hover {
        background-color: #8b5a2b;
    }
    
    /* 비활성화 상태 */
	.check-btn:disabled {
	    background-color: #d3d3d3; /* 비활성화된 버튼의 배경색 */
	    color: #a9a9a9; /* 비활성화된 버튼의 텍스트 색상 */
	    cursor: not-allowed; /* 비활성화된 버튼에 커서 비활성화 스타일 */
	    opacity: 0.7; /* 약간의 투명도 추가 */
	}
	
	hr {
	    border: 0;
	    border-top: 1px solid #333;
	    margin: 30px 0;
	}
	
	.signup-text1 {
	    font-size: 20px;
	    font-weight: 600;
	    color: #aaaaaa;
	    padding-bottom: 30px;
	}
	
	.signup-text2 {
	    font-size: 14px;
	    color: #aaaaaa;
	    padding-bottom: 20px;
	}
	
	.signup-btn {
	    background-color: #493628;
	    margin-top: 15px;
	}
	
	.findId-btn, .findPwd-btn, .signup-btn {
	    width: 100%;
	    padding: 10px;
	    border: none;
	    font-size: 16px;
	    font-weight: bold;
	    color: #ffffff;
	    border-radius: 60px;
	    cursor: pointer;
	    transition: background-color 0.3s ease, color 0.3s ease; /* 배경색과 글씨 색 변화를 위한 트랜지션 */
	}
	
	.signup-btn:hover, .findId-btn:hover, .findPwd-btn:hover {
	    background-color: #fff; /* 배경을 흰색으로 변경 */
	    color: #000; /* 글씨 색을 검정색으로 변경 */
	}
	
	.input-with-btn {
	    display: flex;
	    gap: 10px;
	    align-items: center;
	}
	
	select {
	    /* -moz-appearance: none; */
	    /* -webkit-appearance: none; */
	    /* appearance: none; */
	    /* box-shadow: 0 1px 0 1px rgba(0,0,0,.04); */
	    font-size: 14px;
	    background-color: #2b2b2b;
	    color: #ffffff;
	    padding: 10px;
	    border: 1px solid #333;
	    border-radius: 5px;
	}
	
	span {
	    font-size: 14px;
	    color: #aaa;
	}
	
	.form-buttons {
	    display: flex;
	    gap: 10px;
	}
	
	/* 크롬 자동완성 시 input 색상 변경 막음 */
	input:-webkit-autofill,
	input:-webkit-autofill:hover,
	input:-webkit-autofill:focus,
	input:-webkit-autofill:active {
	    transition: background-color 5000s ease-in-out 0s;
	    -webkit-transition: background-color 9999s ease-out;
	    -webkit-box-shadow: 0 0 0px 1000px #2b2b2b inset !important;
	    -webkit-text-fill-color: #fff !important;
	}
</style>
</head>
<body>
	
	<jsp:include page="../common/header.jsp" />

	<div class="login-container">
		<div class="login-box">
			<h1 class="login-Header">비밀번호 변경</h1>

			<form id="changePwdForm">

				<input type="hidden" id="userId" name="userId" value="${userId}"> <!-- 숨겨진 필드 -->
		
				<div class="form-group">
					<label for="newPwd">새 비밀번호</label>
					<input type="password" id="newPwd" name="newPwd" placeholder="영문, 숫자, 특수기호를 포함한 8자 이상의 비밀번호를 입력해주세요." required>
				</div>
		
				<div class="form-group">
					<label for="confirmPwd">비밀번호 확인</label>
					<input type="password" id="confirmPwd" name="confirmPwd" placeholder="비밀번호를 다시 입력해주세요." required>
				</div>
		
				<div class="form-buttons">
					<button type="button" class="findId-btn" id="changePwdBtn">변경</button>
					<button type="button" class="findPwd-btn" onclick="location.href='loginForm.me'">취소</button>
				</div>

			</form>
		</div>
	</div>
	
	<jsp:include page="../common/footer.jsp" />
	
	<script>

		$(function() {
			const pwdRegexp = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+~`|}{[\]:;?><,./-]).{8,}$/;

			// 비밀번호 유효성 검사
	        $("#newPwd").on("keyup", function () {
	            const password = $(this).val();
	            if (pwdRegexp.test(password)) {
	                $(this).css("border-color", "green");
	            } else {
	                $(this).css("border-color", "red");
	            }
	        });
	
	        // 비밀번호 확인 검사
	        $("#confirmPwd").on("keyup", function () {
	            const password = $("#newPwd").val();
	            const confirmPassword = $(this).val();
	            if (password === confirmPassword && pwdRegexp.test(password)) {
	                $(this).css("border-color", "green");
	            } else {
	                $(this).css("border-color", "red");
	            }
	        });

			$("#changePwdBtn").click(function () {
				const newPwd = $("#newPwd").val().trim();
				const confirmPwd = $("#confirmPwd").val().trim();
				const userId = $("#userId").val(); // 숨겨진 필드에서 userId 가져오기
			
				if (!newPwd) {
	                alert("비밀번호를 입력해주세요.");
	                $("#newPwd").focus().css("border-color", "red");
	                return;
	            }

				if (!pwdRegexp.test(newPwd)) {
					alert("비밀번호는 영문, 숫자, 특수기호를 포함하여 8자 이상 입력해야 합니다.");
					$("#newPwd").focus().css("border-color", "red");
					return;
				}

				if (!confirmPwd) {
	                alert("비밀번호 확인란을 입력해주세요.");
	                $("#confirmPwd").focus().css("border-color", "red");
	                return;
	            }
			
				if (newPwd !== confirmPwd) {
					alert("비밀번호가 일치하지 않습니다.");
					$("#confirmPwd").focus().css("border-color", "red");
					return;
				}
			
				$.ajax({
					url: "updatePwd.me",
					type: "post",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					data: {
						userId: userId,
						newPwd: newPwd,
					},
					success: function (response) {
						if (response === "SUCCESS") {
							alert("비밀번호가 성공적으로 변경되었습니다. 로그인 페이지로 이동합니다.");
							location.href = "loginForm.me";
						} else {
							alert("비밀번호 변경 중 오류가 발생했습니다.");
						}
					},
					error: function () {
						alert("비밀번호 변경 중 오류가 발생했습니다.");
					},

				});
			});
		});
	</script>


</body>
</html>