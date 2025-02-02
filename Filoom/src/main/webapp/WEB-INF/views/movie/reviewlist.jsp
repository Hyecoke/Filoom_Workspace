<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
			<input type="hidden" id="first" value="${requestScope.pi.startPage}">
			<input type="hidden" id="last" value="${requestScope.pi.endPage}">
			<input type="hidden" id="MX" value="${requestScope.pi.maxPage}">
			
            <c:forEach var="rev" items="${list}">
            	<div id="review">
                	<!-- full id = 'tenletterstunman' -->
                    <div style="display:flex; justify-content: space-between;">
                   	<!-- MEMBER 테이블에 닉네임 개념이 따로 없어 아이디만을 사용함 -->
                   		<div id="reviewerName">${rev.userId}</div>
                    	<div id="writtenDate">${rev.reviewDate}</div>
						<c:if test="${rev.userNo eq sessionScope.loginUser.userNo}">
						<a class="edit-modal-btn" data-target="modifyModal"
							data-review-id="${rev.reviewId}" data-score="${rev.score}" id="modifyReview">수정</a>
						<button id="deleteButton" style="background-color: red; color:white;" onclick="deleteReview(${rev.reviewId});">
							<img src="resources/images/icons/dash-lg.svg" id="minus">
	                    </button>
                       </c:if>
                   </div>
					<label style='display:none;'>${rev.isWatched}</label>
					<label style='display:none;'>${rev.reviewId}</label>
                    <table>
                        <tr>
                            <td width="50">제목</td>
                            <td>${rev.reviewTitle}</td>
                        </tr>
                        <tr>
                            <td>평점</td>
                            <td>
                            	<c:set var="emptyStar" value="${5 - rev.score}" />
                            	<c:forEach var="s" begin="1" end="${rev.score}">
                            		★
                            	</c:forEach>
                            	
                            	<c:forEach var="s" begin="1" end="${emptyStar}">
                            		☆
                            	</c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td>${rev.reviewContent}</td>
                        </tr>
                    </table>
                </div>
            </c:forEach>
            
            
            
            
</body>
</html>