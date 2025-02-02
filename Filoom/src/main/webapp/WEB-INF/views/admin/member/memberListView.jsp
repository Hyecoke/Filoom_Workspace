<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	body{
	    width: 100%;
	    height: 100%;
	    background-color: #151515;
	    overflow: hidden;
	    box-sizing: border-box;
	}
	
	#admin_content{
	
	    width: 1850px;
	    height: 900px;
	    margin: auto;
	    margin-top: 30px;
	    background-color: #313131;
	    border-radius: 5px;
	    box-shadow: 4px 4px#151515 ;
	
	}
	    
	#admin_right{
	
	    width: 80%;
	    height: 100%;
	    /*background-color: rgb(100, 76, 47);*/
	    float: left;
	
	}
	
	#admin_title{
	    width: 100%;
	    height: 15%;
	    /*background-color: #4b8492;*/
	    position: relative;
	}
	
	#admin_title_content{
	    position: absolute;
	    left: 50%;
	    right:  50%; 
	    transform: translate(-50%, 40%);
	    width: 98%;
	    height: 60%;
	    background-color: #E4E0E1;
	    border-radius: 5px;
	}
	
	#admin_detail{
	    width: 100%;
	    height: 85%;
	    /*background-color: aquamarine;*/
	    position: relative;
	}
	
	#admin_page{
	    position: absolute;
	    left: 50%;
	    right:  50%; 
	    transform: translate(-50%, 0%);
	    width: 98%;
	    height: 95%;
	    background-color: #E4E0E1;
	    border-radius: 5px;
	}
	
	
	/*여기 샘플코드*/
	#text_sample{
	    width: 100px;
	    height: 30px;
	    border: none;
	    border-radius: 5px;
	    box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
	    outline: none;
	}
	
	#button_sample {
	    width: 100px;
	    height: 40px;
	    border: none;
	    border-radius: 5px;
	    color: #D2CECF;
	    font-size: 20px;
	    font-weight: bolder;
	    box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
	    background-color: #493628;
	    cursor: pointer;
	}
	
	#button_sample:hover {
	    transform: scale(1.1em);
	}
	
	#button_sample:active {
	    background-color: #AB886D;
	}
	
	/****************************************/

	/* listHeader와 memberItem을 동일한 레이아웃으로 */
.listHeader {
    display: flex;
    justify-content: space-between; /* 각 칼럼을 균등하게 배치 */
    background-color: #E4E0E1;
    padding: 27px 20px; /* 상하/좌우 여백 */
    font-weight: bold;
    font-size: 20px;
    color: #333;
    border-radius: 5px; /* 모서리 둥글게 */
    box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
    margin-bottom: 10px; /* 리스트와 간격 */
}

