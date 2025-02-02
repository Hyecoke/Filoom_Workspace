<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
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
	    background-color: #555555;
	    margin-top: 15px;
	}
	
	.findPwd-btn {
	    background-color: #000000;
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
	
	.find-button {
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
            <h1 class="login-Header">비밀번호 찾기</h1>
            
            <form action="findPwd.me" method="post" id="findPwdForm">
            
                <div class="form-group">
                    <label for="userName">이름</label>
                    <input type="text" id="userName" name="userName" placeholder="한글 또는 영문으로 입력해주세요." required>
                </div>
                
                <div class="form-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" name="userId" placeholder="아이디를 입력해주세요." required>
                </div>
                
                <div class="form-group">
                    <label for="birth">생년월일</label>
                    <input type="text" id="birth" name="birth" placeholder="YYYYMMDD" required>
                </div>
                
                <div class="form-group">
				    <label for="email">이메일</label>
				    <div class="input-with-btn">
				        <input type="email" id="email" name="email" placeholder="이메일을 입력해주세요." required>
				        <button type="button" class="check-btn" id="cert" onclick="sendCert();">인증번호 받기</button>
				    </div>
				</div>
				
				<div class="form-group" style="display: none;" id="cert-section">
				    <label for="checkNo">인증번호</label>
				    <div class="input-with-btn">
				        <input type="text" id="checkNo" name="checkNo" placeholder="인증번호를 입력해주세요." disabled>
				        <button type="button" class="check-btn" id="validate" onclick="validateCert();" disabled>인증확인</button>
				    </div>
				</div>
                
                <div class="find-button">
                    <button type="button" class="findId-btn" onclick="location.href='findIdForm.me'">아이디 찾기</button>
                    <button type="submit" class="findPwd-btn">비밀번호 찾기</button>
                </div>
                
            </form>
            
            <hr>
            
            <div class="signup-box">
                <p class="signup-text1">아직 계정이 없으신가요?</p>
                <p class="signup-text2">개인 계정을 생성하시면 더욱 다양한 혜택을 누리실 수 있습니다.</p>
                <button type="button" class="signup-btn" onclick="location.href='enrollForm.me'">Filoom 계정 만들기</button>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script>
	    // 이메일 인증번호 전송 요청
	    function sendCert() {
	        let email = $("#email").val();
	        $.ajax({
	            url: "cert.do",
	            type: "post",
	            data: {
	                email: email,
	            },
	            success: function (result) {
	                alert(result);
	                // 인증번호 입력 창 보이기
	                $("#cert-section").show();
	
	                // 인증번호 입력 창 및 확인 버튼 활성화
	                $("#checkNo").attr("disabled", false).focus();
	                $("#validate").attr("disabled", false);
	
	                // 이메일 입력창 및 인증번호 받기 버튼 비활성화
	                $("#email").attr("readonly", true);
	                $("#cert").attr("disabled", true);
	            },
	            error: function () {
	                console.log("인증번호 발급용 ajax 통신 실패");
	            },
	        });
	    }
	
	    // 이메일 인증번호 대조 요청
	    function validateCert() {
	        let email = $("#email").val();
	        let checkNo = $("#checkNo").val();
	
	        $.ajax({
	            url: "validate.do",
	            type: "post",
	            data: {
	                email: email,
	                checkNo: checkNo,
	            },
	            success: function (result) {
	                alert(result);
	                if (result === "인증 성공") {
	                    // 인증 성공 후 이메일 입력창과 인증번호 입력창의 테두리를 초록색으로 변경
	                    $("#email").css("border-color", "green");
	                    $("#checkNo").css("border-color", "green");
	
	                    // 인증 성공 후 인증 관련 요소들 비활성화
	                    $("#checkNo").attr("disabled", true);
	                    $("#validate").attr("disabled", true);
	                } else {
	                    // 인증 실패 시 이메일 입력창과 인증번호 입력창의 테두리를 빨간색으로 변경
	                    $("#email").css("border-color", "red");
	                    $("#checkNo").css("border-color", "red");
	
	                    // 인증 실패 시 이메일 입력창 및 인증번호 받기 버튼 활성화, 이메일 입력창에 포커스
	                    $("#email").attr("readonly", false).focus();
	                    $("#cert").attr("disabled", false);
	
	                    // 인증 실패 시 인증번호 입력창과 인증확인 버튼 비활성화
	                    $("#checkNo").attr("disabled", true);
	                    $("#validate").attr("disabled", true);
	                }
	            },
	            error: function () {
	                console.log("인증번호 대조용 ajax 통신 실패");
	            },
	        });
	    }
	    
	    $(function() {
	    	
	    	$(".findPwd-btn").click(function (e) {
	    	    e.preventDefault(); // 기본 폼 제출 방지

	    	    const userName = $("#userName").val().trim();
	    	    const userId = $("#userId").val().trim();
	    	    const birth = $("#birth").val().trim();
	    	    const email = $("#email").val().trim();
	    	    const checkNo = $("#checkNo").val().trim();

	    	    if (!userName || !userId || !birth || !email || !checkNo) {
	    	        alert("모든 필드를 입력해주세요.");
	    	        return;
	    	    }

	    	    $.ajax({
	                url: "findPwd.me",
	                type: "post",
	                data: {
	                    userName: userName,
	                    userId: userId,
	                    birth: birth,
	                    email: email,
	                },
	                success: function (response) {
	                    if (response === "NOT_FOUND") {
	                        alert("입력하신 정보와 일치하는 사용자가 없습니다.");
	                    } else {
	                        // 조회 성공 시 숨겨진 폼을 사용해 비밀번호 변경 페이지로 이동
	                        const form = document.createElement("form");
	                        form.method = "post";
	                        form.action = "updatePwdForm.me";

	                        const input = document.createElement("input");
	                        input.type = "hidden";
	                        input.name = "userId";
	                        input.value = userId;

	                        form.appendChild(input);
	                        document.body.appendChild(form);
	                        form.submit();
	                    }
	                },
	                error: function () {
	                    alert("비밀번호 찾기 중 오류가 발생했습니다. 다시 시도해주세요.");
	                },
	            });
	    	});

	    	
	    });
	</script>
    
</body>
</html>