<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
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
	    width: 80%;
	    padding: 10px;
	}
	
	.withdrawal-header {
	    font-size: 24px;
	    font-weight: bold;
	    margin-bottom: 30px;
	    border-bottom: 1px solid #333;
	    padding-bottom: 10px;
	}
	
	.withdrawal-title {
	    font-size: 18px;
	}
	
	.withdrawal-content {
	    border: 1px solid #666;
	    margin: 20px 0 0;
	    padding: 24px;
	}
	
	.box:not(.not-margin) {
	    margin-bottom: 40px;
	}
	
	.label {
	    font-size: 16px;
	    font-weight: 600;
	    margin-bottom: 16px;
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	.final-label {
	    font-size: 16px;
	    font-weight: 400;
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	label {
	    margin: 0 0 3px 0;
	    cursor: pointer;
	}
	
	.text {
	    font-size: 13px;
	}
	
	ul:not(.menu-list) {
	    margin-left: 14px;
	}
	
	ul:not(.not-margin) {
	    margin-bottom: 15px;
	}
	
	li:not(.not-margin) {
	    margin-top: 8px;
	    color: #ffffffd8;
	}
	
	h6 {
	    font-size: 14px;
	    font-weight: bold;
	}
	
	.withdrawal-footer {
	    margin-top: 20px;
	}
	
	.withdrawal-btn-box {
	    /* display: flex; */
	    text-align: center;
	    /* gap: 15px; */
	    padding-top: 40px;
	}
	
	.withdrawal-btn, .cancel-btn {
	    width: 120px;
	    padding: 10px;
	    border: none;
	    font-size: 14px;
	    /* font-weight: bold; */
	    color: #ffffff;
	    border-radius: 60px;
	    cursor: pointer;
	}
	
	.withdrawal-btn {
	    background-color: #555555;
	}
	
	.cancel-btn {
	    background-color: #493628;
	    margin-left: 8px;
	}
	
	
	input[type=checkbox] {
	    cursor: pointer;
	    zoom: 1.5;
	}
	
	
	
	
	
	.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 더 진한 배경 */
    backdrop-filter: blur(1px); /* 흐림 효과 추가 */
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.modal-content {
	background-color: #1e1e1e; /* 짙은 회색 배경 */
	color: #fff; /* 흰색 글자 */
    padding: 20px;
    text-align: center;
    border-radius: 8px;
}

.modal-btns button {
    margin: 10px;
    padding: 10px 20px;
    cursor: pointer;
}

.big-btn {
    font-size: 16px;
    padding: 12px 24px;
}

.small-btn {
    font-size: 14px;
    padding: 8px 16px;
}
	
	
	
	
	
	
	
	
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

    <div class="mypage-container">
        <div class="mypage-sidebar">
            <h2><a href="#">마이 페이지</a></h2>
            <ul class="menu-list">
                <li class="not-margin"><a href="profile.me">내 정보</a></li>
                <li class="not-margin"><a href="coupon.me">쿠폰 조회</a></li>
                <li class="not-margin"><a href="reserve.me">예매 내역 조회</a></li>
                <li class="not-margin"><a href="history.me">내가 본 영화 조회</a></li>
                <li class="not-margin"><a href="favorite.me">보고 싶은 영화 조회</a></li>
                <li class="not-margin"><a href="review.me">내가 쓴 리뷰 조회</a></li>
            </ul>
        </div>
        <div class="mypage-content">
            <h1 class="withdrawal-header">회원 탈퇴</h1>
            <div class="withdrawal-body">
                <h4 class="withdrawal-title">회원탈퇴에 앞서 아래 내용을 반드시 확인해 주세요.</h4>
                <!-- -------------------------------------- -->
                <div class="withdrawal-content">
                    
                    <div class="box">
                        <div class="label">
                            <input type="checkbox" id="info-check">
                            <label for="info-check">Filoom을 탈퇴하면 회원 정보 및 서비스 이용 기록이 삭제됩니다.</label>
                        </div>
                        <div class="text">
                            <ul>
                                <li>예매 내역, 취소 기록, 관심 영화, 작성하신 리뷰 및 댓글, 미사용 예매 쿠폰 및 포인트 등 사용자의 모든 정보가 사라지며, 재가입하더라도 복구가 불가능합니다.</li>
                                <li>탈퇴 14일 이내 재가입할 수 없으며, 탈퇴 후 동일 이메일로 재가입할 수 없습니다.</li>
                            </ul>
                        </div>
                    </div>

                    <div class="box">
                        <div class="label">
                            <input type="checkbox" id="law-check">
                            <label for="law-check">관련 법령 및 내부 기준에 따라 별도 보관하는 경우에는 일부 정보가 보관될 수 있습니다.</label>
                        </div>
                        <div class="text">
                            <h6>1. 전자상거래 등 소비자 보호에 관한 법률</h6>
                            <ul>
                                <li>영화 예매 및 취소에 관한 기록: 5년 보관</li>
                                <li>대금 결제 및 환불에 관한 기록: 5년 보관</li>
                                <li>소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관</li>
                            </ul>
                            <h6>2. 통신비밀보호법</h6>
                            <ul>
                                <li>접속 로그 기록: 3개월 보관</li>
                            </ul>
                            <h6>3. 내부 기준에 따라 별도 보관</h6>
                            <ul>
                                <li>부정 이용 방지를 위해 이메일(로그인 ID), 전화번호, CI/DI: 3년 보관</li>
                            </ul>
                        </div>
                    </div>

                    <div class="not-margin">
                        <div class="label">
                            <input type="checkbox" id="restriction-check">
                            <label for="restriction-check">Filoom 탈퇴가 제한된 경우에는 아래 내용을 참고하시기 바랍니다.</label>
                        </div>
                        <div class="text">
                            <ul class="not-margin">
                                <li>진행 중인 예매가 있을 경우: 해당 영화 상영 완료 또는 취소 후 탈퇴 가능</li>
                                <li>환불 절차가 진행 중인 경우: 환불 처리 완료 후 탈퇴 가능</li>
                                <li>미사용된 예매 쿠폰 및 포인트가 있을 경우: 해당 쿠폰 및 포인트 사용 또는 소멸 후 탈퇴 가능</li>
                                <li>이용 정지 상태인 경우: 이용 정지 해제 후 탈퇴 가능</li>
                            </ul>
                        </div>
                    </div>
                    
                </div>
                <!-- -------------------------------------- -->
                <div class="withdrawal-footer">
                    <div class="final-label">
                        <input type="checkbox" id="final-check">
                        <label for="final-check">회원탈퇴 안내를 모두 확인하였으며 탈퇴에 동의합니다.</label>
                    </div>
                </div>

                <div class="withdrawal-btn-box">
                    <button type="button" class="withdrawal-btn">탈퇴하기</button>
                    <button type="button" class="cancel-btn" onclick="location.href='profile.me'">취소하기</button>
                </div>
                <!-- -------------------------------------- -->
            </div>
        </div>
    </div>
    
    
    <!-- 비밀번호 입력 모달 -->
	<div id="pwdModal" class="modal">
	    <div class="modal-content">
	        <h2>회원 탈퇴를 위해 비밀번호를 입력해주세요.</h2>
	        <input type="password" id="currentPwd" placeholder="비밀번호를 입력해주세요">
	        <div class="modal-btns">
	            <button id="confirmPwdBtn">확인</button>
	            <button id="cancelPwdBtn">취소</button>
	        </div>
	    </div>
	</div>
	
	<!-- 최종 확인 모달 -->
	<div id="finalModal" class="modal">
	    <div class="modal-content">
	        <h2>정말 탈퇴하시겠습니까?</h2>
	        <p>탈퇴하기 클릭 시 바로 탈퇴 처리됩니다.<br>
	           탈퇴 후 14일 이내 재가입할 수 없으며, 동일 이메일을 사용할 수 없습니다.</p>
	        <label><input type="checkbox" id="agreeWithdraw"> Filoom 회원을 탈퇴하겠습니다.</label>
	        <div class="modal-btns">
	            <button id="cancelWithdrawBtn" class="big-btn">탈퇴 안 할래요</button>
	            <button id="confirmWithdrawBtn" class="small-btn">탈퇴하기</button>
	        </div>
	    </div>
	</div>
	
	<!-- 최종 탈퇴 완료 모달 -->
	<div id="doneModal" class="modal">
	    <div class="modal-content">
	        <h2>회원 탈퇴가 완료되었습니다.</h2>
	        <p>그동안 서비스를 이용해 주셔서 감사합니다.<br>
	           14일 후 Filoom을 다시 이용할 수 있습니다.</p>
	        <button id="doneConfirmBtn">확인</button>
	    </div>
	</div>
    
    
    <jsp:include page="../common/footer.jsp" />
    
    <script>
	    $(function () {
	        // 약관 동의 체크 여부 확인
	        $(".withdrawal-btn").click(function () {
	            const allChecked = $("#info-check").is(":checked") && 
	                               $("#law-check").is(":checked") &&
	                               $("#restriction-check").is(":checked") &&
	                               $("#final-check").is(":checked");
	            if (!allChecked) {
	                alert("회원탈퇴 내용을 모두 동의해 주셔야 탈퇴가 가능합니다.");
	                return;
	            }
	            $("#currentPwd").val("");
	            $("#pwdModal").show(); // 비밀번호 입력 모달 띄우기
	        });
	
	        // 비밀번호 확인 로직
	        $("#confirmPwdBtn").click(function () {
	            const currentPwd = $("#currentPwd").val();
	            if (!currentPwd) {
	                alert("비밀번호를 입력해주세요.");
	                return;
	            }
	            // AJAX로 비밀번호 확인 요청
	            $.ajax({
	                url: "checkPwd.me",
	                type: "POST",
	                data: { currentPwd: currentPwd },
	                success: function (response) {
	                    if (response === "비밀번호 일치") {
	                        $("#pwdModal").hide();
	                        $("#finalModal").show(); // 최종 확인 모달 열기
	                    } else {
	                        alert("비밀번호가 일치하지 않습니다.");
	                    }
	                },
	                error: function () {
	                    alert("비밀번호 확인 중 오류가 발생했습니다. 다시 시도해주세요.");
	                }
	            });
	        });
	
	        // 비밀번호 모달 취소 버튼
	        $("#cancelPwdBtn").click(function () {
	            $("#pwdModal").hide();
	        });
	
	        // 최종 확인 모달
	        $("#confirmWithdrawBtn").click(function () {
	            if (!$("#agreeWithdraw").is(":checked")) {
	                alert("회원 탈퇴에 동의하셔야 탈퇴가 가능합니다.");
	                return;
	            }
	            // AJAX로 회원 탈퇴 처리
	            $.ajax({
	                url: "withdraw.me",
	                type: "POST",
	                success: function (response) {
	                    if (response === "탈퇴 성공") {
	                        $("#finalModal").hide();
	                        $("#doneModal").show();
	                    } else {
	                        alert("탈퇴 처리 중 오류가 발생했습니다.");
	                    }
	                },
	                error: function () {
	                    alert("탈퇴 요청 중 문제가 발생했습니다.");
	                }
	            });
	        });
	
	        // 최종 모달의 확인 버튼
	        $("#doneConfirmBtn").click(function () {
	            location.href = "${pageContext.request.contextPath}/loginForm.me";
	        });
	
	        // 최종 확인 모달에서 '탈퇴 안 할래요' 버튼
	        $("#cancelWithdrawBtn").click(function () {
	            $("#finalModal").hide();
	        });
	    });
	</script>

    
</body>
</html>