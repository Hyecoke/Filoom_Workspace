<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트목록조회</title>
<style>
    body{
        background-color: black;
    }

    /*전체를 감싸는 영역*/
    .container {
        background-color: #313131;
        box-sizing: border-box;
        margin : auto;
        width : 1900px;
        max-width: 1900px;
        padding : 20px;
        margin-bottom : 30px;
    }

    /*메뉴영역*/
    .menu {
        border-bottom : 2.5px solid #F3F3F3;
        margin-top: 20px;
        padding : 20px;
        color : #F3F3F3;
        font-weight: bold;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    #title {
        font-size: 30px;
        /*border: 1px solid red;*/
    }

    #eventing, #winner, #evented {
        /*border: 1px solid red;*/
        padding: 5px;
        font-size: 20px;
    }

    #winner {
        margin-left: 1185px; 
    }

    #eventing>a, #winner>a, #evented>a {
        text-decoration: none;
        color : #F3F3F3;
    }

    #eventing>a:hover, #winner>a:hover, #evented>a:hover {
        color : #AB886D;;
    }

    /*추천 이벤트 영역*/
    .recommendEventArea {
        display: flex;
        justify-content : center;
        gap : 30px;
        padding: 20px;
        border : 2px solid #F3F3F3;
        border-radius: 4px;
        margin-bottom: 20px;
    }

    .recommendCard {
        width : 40%; 
        height : 100%;
        border-radius: 4px;
        box-shadow: 3px 3px 4px;
        transition-duration: 0.3s; /*0.3초만에 돌아옴*/
        overflow : hidden; /*이미지 넘침 방지*/
     
    }

    .recommendCard:hover {
        cursor: pointer;
        transform: scale(1.05, 1.05); /*가로세로 각각 1.05배씩 확대*/
        transition-duration : 0.5s; /*0.5chehddks*/
    }

    .recommendCard img {
        border-radius: 4px 4px 0 0;
        
    }

    .recommend-card-info {
        display: flex;
        background-color : #F3F3F3;
        color : black;
        font-size: 20px;
        font-weight: bold;
        border-radius: 0 0 4px 4px;
        padding : 20px;
    }

    #recommend-card-title {
        align-self: flex-start;
    }
    #recommend-card-date {
        margin-left : auto;
        font-size: 17px;
        padding : 3px;
        
    }

    /*이벤트별 목록 리스트*/
    .eventTitle-more {
        display: flex;
        justify-content: space-between;
        padding : 20px;
        border-bottom: 2px solid #F3F3F3;
    }

    #statusTitle {
        font-size: 23px;
        color : #F3F3F3;
        font-weight: bold;
    }

    #more>a {
        font-size: 23px;
        color : #F3F3F3;
        font-weight: bold;
    }

    
    #more>a:hover {
        color : #AB886D;
    }

    .card {
        display: flex;
        flex-wrap : wrap; /*줄바꿈 허용*/
        gap : 26px; 
        justify-content : flex-start; /*항상 왼쪽 정렬*/
        align-items : flex-start; /*카드가 왼쪽부터 순차적으로 채워짐*/
        padding: 20px;
    }

    .event-card {
        width : calc(25% - 20px); /*한줄에 4개씩 : 25% 너비에서 간격 계산*/
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 카드 그림자 */
        overflow : hidden; /*이미지 넘침 방지*/
        height : 100%;
    }

    .event-card:hover {
        cursor: pointer;
        transform: scale(1.05, 1.05); /*가로세로 각각 1.05배씩 확대*/
        transition-duration : 0.5s; /*0.5chehddks*/
    }

    .event-card img {
        border-radius: 4px 4px 0 0;
        
    }

    .event-card-info {
        
        background-color : #F3F3F3;
        color : black;
        font-size: 18px;
        font-weight: bold;
        border-radius: 0 0 4px 4px;
        padding : 20px;
    }

    #event-card-title, #event-card-date {
        padding : 5px;
    }

    /*더보기 버튼*/
    #btn-more {
        border-radius: 4px;
        color : #D2CECF;
        font-size: 18px;
        font-weight: bold;
        width : 98%;
        margin-top : 15px;
        border : none;
        height: 40px;
        box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
        background-color: #493628;
        cursor : pointer;
    }
    #btn-more:hover {
    	transform: scale(1.1em); !important;
    }
    
    #btn-more:active {
        background-color: #AB886D;
        color : #493628;
        font-size: 18px;
        font-weight: bold;
        width : 98%;
        margin-top: 15px;
        border : none;
        height: 40px;
        cursor: pointer;
    }