.listColumn,
.memberInfo > div {
    flex: 1; /* 모든 칼럼이 동일한 폭 */
    text-align: center; /* 가운데 정렬 */
    white-space: nowrap; /* 텍스트 한 줄 유지 */
    overflow: hidden; /* 넘치는 텍스트 숨기기 */
    text-overflow: ellipsis; /* ...으로 표시 */
}






	
	.memberList {
		list-style: none;
		padding: 0;
		margin: 0;
	}

	.memberItem {
		background-color: #E4E0E1;
		border-radius: 5px;
		margin: 10px 0;
		padding: 15px 20px;
		box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
		cursor: pointer;
		transition: transform 0.2s ease, box-shadow 0.2s ease;
	}

	.memberItem:hover {
		transform: scale(1.02);
		box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.3);
	}

	.memberInfo {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.userNo, .userId, .userName, .status {
		font-size: 18px;
		color: #333;
		font-weight: bold;
		margin: 5px 0;
	}

	/* 기본 상태 스타일 */
	.memberItem .status {
	    color: #333; /* 기본 색상 */
	}
	
	/* Y인 경우 파란색 */
	.memberItem[data-status="Y"] .status {
	    color: #007BFF;
	}
	
	/* N인 경우 빨간색 */
	.memberItem[data-status="N"] .status {
	    color: #FF4D4D;
	}








	/* 페이징바 스타일 */
    .paging-bar {
	    display: flex;
	    justify-content: center;
	    list-style: none;
	    padding: 0;
	    margin: 20px 0;
	}
	
	.active, .non-active {
	    margin: 0px 8px;
	    display: inline-block;
	    padding: 1px 10px;
	    border: none;
	    background-color: #ffffff00;
	    cursor: pointer;
	    color: #999;
        font-weight: 300;
        font-size: 18px;
	}
	
	.prev-next {
		margin: 0px 8px;
	    display: inline-block;
	    padding: 1px 10px;
	    border: none;
	    background-color: #ffffff00;
	    cursor: pointer;
	    color: black;
        font-weight: 300;
        font-size: 18px;
	}
	
	.active:hover, .non-active:hover {
	    color: #222;
        border-bottom: 1px solid #333;
	}
	
	.paging-bar .active {
	    font-weight: bold;
	    color: black;
	}
	
	.search-area {
		text-align: right;
		margin: 25px 30px 0 0;
	}
	
	.search-box {
		padding: 10px;
		width: 200px;
		font-size: 16px;
	    height: 20px;
	    border: none;
	    border-radius: 5px;
	    box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
	    outline: none;
	}
	
	.search-btn {
		padding: 10px 15px;
	    border: none;
	    border-radius: 5px;
	    color: #D2CECF;
	    font-weight: bolder;
	    box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
	    background-color: #493628;
	    cursor: pointer;
	}
	
	.filter-status {
		color: black;
		text-decoration: none;
	}
	
	
	
	
	
	/* 모달 */
	/* 모달 배경 */
	.modal {
	    display: none; /* 기본적으로 숨김 */
	    position: fixed;
	    z-index: 1000;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    background-color: rgba(0, 0, 0, 0.6);
	}
	
	.modal-content {
	    position: absolute; /* 부모 요소 기준 중앙 정렬 */
	    top: 50%; 
	    left: 50%;
	    transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	    background-color: #fff;
	    color: #000;
	    padding: 40px;
	    border-radius: 10px;
	    width: 30%; /* 원하는 너비로 설정 */
	    max-width: 600px; /* 최대 너비 설정 */
	    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	}
	
	.modal-content h2 {
		margin: 0;
		margin-bottom: 30px;
	}
	
	/* 닫기 버튼 */
	.close-btn {
	    position: absolute;
	    top: 10px;
	    right: 15px;
	    font-size: 24px;
	    font-weight: bold;
	    color: #333;
	    cursor: pointer;
	}
	
	/* 닫기 버튼 호버 */
	.close-btn:hover {
	    color: #FF4D4D;
	}
	
	/* 모달 내용 스타일 */
	.modal-details p {
	    font-size: 16px;
	    color: #333;
	    margin: 20px 0;
	}
	
	.modal-details p strong {
	    color: #007BFF;
	}
	
	/* 모달 하단 버튼 */
	.modal-actions {
	    margin-top: 40px;
	    text-align: center;
	}
	
	.modal-actions button {
	    padding: 10px 20px;
	    font-size: 16px;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	    color: #fff;
	    transition: background-color 0.3s ease;
	}
	
	.activate-btn {
	    background-color: #28a745; /* 초록색 */
	}
	
	.activate-btn:hover {
	    background-color: #218838;
	}
	
	.deactivate-btn {
	    background-color: #dc3545; /* 빨간색 */
	}
	
	.deactivate-btn:hover {
	    background-color: #c82333;
	}
	
	
</style>
</head>
<body>

	<div id = "admin_content">
        
        <jsp:include page="../../common/adminHeader.jsp" />	
        
        <div id = "admin_right">
            <div id ="admin_title">
                <!-- 여기가 관리자 상단 회원번호, 회원아이디 이런거 적는 곳
                    구상은 각자 알아서~ 
                -->
                <div id="admin_title_content">
					<div class="listHeader">
						<div class="listColumn">회원번호</div>
						<div class="listColumn">아이디</div>
						<div class="listColumn">이름</div>
						<div class="listColumn">계정 생성일</div>
						<div class="listColumn">
						    <c:choose>
						        <c:when test="${status == 'N'}">
						            <a href="${pageContext.request.contextPath}/memberList_ad.me?status=Y" class="filter-status">비활성화</a>
						        </c:when>
						        <c:otherwise>
						            <a href="${pageContext.request.contextPath}/memberList_ad.me?status=N" class="filter-status">활성화</a>
						        </c:otherwise>
						    </c:choose>
						</div>
					</div>
				</div>
            </div>

            <div id="admin_detail">
				<div id="admin_page">
					<ul class="memberList">

						<c:forEach var="member" items="${ memberList }">
							<li class="memberItem" data-status="${member.status}">
								<div class="memberInfo">
									<div class="userNo">${ member.userNo }</div>
									<div class="userId">${ member.userId }</div>
									<div class="userName">${ member.userName }</div>
									<div class="userName">${ member.enrollDate }</div>
									<div class="status">${ member.status }</div>
									<input type="hidden" value="${ member.birth }">
									<input type="hidden" value="${ member.email }">
									<input type="hidden" value="${ member.gender }">
								</div>
							</li>
						</c:forEach>
					</ul>
					
					<!-- 모달 HTML -->
					<div id="memberModal" class="modal">
					    <div class="modal-content">
					        <span class="close-btn">&times;</span>
					        <h2>회원 상세 정보</h2>
					        <div class="modal-details">
					            <p><strong>회원번호:</strong> <span id="modal-userNo"></span></p>
					            <p><strong>아이디:</strong> <span id="modal-userId"></span></p>
					            <p><strong>이름:</strong> <span id="modal-userName"></span></p>
					            <p><strong>생년월일:</strong> <span id="modal-birth"></span></p>
					            <p><strong>이메일:</strong> <span id="modal-email"></span></p>
					            <p><strong>성별:</strong> <span id="modal-gender"></span></p>
					            <p><strong>활성화 여부:</strong> <span id="modal-status"></span></p>
					            <p><strong>회원가입일:</strong> <span id="modal-enrollDate"></span></p>
					        </div>
					        <div class="modal-actions"></div>
					    </div>
					</div>

					<div class="search-area">
					    <form action="${pageContext.request.contextPath}/memberList_ad.me" method="get">
					        <input type="text" class="search-box" name="keyword" placeholder="아이디로 검색"
					               value="${keyword != null ? keyword : ''}">
					        <button type="submit" class="search-btn">검색</button>
					        <!--  
                    <input type ="text" id ="text_sample">
                    <input type="button" id ="button_sample" value="샘플">
               		-->
					    </form>
					</div>

					<!-- 진짜 김다훈이 존나 힘들게 만든 페이징바 -->
					<div align="center" class="paging-bar">
					
					    <!-- << 버튼 -->
						<c:if test="${pi.currentPage > pi.pageLimit}">
						    <button onclick="location.href = '${pageContext.request.contextPath}/memberList_ad.me?cpage=1&status=${status}&keyword=${keyword}';" class="prev-next">
						        &lt;&lt;
						    </button>
						</c:if>
						
						<!-- < 버튼 -->
						<c:if test="${pi.currentPage > pi.pageLimit}">
						    <button onclick="location.href = '${pageContext.request.contextPath}/memberList_ad.me?cpage=${pi.startPage - 1}&status=${status}&keyword=${keyword}';" class="prev-next">
						        &lt;
						    </button>
						</c:if>
						
						<!-- 페이지 번호 -->
						<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
						    <c:choose>
						        <c:when test="${p != pi.currentPage}">
						            <button onclick="location.href = '${pageContext.request.contextPath}/memberList_ad.me?cpage=${p}&status=${status}&keyword=${keyword}';" class="non-active">
						                ${p}
						            </button>
						        </c:when>
						        <c:otherwise>
						            <button class="active">
						                ${p}
						            </button>
						        </c:otherwise>
						    </c:choose>
						</c:forEach>
						
						<!-- > 버튼 -->
						<c:if test="${pi.currentPage < pi.maxPage && pi.endPage < pi.maxPage}">
						    <button onclick="location.href = '${pageContext.request.contextPath}/memberList_ad.me?cpage=${pi.endPage + 1}&status=${status}&keyword=${keyword}';" class="prev-next">
						        &gt;
						    </button>
						</c:if>
						
						<!-- >> 버튼 -->
						<c:if test="${pi.currentPage < pi.maxPage && pi.endPage < pi.maxPage}">
						    <button onclick="location.href = '${pageContext.request.contextPath}/memberList_ad.me?cpage=${pi.maxPage}&status=${status}&keyword=${keyword}';" class="prev-next">
						        &gt;&gt;
						    </button>
						</c:if>
					
					</div>
				</div>
			</div>
        </div>
    </div>
    
    <script>
	    $(document).ready(function () {
	        // 모달 열기
	        $(".memberItem").on("click", function () {
	            const userNo = $(this).find(".userNo").text().trim();
	            const userId = $(this).find(".userId").text().trim();
	            const userName = $(this).find(".userName").eq(0).text().trim();
	            const enrollDate = $(this).find(".userName").eq(1).text().trim();
	            const birthRaw = $(this).find("input[value][type='hidden']").eq(0).val();
	            const email = $(this).find("input[value][type='hidden']").eq(1).val();
	            const genderRaw = $(this).find("input[value][type='hidden']").eq(2).val();
	            const status = $(this).find(".status").text().trim();
	
	            let gender = genderRaw === "M" ? "남성" : genderRaw === "F" ? "여성" : "선택 안함";
	            const birth = birthRaw.replace(/(\d{4})(\d{2})(\d{2})/, "$1-$2-$3");
	
	            $("#modal-userNo").text(userNo);
	            $("#modal-userId").text(userId);
	            $("#modal-userName").text(userName);
	            $("#modal-birth").text(birth);
	            $("#modal-email").text(email || "등록되지 않음");
	            $("#modal-gender").text(gender);
	            $("#modal-status").text(status);
	            $("#modal-enrollDate").text(enrollDate);
	
	            const actionButtons = status === "N" 
	                ? '<button class="activate-btn">활성화</button>'
	                : '<button class="deactivate-btn">비활성화</button>';
	
	            $(".modal-actions").html(actionButtons);
	
	            $("#memberModal").fadeIn(100);
	
	            // 버튼 클릭 이벤트
	            $(".activate-btn").on("click", function () {
	                updateStatus(userNo, "Y");
	            });
	
	            $(".deactivate-btn").on("click", function () {
	                updateStatus(userNo, "N");
	            });
	        });
	
	        $(".close-btn").on("click", function () {
	            $("#memberModal").fadeOut(200);
	        });
	
	        $(window).on("click", function (event) {
	            if ($(event.target).is("#memberModal")) {
	                $("#memberModal").fadeOut(200);
	            }
	        });
	
	        // 상태 업데이트 함수
	        function updateStatus(userNo, newStatus) {
	            const confirmationMessage = newStatus === "Y" 
	                ? "활성화 하시겠습니까?" 
	                : "비활성화 하시겠습니까?";
	            if (confirm(confirmationMessage)) {
	                $.ajax({
	                    url: "/filoom/updateStatus.me",
	                    type: "POST",
	                    data: { userNo, status: newStatus },
	                    success: function (response) {
	                        const successMessage = newStatus === "Y" 
	                            ? "활성화 되었습니다." 
	                            : "비활성화 되었습니다.";
	                        alert(successMessage);
	                        $("#memberModal").fadeOut();
	                        location.reload(); // 상태 업데이트 후 페이지 새로고침
	                    },
	                    error: function () {
	                        alert("상태 변경에 실패했습니다. 다시 시도해주세요.");
	                    }
	                });
	            }
	        }
	    });

	</script>

    

</body>
</html>