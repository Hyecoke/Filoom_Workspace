<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세조회</title>
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

    /*상세조회 메뉴 영역*/
    .menu {
        display: flex;
        justify-items: left;
        gap : 25px;
        background-color: #E4E0E1;
        height : 55px;
        font-size: 25px;
        font-weight: bold;
        color : #493628;
        padding : 10px;
        border-radius: 4px;
        margin-bottom: 10px;
    }

    #title, #createDate, #count {
        padding: 3px;
    }

    #createDate {
        margin-left: 800px;
    }

    #count {
        margin-left: 60px;
    }

    /*내용, 다음글, 이전글 영역*/
    .content-list {
        border-radius: 4px;
        background-color: #F3F3F3;
    }

    /*내용*/
    #content {
        padding: 10px;
        font-size: 20px;
        font-weight : bold;
        border-bottom: 2.5px solid #493628;
        height : 750px;
        font-weight : bold;

    }

    /*다음글 영역*/
    .nextList {
        display: flex;
        justify-items: left;
        gap : 20px;
        border-bottom: 2.5px solid #493628;
    }

    #next {
        padding: 13px;
        background-color: #E4E0E1;
        font-size: 20px;
        font-weight: bold;
        color : #493628;
        text-align : center;
        width : 150px;
    }

    #next-list {
        padding: 13px;
        font-size: 20px;
        font-weight : bold;
        color : #493628;
    }

    #next-list>a {
        color : #493628;
        text-decoration: none;
    }

    #next-list>a:hover, #next-list>a:active {
        color : #AB886D;
    }

    /*이전글 영역*/
    .beforeList {
        display: flex;
        justify-items: left;
        gap : 20px;
    }

    #before {
        padding: 13px;
        background-color: #E4E0E1;
        font-size: 20px;
        font-weight: bold;
        color : #493628;
        border-radius: 0 0 0 4px;
        text-align : center;
        width : 150px;
    }

    #before-list {
        padding: 13px;
        font-size: 20px;
        font-weight : bold;
        color : #493628;
    }

    #before-list>a {
        color : #493628;
        text-decoration: none;
    }

    #before-list>a:hover, #before-list>a:active {
        color : #AB886D;
    }

    /*목록버튼*/
    #backList, #update, #delete {
        width: 120px;
        height: 40px;
        border: none;
        font-size : 20px;
        border-radius: 5px;
        color: #493628;
        font-size: 20px;
        font-weight: bolder;
        box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
        background-color: #E4E0E1;
        cursor: pointer;
        margin-top : 30px;
    }

    #backList:active, #backList:hover,
    #update:active, #update:hover,
    #delete:active, #delete:hover {
        background-color: #AB886D;
        color : #F3F3F3;
        font-size: 20px;
        font-weight: bold;
        width : 120px;
        margin-top: 30px;
        border : none;
        height: 40px;
        cursor: pointer;
    }


</style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    
    <!--전체영역을 감싸는 container-->
    <div class="container">
        <h2 style="color : #E4E0E1;">공지사항</h2>
        <h3 style="color : #E4E0E1; ">FILOOM의 주요한 이슈 및 여러가지 소식들을 확인할 수 있습니다.</h3>
        <br><br>
        
        <!--공지사항 상세조회 메뉴-->
        <div class="detail-area">
            <div class="menu">
                <div id="title">${n.noticeTitle} </div>
                <div id="createDate">작성일&emsp;${n.createDate }</div>
                <div id="count">조회수&emsp;${n.count }</div>
            </div>

            <div class="content-list">
                <div id="content">
                    ${n.noticeContent }
                </div>
            
                <div class="nextList">  
                    <div id="next">다음글</div>
                    <div id="next-list" >
                    	<c:if test="${not empty nextNotice }">
                    		<a href="${pageContext.request.contextPath}/detail.no?nno=${nextNotice.nextNum }">${nextNotice.nextTitle }</a>
                    	</c:if>
                    	<c:if test="${empty nextNotice.nextNum }">
                    		다음 글이 없습니다.
                    	</c:if>
                   	</div>
                </div>
                <div class="beforeList">  
                    <div id="before">이전글</div>
                    <div id="before-list">
                    	<c:if test="${not empty prevNotice }">
                    		<a href="${pageContext.request.contextPath}/detail.no?nno=${prevNotice.prevNum }">${prevNotice.prevTitle}</a>
                    	</c:if>
                    	<c:if test="${empty prevNotice.prevNum }">
                    		이전 글이 없습니다. 
                    	</c:if>
                   	</div>
                </div>
            
            </div>

        </div>
        
        	<form id="postForm" action="" method="post">
            	<input type="hidden" name="nno" value="${requestScope.n.noticeNo }">
            </form> 

			<div class="btn" align="center">
		        <button id="backList" onclick="history.back();">목록</button>
		        
		        <c:if test="${sessionScope.loginUser.userNo eq 1 }" >
	               	<button id="update" style="width : 130px; margin-right : 5px;" onclick="postFormSubmit(1);">수정</button>
	               	<button id="delete" style="width : 130px;" onclick="postFormSubmit(2);">삭제</button>	
                </c:if>
		    </div>
            
        </div>
        
        <script>
	        function postFormSubmit(num) {
	            console.log(num);
	
	            // num이 1일 경우 수정페이지 요청
	            if (num === 1) {
	                $("#postForm").attr("action", "updateForm.no").submit();
	            } 
	            // num이 2일 경우 삭제 요청
	            else if (num === 2) {
	                // 삭제 전 확인 메시지
	                var confirmDelete = confirm("정말로 삭제하시겠습니까?");
	                if (confirmDelete) {
	                    // 사용자가 '확인'을 클릭하면 삭제 요청 폼 제출
	                    $("#postForm").attr("action", "${pageContext.request.contextPath}/delete.no").submit();
	                } else {
	                    // 사용자가 '취소'를 클릭하면 아무 일도 하지 않음
	                    return false;
	                }
	            }
	        }
        </script>


    <jsp:include page="../common/footer.jsp" />
</body>
</html>