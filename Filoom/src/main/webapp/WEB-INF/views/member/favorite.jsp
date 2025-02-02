<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보고싶은 영화 조회</title>
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
	
	.favorite-header{
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    border-bottom: 1px solid #333;
	    margin-bottom: 30px;
	    padding-bottom: 10px;
	}
	
	.favorite-num {
	    display: flex;
	    justify-content: space-between;
	}
	
	.favorite-num h1 {
	    font-size: 24px;
	    font-weight: bold;
	}
	
	.favorite-num span {
	    font-size: 24px;
	    margin-left: 12px;
	    color: #aaa;
	}
	
	.favorite-list {
	    padding: 10px 20px;
	    display: grid; /* flex 대신 grid를 사용 */
	    grid-template-columns: repeat(3, 1fr); /* 한 줄에 3개 */
	    gap: 30px; /* 요소 간의 간격 */
	    justify-items: center; /* 가운데 정렬 */
	}
	
	.favorite-item {
	    width: 100%; /* 부모 컨테이너에 맞춤 */
	    max-width: 185px; /* 포스터 가로 크기에 맞춤 */
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
	
	#year-btn:hover, .reserve-btn:hover {
		background-color: #8b5a2b;
	}
	/* 
	.favorite-item {
	    margin-bottom: 30px;
	} */
	
	.box-image {
	    margin-bottom: 14px;
	    /* background-color: white; */
	}
	
	
	.poster {
	    width: 185px;
	    height: 261px;
	    object-fit: cover; /* 이미지 비율 유지하며 잘림 방지 */
	}
	
	.movie-title {
	    display: block;
	    font-size: 16px; /* 제목 폰트 크기 */
	    font-weight: bold;
	    color: #fff;
	    margin-top: 8px;
	    text-decoration: none;
	    overflow: hidden; /* 넘치는 텍스트 숨기기 */
	    text-overflow: ellipsis; /* ... 표시 */
	    white-space: nowrap; /* 한 줄로 유지 */
	    max-width: 185px; /* 포스터의 가로 크기와 동일하게 */
	}
	
	.release-date {
	    font-size: 12px;
	    color: #aaa;
	    margin-top: 4px;
	}
	
	.reserve-btn {
	    margin-top: 10px;
	    padding: 2px 10px;
	    border: 1px solid #333;
	    border-radius: 5px;
	    background-color: #493628;
	    color: #ffffff;
	    font-size: 12px;
	    line-height: 1.5; /* 동일한 라인 높이 */
	    box-sizing: border-box; /* 박스 모델 통일 */
	    cursor: pointer;
	}
	
	.delete-btn {
	    margin-left: 10px;
	    background-color: #49362800;
	    color: #aaa;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    font-size: 12px;
	    font-weight: 600;
	    transition: color 0.3s ease;
	}
	
	.delete-btn:hover {
		color: #ffffff;
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
	
	.no-favorite {
		padding: 10px 0 100px 0;
		text-align: center;
		font-size: 20px;
		/* font-weight: bold; */
    	color: #aaa;
	}
	
	.favorite-list.no-items {
	    display: flex; /* flex로 변경 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	    text-align: center;
	    grid-template-columns: none; /* grid 설정 무효화 */
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
                <li><a href="history.me">내가 본 영화 조회</a></li>
                <li class="active"><a href="favorite.me">보고 싶은 영화 조회</a></li>
                <li><a href="review.me">내가 쓴 리뷰 조회</a></li>
            </ul>
        </div>
        <div class="mypage-content">
            <div class="favorite-header">
                
                <div class="favorite-num">
                    <h1>보고싶은 영화</h1>
                    <span>${favoriteList.size()}건</span>
                </div>

                <div class="year-search">
                    <select name="sort" id="year-select">
                        <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>개봉일 오름차순</option>
                        <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>개봉일 내림차순</option>
                    </select>
                    <button type="button" id="year-btn">검색</button>
                </div>
            </div>

            <div class="favorite-body">

                <div class="favorite-list ${empty favoriteList ? 'no-items' : ''}">
                
                	<c:choose>
	                	<c:when test="${empty favoriteList}">
						    <div class="no-favorite">
						        보고싶은 영화 목록이 없습니다.
						    </div>
						</c:when>
					
						<c:otherwise>
							<c:forEach var="favorite" items="${favoriteList}" varStatus="status">
	
			                    <div class="favorite-item" id="favorite-item" style="display: ${status.index < 15 ? 'block' : 'none'};">
			                        <div class="box-image">
			                            <a href="detail.mo?movieNo=${favorite.movieNo}"><img src="${ pageContext.request.contextPath }/resources/images/posters/${ favorite.fileCodename }" class="poster"></a>
			                        </div>
			                        <div class="box-content">
			                            <div>
			                                <a href="detail.mo?movieNo=${favorite.movieNo}" class="movie-title">${ favorite.movieTitle }</a>
			                                <p class="release-date">${ favorite.openDate } 개봉</p>
			                                <div class="reserve-delete">
			                                    <button  id="detailViewButton" class="reserve-btn" onClick="location.href='detail.mo?movieNo=${favorite.movieNo}'">예매하기</button>
			                                    <button class="delete-btn" data-movie-no="${favorite.movieNo}">삭제</button>
			                                    <input type="hidden" id="userNo" value="${loginUser.userNo}">
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
    
	    let visibleCount = 15; // 현재 표시된 리스트 수 
		
	    // 페이지 로드 시 더보기 버튼 처리
	    document.addEventListener("DOMContentLoaded", () => {
	        const items = document.querySelectorAll(".favorite-item"); // 모든 카드 선택
	        const btnMore = document.getElementById("btn-more"); // 더보기 버튼 선택
	
	        // 목록이 10개 미만이면 버튼 숨김
	        if (items.length <= visibleCount) {
	            btnMore.style.display = "none"; // 버튼 숨김
	        }
	    });
	
	    /* 더보기 버튼 클릭 시 발생하는 함수 */
	    function more() {
	        const items = document.querySelectorAll(".favorite-item"); // 모든 카드 선택 
	        let count = 0;
	
	        // 숨겨진 카드 중 10개를 보여줌
	        for (let i = visibleCount; i < items.length; i++) {
	            items[i].style.display = "block";
	            count++;
	
	            if (count === 15) break; // 10개까지만 표시
	        }
	
	        visibleCount += count; // 표시된 카드 수 증가
	
	        // 더 이상 숨겨진 카드가 없으면 버튼 제거
	        if (visibleCount >= items.length) {
	            const btnMore = document.getElementById("btn-more"); // 버튼 선택
	            btnMore.parentNode.removeChild(btnMore); // 버튼 삭제
	        }
	    }
    
	    $(document).on("click", ".delete-btn", function () {
	        const movieNo = $(this).data("movie-no");
	        const userNo = $("#userNo").val(); // 사용자 번호를 숨겨진 input 필드에서 가져오기
	
	        if (!userNo) {
	            alert("사용자 정보가 없습니다. 다시 로그인해주세요.");
	            return;
	        }
	
	        if (confirm("해당 영화를 보고싶은 영화에서 삭제하시겠습니까?")) {
	            $.ajax({
	                url: "deleteFavorite.me",
	                type: "POST",
	                data: { 
	                    userNo: userNo, 
	                    movieNo: movieNo 
	                },
	                success: function (response) {
	                    alert(response);
	                    if (response === "보고싶은 영화에서 삭제되었습니다.") {
	                        location.reload(); // 성공 시 페이지 새로고침
	                    }
	                },
	                error: function () {
	                    alert("삭제 중 오류가 발생했습니다. 다시 시도해주세요.");
	                }
	            });
	        }
	    });
	    
	    $(document).ready(function () {
	        $('#year-btn').on('click', function () {
	            const sort = $('#year-select').val();

	            var contextPath = '${pageContext.request.contextPath}';
	            
	            location.href = contextPath + "/favorite.me?sort=" + sort;
	        });
	    });


	</script>


</body>
</html>