<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>
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
	
	/* 마이페이지 컨테이너 */
	.mypage-container {
	    display: flex;
	    width: 1100px;
	    background-color: #1e1e1e;
	    border-radius: 10px;
	    padding: 50px;
	    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
	    overflow: hidden;
	    margin: 50px auto;
	}
	
	/* 사이드바 */
	.mypage-sidebar {
	    width: 20%;
	    padding: 10px;
	}
	
	.mypage-sidebar h2 a {
	    color: #fff; /* 흰 글씨 */
	    font-size: 20px; /* 큰 폰트 크기 */
	    font-weight: bold; /* 굵은 폰트 */
	    text-decoration: none; /* 밑줄 제거 */
	    display: block;
	    margin-bottom: 30px; /* 아래 간격 */
	}
	
	.menu-list {
	    list-style: none;
	    padding: 0;
	    margin: 0;
	}
	
	.menu-list li a {
	    color: #aaa; /* 기본 회색 글씨 */
	    font-size: 14px; /* 작은 폰트 크기 */
	    font-weight: normal; /* 얇은 폰트 */
	    text-decoration: none; /* 밑줄 제거 */
	    display: block;
	    padding: 10px 0; /* 상하 간격 */
	    transition: color 0.3s ease;
	}
	
	.menu-list li.active a {
	    color: #fff; /* 흰 글씨 */
	    font-size: 16px; /* 작지만 조금 큰 폰트 크기 */
	    font-weight: bold; /* 굵은 폰트 */
	}
	
	.menu-list li a:hover {
	    color: #ffffff;
	    font-weight: bold;
	}
	
	/* 콘텐츠 영역 */
	.mypage-content {
	    width: 60%;
	    padding: 10px;
	}
	
	.profile-header {
	    font-size: 24px;
	    font-weight: bold;
	    margin-bottom: 30px;
	    border-bottom: 1px solid #333;
	    padding-bottom: 10px;
	}
	
	/* 정보 리스트 */
	.info-list {
	    display: flex;
	    flex-direction: column;
	    gap: 20px;
	}
	
	.info-item {
	    /* display: flex; */
	    align-items: center;
	    border-bottom: 1px solid #333;
	    /* padding: 10px 0; */
	}
	
	.label {
	    font-size: 14px;
	    font-weight: bold;
	    color: #fff;
	    border-left: 2px solid #666;
	    padding-left: 10px;
	}
	
	.value-btn {
	    display: flex;
	    align-items: center;
	    justify-content: space-between;
	    flex: 1; /* 남은 공간을 차지 */
	}
	
	.value-btn {
	    display: flex;
	    justify-content: space-between;
	}
	
	.value, .value-notChange {
	    font-size: 16px;
	    font-weight: 400;
	    margin: 15px 0;
	    padding-left: 10px;
	}
	
	.value-notChange {
	    color: #888;
	}


	.btn-change {
	    padding: 5px 10px;
	    background-color: transparent;
	    border: 1px solid rgba(228, 224, 225, 20%);
	    border-radius: 10px;
	    color: #fff;
	    cursor: pointer;
	    font-size: 14px;
	    transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
	}
	
	.btn-change:hover {
	    background-color: #999999;
	    color: #000;
	}
	
	/* 약관 모달 스타일 */
	.agreement-modal {
	    display: none; /* 기본적으로 숨김 */
	    position: fixed;
	    z-index: 1000;
	    left:50%;
	    top: 50%;
	    width: 100%;
	    height: 100%;
	    transform: translate(-50%, -50%);
	    background-color: rgba(0, 0, 0, 0.6);
	    max-width: 1100px;
	}
	
	/* 모달 내용 */
	.agreement-modal-content {
	    background-color: #fff;
	    color: #000;
	    margin: 15% auto;
	    padding: 20px;
	    border-radius: 10px;
	    width: 60%;
	    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	    position: relative;
	}
	
	/* 닫기 버튼 */
	.close-btn {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	    cursor: pointer;
	}
	
	.close-btn:hover {
	    color: #000;
	}
	
	/* 자세히 보기 버튼 */
	.open-modal-btn, .out {
	    background: none;
	    border: none;
	    border-bottom: 1px solid #aaa;
	    color: #aaa;
	    cursor: pointer;
	    font-size: 12px;
	    margin-left: 5px;
	}
	
	.out {
	    margin-top: 70px;
	    width: 48px;
	    text-decoration: none;
	}
	
	.open-modal-btn:hover, .out:hover {
	    color: #fff;
	}
	
	/* 토글스위치 */
	/* The switch - the box around the slider */
	.switch {
	    position: relative;
	    display: inline-block;
	    width: 40px;
	    height: 22px;
	    vertical-align:middle;
	}
	
	/* Hide default HTML checkbox */
	.switch input {display:none;}
	
	/* The slider */
	.slider {
	    position: absolute;
	    cursor: pointer;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    background-color: #939393;
	    -webkit-transition: .4s;
	    transition: .4s;
	}
	
	.slider:before {
	    position: absolute;
	    content: "";
	    height: 18px;
	    width: 18px;
	    left: 2px;
	    bottom: 2px;
	    background-color: white;
	    -webkit-transition: .4s;
	    transition: .4s;
	}
	
	input:checked + .slider {
	    background-color: #67503F;
	}
	
	input:focus + .slider {
	    box-shadow: 0 0 1px #67503F;
	}
	
	input:checked + .slider:before {
	    -webkit-transform: translateX(18px);
	    -ms-transform: translateX(18px);
	    transform: translateX(18px);
	}
	
	/* Rounded sliders */
	.slider.round {
	    border-radius: 34px;
	}
	
	.slider.round:before {
	    border-radius: 50%;
	}

	

	.changes-btn:hover {
        background-color: #fff; /* 배경을 흰색으로 변경 */
        color: #000; /* 글씨 색을 검정색으로 변경 */
    }

