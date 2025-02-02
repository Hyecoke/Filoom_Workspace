<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 조회</title>
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
	    width: 70%;
	    padding: 10px;
	}
	
	.header-register {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 30px;
	    border-bottom: 1px solid #333;
	    padding-bottom: 10px;
	}
	
	.coupon-header {
		display: flex;
		align-items: center;
	}

	.coupon-header h1 {
	    font-size: 24px;
	    font-weight: bold;
	}
	
	.coupon-header p {
	    font-size: 14px;
	    margin-left: 12px;
	    color: #aaa;
	}
	
	.register-btn {
	    padding: 5px 10px;
	    background-color: #493628;
	    color: #ffffff;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    font-size: 12px;
	    font-weight: 600;
	}
	
	.register-btn:hover {
		background-color: #8b5a2b;
	}
	
	/* 쿠폰 리스트 */
	.coupon-list {
		padding: 10px 20px;
	}
	
	.coupon-item {
	    margin-bottom: 30px;
	    /* border-radius: 10px;
	    background: linear-gradient(145deg, #fff8dc, #a39e95);
	    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	    opacity: 90%; */
	}
	
	.coupon-body {
	    padding: 20px 30px 30px 30px;
	    /* border-top: 1px solid #F1F1E5;
	    border-left: 1px solid #F1F1E5;
	    border-right: 1px solid #F1F1E5; */
	    border-radius: 10px;
	    background: linear-gradient(145deg, #fff8dc, #a39e95);
	    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	    opacity: 90%;
	}
	
	.coupon-footer {
	    display: flex;
	    padding: 10px 30px;
	    line-height: 30px;
	    /* border-bottom: 1px solid #F1F1E5;
	    border-left: 1px solid #F1F1E5;
	    border-right: 1px solid #F1F1E5; */
	    border-radius: 10px;
	    background: linear-gradient(145deg, #fff8dc, #a39e95);
	    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
	    opacity: 90%;
	}
	
	.coupon-title {
	    font-size: 20px;
	    font-weight: bold;
	    margin-bottom: 6px;
	    color: rgb(34, 34, 34);;
	}
	
	.coupon-detail {
	    font-size: 14px;
	    font-weight: bold;
	    margin-bottom: 16px;
	    color: rgb(34, 34, 34);;
	}
	
	.coupon-caution {
	    font-size: 12px;
	    font-weight: 400;
	    color: rgba(34, 34, 34, .8);
	}
	
	hr {
	    border-width: 1px 0 0 0;
	    border-style: dashed;
	    border-color: #999;
	    margin: 0 10px;
	}
	
	.count-day {
	    color: #F15746;
	    font-size: 13px;
	    font-weight: bold;
	    margin-right: 15px;
	}
	
	.d-day {
	    font-size: 13px;
	    font-weight: 400;
	    color: rgba(34, 34, 34, .8);;
	}
	
	
	
	
	/* 모달 */
	.modal {
	    display: none; /* 기본적으로 숨김 */
	    position: fixed;
	    z-index: 1000;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.5); /* 더 진한 배경 */
	    backdrop-filter: blur(1px); /* 흐림 효과 추가 */
	    display: flex; /* Flexbox로 정렬 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	}
	
	.modal-content {
	    background-color: #1e1e1e; /* 짙은 회색 배경 */
	    color: #fff; /* 흰색 글자 */
	    padding: 30px;
	    border-radius: 15px;
	    width: 40%; /* 적절한 너비 */
	    max-width: 500px;
	    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5); /* 부드러운 그림자 */
	    position: relative;
	    text-align: center; /* 내용 가운데 정렬 */
	    animation: fadeIn 0.3s ease-out; /* 부드러운 나타남 효과 */
	}
	
	/* 닫기 버튼 스타일 */
	.modal-content .close-btn {
	    position: absolute;
	    top: 15px;
	    right: 15px;
	    background: none;
	    border: none;
	    font-size: 20px;
	    color: #fff;
	    cursor: pointer;
	    transition: transform 0.2s ease, color 0.2s ease;
	}
	
	.modal-content .close-btn:hover {
	    color: #ff6363; /* 닫기 버튼 호버 효과 */
	    transform: scale(1.2); /* 크기 확대 */
	}
	
	/* 나타나는 애니메이션 */
	@keyframes fadeIn {
	    from {
	        opacity: 0;
	        transform: scale(0.9);
	    }
	    to {
	        opacity: 1;
	        transform: scale(1);
	    }
	}


	
	.no-coupon {
		padding: 10px 0 100px 0;
		text-align: center;
		font-size: 20px;
		/* font-weight: bold; */
    	color: #aaa;
	}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />
	
    <div class="mypage-container">
        <div class="mypage-sidebar">
            <h2><a href="#">마이 페이지</a></h2>
            <ul class="menu-list">
                <li><a href="profile.me">내 정보</a></li>
                <li class="active"><a href="coupon.me">쿠폰 조회</a></li>
                <li><a href="reserve.me">예매 내역 조회</a></li>
                <li><a href="history.me">내가 본 영화 조회</a></li>
                <li><a href="favorite.me">보고 싶은 영화 조회</a></li>
                <li><a href="review.me">내가 쓴 리뷰 조회</a></li>
            </ul>
        </div>
        <div class="mypage-content">
            <div class="header-register">
            	<div class="coupon-header">
            		<h1>내 쿠폰</h1>
            		<p>쿠폰은 결제 페이지에서 사용하실 수 있습니다.</p>
            	</div>
                <button class="register-btn">+ 쿠폰 등록하기</button>
            </div>
            
            <!-- 모달 -->
			<div class="modal" id="coupon-modal" style="display: none;">
			    <div class="modal-content">
			        <span class="close-btn">&times;</span>
			        <h2>쿠폰 등록하기</h2>
			        <form id="coupon-form">
			            <label for="coupon-code">쿠폰 코드</label>
			            <input type="text" id="coupon-code" placeholder="xxxx-xxxx-xxxx-xxxx" required />
			            <button type="submit" class="submit-btn">등록</button>
			        </form>
			    </div>
			</div>
            
            <div class="coupon-list">
            
            	<c:choose>
            		<c:when test="${empty couponList}">
            			<div class="no-coupon">
            				보유한 쿠폰이 없습니다.
            			</div>
            		</c:when>

					<c:otherwise>
						<c:forEach var="coupon" items="${couponList}">
			                <div class="coupon-item" data-coupon-no="${coupon.couponNo}">
			                    <div class="coupon-body">
			                        <h3 class="coupon-title">${coupon.couponName}</h3>
			                        <p class="coupon-detail">무료 영화 관람권</p>
			                        <li class="coupon-caution">쿠폰 1매당 1인 적용 가능</li>
			                        <li class="coupon-caution">평일/주말/공휴일 모두 가능</li>
			                        <li class="coupon-caution">일부 상영관 제외</li>
			                    </div>
			                    <hr>
			                    <div class="coupon-footer">
			                        <span class="count-day"></span>
			                        <p class="d-day">${coupon.couponExpDate} 까지</p>
			                    </div>
			                </div>
		                </c:forEach>
	                </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script>
	    $(document).ready(function() {
	        function calculateDaysLeft(expDateStr) {
	            // DB에서 제공된 만료일 문자열 형식: YY/MM/DD HH24:MI:SS
	            const formatDate = function(dateStr) {
	                const parts = dateStr.split(' ');
	                const datePart = parts[0].split('/').map(Number);
	                const timePart = parts[1].split(':').map(Number);
	                return new Date(2000 + datePart[0], datePart[1] - 1, datePart[2], timePart[0], timePart[1], timePart[2]);
	            };

	            const expDate = formatDate(expDateStr);
	            const now = new Date();
	            const diffTime = expDate - now;
	            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // 밀리초 -> 일 단위 변환

	            return diffDays >= 0 ? diffDays : -1; // 유효하지 않은 경우 -1 반환
	        }

	        $('.coupon-footer').each(function() {
	            const expDateStr = $(this).find('.d-day').text().trim(); // 쿠폰 만료일 텍스트 가져오기
	            const daysLeft = calculateDaysLeft(expDateStr);

	            if (daysLeft <= 9 && daysLeft >= 0) { // D-9 이하, 만료되지 않은 경우
	                $(this).find('.count-day').text('D-' + daysLeft); // D-날짜 업데이트
	            } else {
	                $(this).find('.count-day').text(''); // 조건에 맞지 않을 경우 비움
	            }
	        });
	    });

	    $(document).ready(function() {
	        // 모달 열기
	        $('.register-btn').on('click', function() {
	            $('#coupon-modal').fadeIn();
	        });

	        // 모달 닫기
	        $('.close-btn').on('click', function() {
	            $('#coupon-modal').fadeOut();
	        });

	        // 모달 외부 클릭 시 닫기
	        $(window).on('click', function(event) {
	            if ($(event.target).is('#coupon-modal')) {
	                $('#coupon-modal').fadeOut();
	            }
	        });

	        // 쿠폰 등록 폼 제출 처리
	        $('#coupon-form').on('submit', function(event) {
	            event.preventDefault(); // 폼 기본 동작 방지

	            const couponCode = $('#coupon-code').val().trim();

	            // 쿠폰 유효성 검사 (16자리 형식)
	            const isValidFormat = /^[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}-[A-Za-z0-9]{4}$/.test(couponCode);

	            if (isValidFormat) {
	                alert('등록되지 않은 쿠폰입니다.');
	                $("#coupon-code").focus().css("border-color", "red");
	            } else {
	                alert('쿠폰 형식이 올바르지 않습니다. 16자리 코드를 입력해주세요.');
	            }
	        });
	    });








		




    </script>
    
</body>
</html>