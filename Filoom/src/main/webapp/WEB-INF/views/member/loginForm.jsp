<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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

    .userId, .userPwd {
        width: 100%;
        padding: 10px;
        border: 1px solid #333;
        border-radius: 5px;
        background-color: #2b2b2b;
        color: #ffffff;
        font-size: 14px;
    }

    input::placeholder {
        color: #777;
    } 

	input:focus {
	  outline: none;
	}

    .saveId {
        cursor: pointer;
        transition: color 0.3s ease;
    }

    .options {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 12px;
        color: #aaaaaa;
        margin-top: 10px;
    }

    .options a {
        color: #aaaaaa;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .options a:hover, .saveId:hover {
        color: #ffffff;
    }

    .login-btn {
        background-color: #000000;
        margin-top: 25px;
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

    .login-btn, .signup-btn {
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

    .signup-btn:hover, .login-btn:hover {
        background-color: #fff; /* 배경을 흰색으로 변경 */
        color: #000; /* 글씨 색을 검정색으로 변경 */
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
            <h1 class="login-Header">로그인</h1>
            <form action="${ pageContext.request.contextPath }/login.me" method="post">
            
                <div class="form-group">
                    <label for="userId">아이디</label>
                    <input type="text" class="userId" id="userId"  name="userId" value="${ cookie.saveId.value }"  placeholder="아이디를 입력하세요.">
                </div>
                <div class="form-group">
                    <label for="userPwd">비밀번호</label>
                    <input type="password" class="userPwd" id="userPwd" name="userPwd" placeholder="비밀번호를 입력하세요.">
                </div>
                
                <div class="options">
                
                    <c:choose>
                        <c:when test="${ not empty cookie.saveId }">
                            <div>
                                <input type="checkbox" class="saveId" id="saveId" name="saveId" value="y" checked>
                                <label for="saveId" class="saveId">아이디 저장</label>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div>
                                <input type="checkbox" class="saveId" id="saveId" name="saveId" value="y">
                                <label for="saveId" class="saveId">아이디 저장</label>
                            </div>
                        </c:otherwise>
                    </c:choose>
                
                    <div>
                        <a href="findIdForm.me">아이디 찾기</a> | <a href="findPwdForm.me">비밀번호 찾기</a>
                    </div>
                </div>
                <button type="submit" class="login-btn">로그인</button>
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
    
	    $(function () {
	        $("form").on("submit", function (e) {
	            e.preventDefault(); // 기본 폼 제출 동작 방지
	
	            // 클라이언트 유효성 검사
	            const userId = $("#userId").val().trim();
	            const userPwd = $("#userPwd").val().trim();
	
	            if (!userId) {
	                alert("아이디를 입력해주세요");
	                $("#userId").focus(); // 아이디 입력창 포커스
	                return false; // 더 이상 진행하지 않음
	            }
	
	            if (!userPwd) {
	                alert("비밀번호를 입력해주세요");
	                $("#userPwd").focus(); // 비밀번호 입력창 포커스
	                return false; // 더 이상 진행하지 않음
	            }
	
	            // 클라이언트 유효성 검사를 통과하면 AJAX 요청
	            const formData = $(this).serialize(); // 폼 데이터 직렬화
	
	            $.ajax({
	                url: "login.me",
	                method: "POST",
	                data: formData,
	                success: function (response) {
	                    if (response === "로그인 성공") {
	                        // alert(response);
	                        location.href = "${pageContext.request.contextPath}/"; // 홈으로 이동
	                    } else {
	                        alert(response); // 실패 메시지 출력
	                    }
	                },
	                error: function () {
	                    alert("로그인 처리 중 문제가 발생했습니다. 다시 시도해주세요.");
	                }
	            });
	        });
	    });

    
    </script>
    
</body>
</html>