/* ----------------------------- */
	
	/* 모달 배경 */
.modal {
    display: none; /* 기본적으로 숨김 */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6); /* 어두운 반투명 배경 */
    z-index: 1000;
    justify-content: center;
    align-items: center; /* 세로 중앙 정렬 */
}

/* 모달 콘텐츠 박스 */
.modal-content {
    background-color: #ffffff;
    width: 90%;
    max-width: 500px; /* 최대 너비 */
    border-radius: 10px;
    padding: 20px 30px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3); /* 그림자 */
    animation: fadeIn 0.3s ease-in-out;
}

/* 모달 닫기 버튼 */
.modal .close {
    float: right;
    font-size: 20px;
    font-weight: bold;
    color: #888888;
    cursor: pointer;
    transition: color 0.3s ease;
}

.modal .close:hover {
    color: #ff5555; /* 닫기 버튼 호버 색상 */
}

/* 폼 내 요소들 */
.modal-content h2 {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
    color: #333333;
}

.modal-content .form-group {
    margin-bottom: 20px;
}

.modal-content label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #555555;
}

.modal-content .changeInput {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #cccccc;
    border-radius: 5px;
    transition: border-color 0.3s ease;
}

.modal-content .changeInput:focus {
    border-color: #007bff; /* 포커스 시 파란 테두리 */
    outline: none;
}

.modal-content button[type="submit"] {
    width: 100%;
    padding: 12px 20px;
    font-size: 18px;
    font-weight: bold;
    color: #ffffff;
    background-color: #007bff; /* 파란색 */
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.modal-content button[type="submit"]:hover {
    background-color: #0056b3; /* 호버 시 색상 변경 */
}

/* 페이드 인 애니메이션 */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: scale(0.95);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}

	