</style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>


    <!--전체 영역을 감싸는 영역-->
    <div class="container">

        <!--메뉴영역-->
        <div class="menu">
            <div id="title">전체 이벤트</div>
            
            <!-- 필터링 영역 -->
            <div id="winner"><a href="${pageContext.request.contextPath}/list.ev">전체 이벤트&emsp;</a>|</div>
            <div id="eventing"><a href="${pageContext.request.contextPath}/list.ev?eventStatus=N">진행중인 이벤트&emsp;</a>|</div>
            <div id="evented"><a href="${pageContext.request.contextPath}/list.ev?eventStatus=Y">지난 이벤트&emsp;</a></div>
            <!--
            <div id="winner"><a href="#">당첨자 발표&emsp;</a>|</div> -->
           
        </div>

        <!-- 추천 이벤트 영역 -->
        <h2 style="color : #F3F3F3; padding: 10px;">✨추천이벤트✨</h2>
        <div class="recommendEventArea">
        	<c:forEach var="event" items="${hotList}" varStatus="status">
        		<c:if test="${status.index < 3 }">
        			<div class="recommendCard">
	                <a href="${pageContext.request.contextPath}/detail.ev?eno=${event.eventNo}" style="text-decoration: none;">
	                    <img src="${pageContext.request.contextPath}${event.contentImg1}" alt="추천이미지" style="width : 100%; height : 300px;">
	                    <div class="recommend-card-info" >
	                        <div id="recommend-card-title">${event.eventTitle }</div>
	                        <div id="recommend-card-date">
	                        	<c:choose>
	                       			<c:when test="${ empty event.startDate and empty event.endDate  }">
	                       				상시진행
	                       			</c:when>
	                       			<c:otherwise>
	                       				${event.startDate }~${event.endDate }
	                       			</c:otherwise>
	                        	</c:choose>
                        	</div>
	                    </div>
	                </a>
	            </div>
        		</c:if>
        	</c:forEach>
        </div>

        <!--이벤트 목록 리스트-->
        <div class="eventTitle-more">
        
        	<!-- 필터링에 따라 제목도 바뀌도록 / 진행중인 이벤트, 전체이벤트, 지난이벤트 -->
            <div id="statusTitle">${statusTitle}</div>
            <c:if test="${sessionScope.loginUser.userNo eq 1 }">
            	<div id="more"><a href="${pageContext.request.contextPath}/enrollForm.ev" style="text-decoration: none;">글작성</a></div>
           	</c:if>
        </div>
        
        <div class="card">
	        <c:forEach var="event" items="${requestScope.list}" varStatus="status">
	            <div class="event-card" id="event-list" style="display: ${status.index < 12 ? 'block' : 'none'};">
	            	<a href="${pageContext.request.contextPath}/detail.ev?eno=${event.eventNo}" style="text-decoration: none;">
	                    <img src="${pageContext.request.contextPath}${event.contentImg1}" alt="이벤트게시글" style="width : 100%; height : 350px;">
	                    <div class="event-card-info" >
	                        <div id="event-card-title">${event.eventTitle}</div>
	                        <div id="event-card-date">
	                       		<c:choose>
	                       			<c:when test="${ empty event.startDate and empty event.endDate  }">
	                       				상시진행
	                       			</c:when>
	                       			<c:otherwise>
	                       				${event.startDate }~${event.endDate } <!--<b class="event-days-remaining" style="color : red;">D-2</b> -->
	                       			</c:otherwise>
	                        	</c:choose>
                        	</div>
	                    </div>
                   </a>
	            </div>
            </c:forEach>
        </div>

        <!--더보기 버튼 -->
        <div align="center">
            <button id="btn-more" onclick="more();">더보기</button>
        </div>

    </div>
    
    <script>
 
    	/* 더보기 버튼 클릭시 발생하는 함수 */
    	let visibleCount = 12; //현재 표시된 리스트 수 
    	
    	function more() {
    		const cards = document.querySelectorAll(".event-card"); // 모든 카드 선택 
    		let count = 0; 
    		
    		// 숨겨진 카드 중 12개를 보여줍니다. 
    		for(let i = visibleCount; i<cards.length; i++) {
    			cards[i].style.display = "block";
    			count++;
    			
    			if(count === 12) break; // 12개까지만 표시
    		}
    		
	   		 visibleCount += count; // 표시된 카드 수 증가
	   		    
	   		// 더 이상 숨겨진 카드가 없으면 버튼 제거
	   	    if (visibleCount >= cards.length) {
	   	        const btnMore = document.getElementById("btn-more"); // 버튼 선택
	   	        btnMore.parentNode.removeChild(btnMore); // 버튼 삭제
	   	    }
    	}
    
    
    </script>

	<jsp:include page="../common/footer.jsp"/>
</body>
</html>