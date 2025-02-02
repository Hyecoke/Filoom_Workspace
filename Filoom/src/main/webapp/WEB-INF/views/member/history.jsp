<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 본 영화 조회</title>
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
	
	.history-header{
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    border-bottom: 1px solid #333;
	    margin-bottom: 30px;
	    padding-bottom: 10px;
	}
	
	.history-num {
	    display: flex;
	    justify-content: space-between;
	}
	
	.history-num h1 {
	    font-size: 24px;
	    font-weight: bold;
	}
	
	.history-num span {
	    font-size: 24px;
	    margin-left: 12px;
	    color: #aaa;
	}
	
	.history-list {
	    padding: 10px 20px;
	}
	
	.year-search {
	    margin-right: 10px;
	}
	
	#year-select,
	#year-btn {
	    padding: 4px 10px;
	    border: 1px solid #333;
	    border-radius: 5px;
	    background-color: #2b2b2b;
	    color: #ffffff;
	    font-size: 14px;
	    line-height: 1.5; /* 동일한 라인 높이 */
	    box-sizing: border-box; /* 박스 모델 통일 */
	    cursor: pointer;
	}
	
	#year-btn {
	    cursor: pointer;
	    padding: 2px 15px;
	    background-color: #493628;
	    font-weight: bold;
	}
	
	#year-btn:hover {
		background-color: #8b5a2b;
	}
	
	.history-item {
	    border: 1px solid #444;
	    border-radius: 10px;
	    margin-bottom: 30px;
	    padding: 20px;
	}
	
	.box-info {
	    display: flex;
	    gap: 10px; /* 좌우 박스 간 간격 */
	}
	
	.poster {
	    width: 110px;
	    height: 158px;
	    margin-right: 20px;
	}
	
	.history-info,
	.title-delete,
	.history-content ul {
	    overflow: hidden;
	}
	
	.history-info {
	    width: 100%;
	    display: flex;
	    flex-direction: column; /* 상하 배치 */
	    padding: 10px 0;
	}
	
	.title-delete {
	    width: 100%;
	    display: flex;
	    justify-content: space-between;
	    border-bottom: 1px solid #444;
	    padding-bottom: 5px;
	    margin-bottom: 20px;
	}
	
	.movie-title {
	    text-decoration: none;
	    color: #fff;
	    font-size: 22px;
	    font-weight: bold;
		overflow: hidden; /* 넘치는 텍스트 숨기기 */
	    text-overflow: ellipsis; /* ... 표시 */
		white-space: nowrap; /* 한 줄로 유지 */
		max-width: 440px;
		display: block;
	}
	
	.history-delete-btn, .review-plz {
	    background-color: #49362800;
	    color: #aaa;
	    border: none;
	    cursor: pointer;
	    font-size: 12px;
	    text-decoration: none;
	    transition: color 0.3s ease;
	}
	
	.history-delete-btn:hover, .review-plz:hover {
		color: #fff;
	    font-weight: bold;
	}
	
	/* 전체 예약 내용 컨테이너 */
	.history-content {
	    font-size: 14px;
	}
	
	.history-content p {
	    margin-bottom: 10px;
	}
	
	select:focus {
	  	outline: none;
	}
	
	#btn-more {
		background-color: #493628;
        margin-top: 50px;
		width: 30%;
        padding: 10px;
        border: none;
        font-size: 16px;
        font-weight: bold;
        color: #ffffff;
        border-radius: 60px;
        cursor: pointer;
        transition: background-color 0.3s ease, color 0.3s ease; /* 배경색과 글씨 색 변화를 위한 트랜지션 */
	}
	
	#btn-more:hover {
		background-color: #fff; /* 배경을 흰색으로 변경 */
        color: #000; /* 글씨 색을 검정색으로 변경 */
	}

	.no-history {
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
                <li><a href="coupon.me">쿠폰 조회</a></li>
                <li><a href="reserve.me">예매 내역 조회</a></li>
                <li class="active"><a href="history.me">내가 본 영화 조회</a></li>
                <li><a href="favorite.me">보고 싶은 영화 조회</a></li>
                <li><a href="review.me">내가 쓴 리뷰 조회</a></li>
            </ul>
        </div>
        <div class="mypage-content">
            <div class="history-header">
                
                <div class="history-num">
                    <h1>내가 본 영화</h1>
                    <span>${fn:length(historyList)}건</span>
                </div>

				<form method="GET" action="/history.me">
	                <div class="year-search">
					    <select name="year" id="year-select">
						    <option value="all" ${selectedYear == 'all' ? 'selected' : ''}>전체</option>
						    <option value="2021" ${selectedYear == '2021' ? 'selected' : ''}>2021</option>
						    <option value="2022" ${selectedYear == '2022' ? 'selected' : ''}>2022</option>
						    <option value="2023" ${selectedYear == '2023' ? 'selected' : ''}>2023</option>
						    <option value="2024" ${selectedYear == '2024' ? 'selected' : ''}>2024</option>
						</select>

					    <button type="button" id="year-btn">검색</button>
					</div>
				</form>

            </div>
            <!-- 예매 내역과 취소 내역을 합친 div -->
            <div class="history-body">
            
                <!-- 예매 내역들만 묶은 div -->
                <div class="history-list">

                    <c:choose>
                    	<c:when test="${empty historyList}">
						    <div class="no-history">
						        관람 내역이 존재하지 않습니다.
						    </div>
						</c:when>
							
	                    <c:otherwise>
							<c:forEach var="history" items="${historyList}" varStatus="status">
			                    <!-- 예매 내역 하나의 div -->
			                    <div class="history-item" id="history-item" style="display: ${status.index < 10 ? 'block' : 'none'};">
			                        <div class="box-info">
			                            <div class="box-image">
			                                <a href="detail.mo?movieNo=${history.movieNo}"><img src="${ pageContext.request.contextPath }/resources/images/posters/${ history.fileCodename }" class="poster"></a>
			                            </div>
			                            <div class="history-info">
			                                <div class="title-delete">
			                                    <div>
			                                        <a href="detail.mo?movieNo=${history.movieNo}" class="movie-title">${ history.movieTitle }</a>
			                                    </div>
			                                    <div><button class="history-delete-btn" data-book-no="${history.bookNo}">기록에서 삭제</button></div>
			                                    <input type="hidden" id="userNo" value="${loginUser.userNo}">
			                                </div>
			                                <div class="history-content">
			                                    <p>${ history.playtime }</p>
			                                    <p>${ history.screenName }관 / ${ history.totalTickets }명</p>
			                                    <a class="review-plz" id="detailViewButton" onClick="location.href='detail.mo?movieNo=${history.movieNo}'">이 영화를 평가해주세요</a>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
		                    </c:forEach>
	                    </c:otherwise>
					</c:choose>
                    
                </div>
                
                <div align="center">
		            <button id="btn-more" onclick="more();">더보기</button>
		        </div>
                
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />

    <script>
        
	    let visibleCount = 10; // 현재 표시된 리스트 수 
	
	    // 페이지 로드 시 더보기 버튼 처리
	    document.addEventListener("DOMContentLoaded", () => {
	        const items = document.querySelectorAll(".history-item"); // 모든 카드 선택
	        const btnMore = document.getElementById("btn-more"); // 더보기 버튼 선택
	
	        // 목록이 10개 미만이면 버튼 숨김
	        if (items.length <= visibleCount) {
	            btnMore.style.display = "none"; // 버튼 숨김
	        }
	    });
	
	    /* 더보기 버튼 클릭 시 발생하는 함수 */
	    function more() {
	        const items = document.querySelectorAll(".history-item"); // 모든 카드 선택 
	        let count = 0;
	
	        // 숨겨진 카드 중 10개를 보여줌
	        for (let i = visibleCount; i < items.length; i++) {
	            items[i].style.display = "block";
	            count++;
	
	            if (count === 10) break; // 10개까지만 표시
	        }
	
	        visibleCount += count; // 표시된 카드 수 증가
	
	        // 더 이상 숨겨진 카드가 없으면 버튼 제거
	        if (visibleCount >= items.length) {
	            const btnMore = document.getElementById("btn-more"); // 버튼 선택
	            btnMore.parentNode.removeChild(btnMore); // 버튼 삭제
	        }
	    }
    	
    	var contextPath = '<%= request.getContextPath() %>';
        
    	 $(function () {
             $("#year-btn").click(function () {
                 console.log("클릭됨");
                 
                 const selectedYear = $("#year-select").val(); // 선택된 연도를 가져옴
                 const contextPath = '${pageContext.request.contextPath}'; // 컨텍스트 경로 가져오기
     	        
     	        console.log(selectedYear);
     	        console.log(contextPath);
     	        
     	       if (selectedYear) {
     	            // 선택된 연도로 URL 생성
     	            window.location.href = contextPath + "/history.me?year=" + selectedYear;
     	        } else {
     	            alert("연도를 선택하세요.");
     	        }
     	     
             });
         });
    	 
    	 $(document).on("click", ".history-delete-btn", function () {
   	        const bookNo = $(this).data("book-no");
   	        const userNo = $("#userNo").val(); // 사용자 번호를 숨겨진 input 필드에서 가져오기


   	        if (confirm("해당 영화를 내가 본 영화에서 삭제하시겠습니까?")) {
   	            $.ajax({
   	                url: "deleteHistory.me",
   	                type: "POST",
   	                data: { 
   	                    userNo: userNo, 
   	                    bookNo: bookNo 
   	                },
   	                success: function (response) {
   	                    alert(response);
   	                    if (response.trim() === "내가 본 영화 기록에서 삭제되었습니다.") {
   	                        location.reload(); // 성공 시 페이지 새로고침
   	                    }
   	                },
   	                error: function () {
   	                    alert("삭제 중 오류가 발생했습니다. 다시 시도해주세요.");
   	                }
   	            });
   	        }
   	    });
    	 
    	
    	

    	
    </script>

</body>
</html>