</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

    <div class="mypage-container">
        <div class="mypage-sidebar">
            <h2><a href="#">마이 페이지</a></h2>
            <ul class="menu-list">
                <li class="active"><a href="profile.me">내 정보</a></li>
                <li><a href="coupon.me">쿠폰 조회</a></li>
                <li><a href="reserve.me">예매 내역 조회</a></li>
                <li><a href="history.me">내가 본 영화 조회</a></li>
                <li><a href="favorite.me">보고 싶은 영화 조회</a></li>
                <li><a href="review.me">내가 쓴 리뷰 조회</a></li>
            </ul>
        </div>
        <div class="mypage-content">
            <h1 class="profile-header">내 정보</h1>
            <div class="info-list">

                <div class="info-item">
                    <label class="label">아이디</label>
                    <div class="value-notChange">
                        ${ sessionScope.loginUser.userId }
                    </div>
                </div>

                <div class="info-item">
                    <label class="label">이메일</label>
                    <div class="value-notChange">
                        ${ sessionScope.loginUser.email }
                    </div>
                </div>

                <div class="info-item">
                    <label class="label">비밀번호</label>
                    <div class="value-btn">
                        <div class="value">
                            ●●●●●●●●●●
                        </div>
                        <button type="button" class="btn-change" onclick="showChangePwdModal()">
                            변경
                        </button>
                    </div>
                </div>

				<!-- 비밀번호 변경 모달 -->
				<div id="changePwdModal" class="modal">
				    <div class="modal-content">
				        <span class="close" onclick="closeChangePwdModal()">&times;</span>
				        <h2>비밀번호 변경</h2>
				        <form id="changePwdForm" action="changePwd.me" method="post">
				            <div class="form-group">
				                <label for="currentPassword">기존 비밀번호</label>
				                <input type="password" class="changeInput" id="currentPwd" name="currentPwd" placeholder="기존 비밀번호를 입력해주세요" required>
				            </div>
				            <div class="form-group">
				                <label for="newPassword">새 비밀번호</label>
				                <input type="password" class="changeInput" id="newPwd" name="newPwd" placeholder="새 비밀번호를 입력해주세요" required>
				            </div>
				            <div class="form-group">
				                <label for="confirmNewPassword">새 비밀번호 확인</label>
				                <input type="password" class="changeInput" id="confirmNewPwd" name="confirmNewPwd" placeholder="새 비밀번호를 다시 입력해주세요" required>
				            </div>
				            <button type="submit">완료</button>
				        </form>
				    </div>
				</div>

                <div class="info-item">
                    <label class="label">이름</label>
                    <div class="value-btn">
                        <div class="value">
                            ${ sessionScope.loginUser.userName }
                        </div>
                        <button type="button" class="btn-change" onclick="showChangeNameModal()">
                            변경
                        </button>
                    </div>
                </div>
                
                <!-- 이름 변경 모달 -->
				<div id="changeNameModal" class="modal">
				    <div class="modal-content">
				        <span class="close" onclick="closeChangeNameModal()">&times;</span>
				        <h2>이름 변경</h2>
				        <form id="changeNameForm" action="changeName.me" method="post">
				            <div class="form-group">
				                <label for="newName">변경할 이름</label>
				                <input type="text" class="changeInput" id="newName" name="newName" placeholder="${sessionScope.loginUser.userName}" required>
				            </div>
				            <button type="submit">완료</button>
				        </form>
				    </div>
				</div>
				
                <div class="info-item">
                    <label class="label">성별</label>
                    <div class="value-btn">
                        <div class="value">
                            <c:choose>
		                        <c:when test="${empty sessionScope.loginUser.gender}">
		                            선택 안함
		                        </c:when>
		                        <c:when test="${sessionScope.loginUser.gender == 'M'}">
		                            남성
		                        </c:when>
		                        <c:when test="${sessionScope.loginUser.gender == 'F'}">
		                            여성
	                        </c:when>
                    </c:choose>
                        </div>
                        <button type="button" class="btn-change" onclick="showChangeGenderModal()">
                            변경
                        </button>
                    </div>
                </div>
                
                <!-- 성별 변경 모달 -->
				<div id="changeGenderModal" class="modal">
				    <div class="modal-content">
				        <span class="close" onclick="closeChangeGenderModal()">&times;</span>
				        <h2>성별 변경</h2>
				        <form id="changeGenderForm" action="changeGender.me" method="post">
				            <div class="form-group">
								<label><input type="radio" class="changeGender" name="gender" value="">선택안함</label>
                        		<label><input type="radio" class="changeGender" name="gender" value="M">남성</label>
                        		<label><input type="radio" class="changeGender" name="gender" value="F">여성</label>
				            </div>
				            <button type="submit">완료</button>
				        </form>
				    </div>
				</div>
                
                <div class="info-item">
                    <label class="label">생년월일</label>
                    <div class="value-btn">
                        <div class="value">
                            <c:set var="birth" value="${sessionScope.loginUser.birth}" />
				            <c:if test="${not empty birth}">
				                ${birth.substring(0, 4)}년 ${birth.substring(4, 6)}월 ${birth.substring(6, 8)}일
				            </c:if>
                        </div>
                        <button type="button" class="btn-change" onclick="showChangeBirthModal()">
                            변경
                        </button>
                    </div>
                </div>
                
                <!-- 생년월일 변경 모달 -->
				<div id="changeBirthModal" class="modal">
				    <div class="modal-content">
				        <span class="close" onclick="closeChangeBirthModal()">&times;</span>
				        <h2>생년월일 변경</h2>
				        <form id="changeBirthForm" action="changeBirth.me" method="post">
						    <div class="form-group">
						        <label for="birthDate">변경할 생년월일</label>
						        <input type="date" id="birthDate" name="birthDate">
						        <input type="hidden" id="formattedBirthDate" name="formattedBirthDate"> <!-- 포매팅된 값 전달 -->
						    </div>
						    <button type="submit">완료</button>
						</form>
				    </div>
				</div>
                
                <div class="info-item">
                    <label class="label">약관동의</label>
                    <div class="value-btn">
                        <div class="value">
                            개인 정보 마케팅 활용 동의
                            <button class="open-modal-btn" data-target="modal">내용 보기</button>
                        </div>
                        <label class="switch">
                            <input type="checkbox" id="marketingConsent" class="checkbox"
                            	<c:if test="${sessionScope.loginUser.marketing == 'Y'}">
				                    checked
				                </c:if>
                            >
                            <span class="slider round"></span>
                        </label>
                    </div>
                </div>
                
                <!-- 모달창 -->
				<div id="marketingModal" class="modal">
				    <div class="modal-content">
				        <h2>개인정보 마케팅 활용 동의 철회</h2>
				        <p>마케팅 활용에 동의하지 않을 시 <strong>혜택과 다양한 이벤트 소식</strong>을 제공받을 수 없습니다. 계속하시겠습니까?</p>
				        <div class="modal-buttons">
				            <button id="confirmUnsubscribe" class="btn">해제</button>
				            <button id="cancelUnsubscribe" class="btn">유지</button>
				        </div>
				    </div>
				</div>

	                <a class="out" href="withdrawal.me">회원탈퇴</a>

                <!-- 약관 내용 모달 -->
                <div id="agreement-modal" class="agreement-modal">
                    <div class="agreement-modal-content">
                        <span class="close-btn">&times;</span>
                        <h2>마케팅 활용 동의</h2><hr>
                        <p>마케팅 활용에 대한 설명이 여기에 표시됩니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script>
        
     	// 비밀번호 변경 모달 보여주기
        function showChangePwdModal() {
        	$('#changePwdModal').css('display', 'flex');
        }

        // 비밀번호 변경 모달 닫기
        function closeChangePwdModal() {
        	$('#changePwdModal').css('display', 'none');
        }

        $(function() {
            // 비밀번호 유효성 검사 정규식
            const pwdRegexp = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+~`|}{[\]:;?><,./-]).{8,}$/;

            // 새 비밀번호 유효성 검사
            $("#newPwd").on("keyup", function() {
                const newPwd = $(this).val();
                if (pwdRegexp.test(newPwd)) {
                    $(this).css("border-color", "green");
                } else {
                    $(this).css("border-color", "red");
                }
            });

            // 새 비밀번호 확인 검사
            $("#confirmNewPwd").on("keyup", function() {
                const newPwd = $("#newPwd").val();
                const confirmNewPwd = $(this).val();
                if (newPwd === confirmNewPwd && pwdRegexp.test(newPwd)) {
                    $(this).css("border-color", "green");
                } else {
                    $(this).css("border-color", "red");
                }
            });

            // 폼 제출 이벤트
            $("#changePwdForm").on("submit", function(e) {
                e.preventDefault(); // 기본 폼 제출 막기

                const formData = $(this).serialize(); // 폼 데이터 직렬화
                const newPwd = $("#newPwd").val();
                const confirmNewPwd = $("#confirmNewPwd").val();
                
                if (!newPwd) {
	                alert("새 비밀번호를 입력해주세요.");
	                $("#newPwd").focus().css("border-color", "red");
	                return;
	            }

                // 새 비밀번호 조건 확인
                if (!pwdRegexp.test(newPwd)) {
                    alert("새 비밀번호는 영문, 숫자, 특수문자를 포함한 8자 이상이어야 합니다.");
                    $("#newPwd").focus().css("border-color", "red");
                    return;
                }
                
                if (!confirmNewPwd) {
	                alert("비밀번호 확인란을 입력해주세요.");
	                $("#confirmNewPwd").focus().css("border-color", "red");
	                return;
	            }

                // 새 비밀번호와 확인 비밀번호 일치 확인
                if (newPwd !== confirmNewPwd) {
                    alert("새 비밀번호가 일치하지 않습니다.");
                    $("#confirmNewPwd").focus().css("border-color", "red");
                    return;
                }

                // AJAX 요청
                $.ajax({
                    url: "changePwd.me",
                    method: "POST",
                    data: formData,
                    success: function(result) {
                        alert(result); // 서버에서 반환된 메시지를 alert로 출력

                        // 성공 메시지일 경우 특정 동작 (예: 페이지 이동)
                        if (result === "비밀번호가 성공적으로 변경되었습니다. 로그인 페이지로 이동합니다.") {
                            location.href = "${pageContext.request.contextPath}/loginForm.me"; // 마이페이지로 이동
                        } else {
                        	$("#currentPwd").focus().css("border-color", "red");
                        }
                    },
                    error: function() {
                        alert("비밀번호 변경 중 오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
        });

     	// 이름 변경 모달 보여주기
        function showChangeNameModal() {
        	$('#changeNameModal').css('display', 'flex');
        }

        // 이름 변경 모달 닫기
        function closeChangeNameModal() {
        	$('#changeNameModal').css('display', 'none');
        }
     	
        $(function() {
        	// 이름 조건 : 한글 또는 영문, 최소 2자 이상 20자 이하
	        const nameRegexp = /^[가-힣a-zA-Z]{2,20}$/;
	        
	     	// 이름 유효성 검사
	        $("#newName").on("keyup", function () {
	            const newName = $(this).val();
	            if (nameRegexp.test(newName)) {
	                $(this).css("border-color", "green");
	            } else {
	                $(this).css("border-color", "red");
	            }
	        });
	        
        	$("#changeNameForm").on("submit", function (e) {
        	    e.preventDefault();

        	    const newName = $("#newName").val().trim();
        	    
        	    if (!newName) {
        	        alert("이름을 입력해주세요.");
        	        $("#newName").focus().css("border-color", "red");
        	        return;
        	    }

        	    if (!nameRegexp.test(newName)) {
        	        alert("이름은 한글 또는 영문으로 2~20자 이내로 입력해주세요.");
        	        $("#newName").focus().css("border-color", "red");
        	        return;
        	    }

        	    $.ajax({
        	        url: "changeName.me",
        	        type: "POST",
        	        data: { newName: newName },
        	        success: function (response) {
        	            alert(response);
        	            if (response === "이름이 성공적으로 변경되었습니다.") {
        	                location.reload(); // 성공 시 페이지 리로드
        	            } else {
        	            	$("#newName").focus().css("border-color", "red");
        	            }
        	        },
        	        error: function () {
        	            alert("이름 변경 중 오류가 발생했습니다. 다시 시도해주세요.");
        	        },
        	    });
        	});
        });
        
     	// 성별 변경 모달 보여주기
        function showChangeGenderModal() {
        	$('#changeGenderModal').css('display', 'flex');
        }

        // 성별 변경 모달 닫기
        function closeChangeGenderModal() {
        	$('#changeGenderModal').css('display', 'none');
        }

        $(function () {
            // 현재 로그인된 사용자의 성별 값 가져오기 (예: "M", "F", "")
            const currentGender = "${loginUser.gender}"; // 서버에서 JSTL을 통해 성별 전달

            // 해당 성별에 맞는 라디오 버튼을 체크
            if (currentGender === "M") {
                $("input[name='gender'][value='M']").prop("checked", true);
            } else if (currentGender === "F") {
                $("input[name='gender'][value='F']").prop("checked", true);
            } else {
                $("input[name='gender'][value='']").prop("checked", true);
            }
            
            $("#changeGenderForm").on("submit", function (e) {
                e.preventDefault(); // 기본 폼 제출 방지

                const newGender = $("input[name='gender']:checked").val();

                $.ajax({
                    url: "changeGender.me",
                    type: "POST",
                    data: { gender: newGender },
                    success: function (response) {
                        alert(response); // 성공/실패 메시지 출력
                        if (response === "성별이 성공적으로 변경되었습니다.") {
                            location.reload(); // 성공 시 페이지 새로고침
                        }
                    },
                    error: function () {
                        alert("성별 변경 중 오류가 발생했습니다. 다시 시도해주세요.");
                    },
                });
            });
        });
        
     	// 생년월일 변경 모달 보여주기
        function showChangeBirthModal() {
        	$('#changeBirthModal').css('display', 'flex');
        }

        // 성별 변경 모달 닫기
        function closeChangeBirthModal() {
        	$('#changeBirthModal').css('display', 'none');
        }

        $(function () {
            $("#changeBirthForm").on("submit", function (e) {
                e.preventDefault(); // 기본 폼 제출 동작 방지

                let birthDate = $("#birthDate").val(); // yyyy-mm-dd 형식의 값
                if (!birthDate) {
                    alert("생년월일을 선택해주세요.");
                    return;
                }

                // 생년월일을 YYYYMMDD 형식으로 변환
                birthDate = birthDate.replaceAll("-", "");

                $.ajax({
                    url: "changeBirth.me",
                    type: "POST",
                    data: { birthDate: birthDate },
                    success: function (response) {
                        alert(response);
                        if (response === "생년월일이 성공적으로 변경되었습니다.") {
                            location.reload(); // 성공 시 페이지 새로고침
                        }
                    },
                    error: function () {
                        alert("생년월일 변경 중 오류가 발생했습니다. 다시 시도해주세요.");
                    },
                });
            });
        });
        
        
        
        $(function () {
            // 마케팅 동의 체크박스 변경 이벤트
            $("#marketingConsent").change(function () {
                const isChecked = $(this).is(":checked");

                if (isChecked) {
                    // 활성화 (바로 동의)
                    const currentDate = new Date().toLocaleString();
                    alert("전송자 : (주)필룸\n일시 : " + currentDate + "\n처리내용 : 개인 정보 마케팅 활용 동의 완료");
                    changeMarketing("Y");
                } else {
                    // 비활성화 시 모달만 띄움 (체크박스 상태 변경은 보류)
                    $("#marketingModal").fadeIn(200);

                    // 체크박스 상태를 다시 원래대로 설정 (임시 유지)
                    $(this).prop("checked", true);
                }
            });

            // 모달: 해제 버튼 클릭
            $("#confirmUnsubscribe").click(function () {
                $("#marketingModal").fadeOut(100);
                const currentDate = new Date().toLocaleString();

                // 체크박스를 비활성화 (해제)
                $("#marketingConsent").prop("checked", false);

                alert("전송자 : (주)필룸\n일시 : " + currentDate + "\n처리내용 : 개인 정보 마케팅 활용 동의 철회");
                changeMarketing("N"); // AJAX 호출
            });

            // 모달: 유지 버튼 클릭
            $("#cancelUnsubscribe").click(function () {
                $("#marketingModal").fadeOut(100);
                // 체크박스 상태를 그대로 유지 (아무 것도 하지 않음)
            });

            // DB 업데이트 AJAX
            function changeMarketing(consentValue) {
                $.ajax({
                    url: "changeMarketing.me",
                    method: "POST",
                    data: { marketing: consentValue },
                    success: function (response) {
                        console.log("마케팅 동의 업데이트 성공:", response);
                    },
                    error: function () {
                        alert("정보 업데이트 중 문제가 발생했습니다. 다시 시도해주세요.");
                    },
                });
            }
        });






        


     	


     	// 약관모달-------------------------------------------------
        $(function () {
            // 모달 열기
            $('.open-modal-btn').click(function () {
                const targetModal = '#' + $(this).data('target');
                $(targetModal).fadeIn(200); // 모달을 서서히 나타냄
            });

            // 모달 닫기
            $('.close-btn').click(function () {
                $(this).closest('.modal').fadeOut(100); // 모달을 서서히 사라지게 함
            });

            // 모달 외부 클릭 시 닫기
            $(window).click(function (event) {
                if ($(event.target).hasClass('modal')) {
                    $(event.target).fadeOut(100);
                }
            });
        });

    </script>
</body>
</html>