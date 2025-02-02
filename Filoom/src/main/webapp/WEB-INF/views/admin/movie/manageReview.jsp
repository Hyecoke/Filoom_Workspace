<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 관리:: Filoom</title>
    <link rel="stylesheet" href="resources/css/admin.css" />
    
	<!-- jQuery 연동 구문 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        #admin_title_content {
            font-size:25px;
            display:flex;
            justify-content: space-between;
            color:#493628;
        }
        #goBack:hover {
            cursor:pointer;
        }

        #admin_page {
            overflow: auto;
        }

        #reviewList {
            padding: 0px 45px;
        }
        #review {
            background-color: rgba(243,243,243,0.8);
            color:black;
            border-radius:5px;
            border:1px solid black;

            padding: 10px 35px;
            margin-bottom:60px;
            font-size:20px;
        }
        
        #minus {
        	filter: invert(100%) sepia(1%) saturate(0%) hue-rotate(151deg) brightness(105%) contrast(102%);
        }

		#deleteButton:hover {
			cursor:pointer;		
		}

        /* 페이징바 */
        .pagingbar {
            margin-bottom:10px;
        }

        .pagingbar button {
            border:0;
            background-color: transparent;
/*             color:white; */
            font-size:32px;
            font-weight:lighter;
        }

        .pagingbar button:hover {
            transform: scale(1.1);
            font-weight: normal;
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
                <div id = "admin_title_content">
                    <p id="fnName" style="padding-left:33px; font-weight:bold;">리뷰 관리 | ${requestScope.information.movieTitle}</p>
                    <p id="goBack" style="padding-right:33px;"
                        onclick="location.href='movielist_ad.mo';">
                        ← 목록으로 돌아가기
                    </p>

                </div>

            </div>

            <div id = "admin_detail">
                
                <!-- 여기 안이 관리자 컨텐츠 영역이에요~-->
                <div id ="admin_page">

                    <p style="font-size:20px; padding-left:45px;">
                    	<b>${10 * (requestScope.pi.currentPage - 1) + 1} - ${10 * requestScope.pi.currentPage < requestScope.pi.listCount ? 10 * requestScope.pi.currentPage : requestScope.pi.listCount}</b> 번째 리뷰 / 총 <b>${requestScope.pi.listCount}</b> 개</p>
                    <!-- startNum ~ endNum, 총 reviewCount 개 -->

					<input type="hidden" id="mno" value="${requestScope.information.movieNo}">
                    <div id="reviewList">
                    	<c:choose>
	                    	<c:when test="${empty requestScope.list }">
	                    		<div align="center">
	                    		<img src="resources/images/icons/projector-128px.svg" class="box-is-empty">
			            		<br>남겨진 리뷰가 없습니다.
			            		</div>
	                    	</c:when>
                    		<c:otherwise>
		                    	<c:forEach var="p" items="${requestScope.list}">
		                    		<div id="review">
			                            <div style="display:flex; justify-content: space-between;">
			                            	<!-- MEMBER 테이블에 닉네임 개념이 따로 없어 아이디만을 사용함 -->
			                            	<div id="reviewerName">${p.userId}</div>
			                                <div id="writtenDate">${p.reviewDate}</div>
			                                <button id="deleteButton" style="background-color: red; color:white;" onclick="forceDeleteReview(${p.reviewId});">
			                                    <img src="resources/images/icons/dash-lg.svg" id="minus">
			                                </button>
			                            </div>
			                            
			                            <table>
			                                <tr>
			                                    <td width="50">제목</td>
			                                    <td><b>${p.reviewTitle}</b></td>
			                                </tr>
			                                <tr>
			                                    <td>평점</td>
			                                    <td>
													<c:set var="emptyStar" value="${5 - p.score}" />
					                            	<c:forEach var="s" begin="1" end="${p.score}">
					                            		★
					                            	</c:forEach>
					                            	
					                            	<c:forEach var="s" begin="1" end="${emptyStar}">
					                            		☆
					                            	</c:forEach>
												</td>
			                                </tr>
			                                <tr>
			                                    <td>내용</td>
			                                    <td>${p.reviewContent}</td>
			                                </tr>
			                            </table>
			                        </div>
		                    	</c:forEach>
	                    	</c:otherwise>
                    	</c:choose>
                    	
                    </div>
                    
                    <div class="pagingbar" align="center">
                    	
                    	<!-- if i > 1 -->
                        <c:if test="${ requestScope.pi.currentPage gt 1 }">
	                        <button onclick="location.href = 'admin.managereview.mo?mno=admin.managereview.mo?movieNo=${requestScope.information.movieNo}&cpage=1';">&lt;&lt;</button> <!-- to Page1 -->
	                        <button onclick="location.href = 'admin.managereview.mo?mno=admin.managereview.mo?movieNo=${requestScope.information.movieNo}&cpage=${requestScope.pi.currentPage - 1}';">&lt;</button> <!-- prev -->
                        </c:if>
                        
                    	<!-- if 3 ≤ i ≤ maxPage-2, for i in range (currentPage -2 ~ +2) -->
	                    <c:forEach var="p" begin="${requestScope.pi.startPage}" end="${requestScope.pi.endPage}">
	                    	<c:choose>
	                    	<c:when test="${p eq requestScope.pi.currentPage }">
		                    		<button disabled style='font-weight: normal;'>${p}</button>
	                    	</c:when>
		                    		
	                    	<c:otherwise>
	                    		<button onclick="location.href = 'admin.managereview.mo?mno=admin.managereview.mo?movieNo=${requestScope.information.movieNo}&cpage=1';">${p}</button>
	                    	</c:otherwise>
	                    	</c:choose>
	                    </c:forEach>
                    
                    	<!--  if i < maxPage -->
                    	<c:if test="${ requestScope.pi.currentPage lt requestScope.pi.maxPage }">
	                        <button onclick="location.href = 'admin.managereview.mo?mno=admin.managereview.mo?movieNo=${requestScope.information.movieNo}&cpage=${requestScope.pi.currentPage + 1}';">&gt;</button> <!-- next -->    
	                        <button onclick="location.href = 'admin.managereview.mo?mno=admin.managereview.mo?movieNo=${requestScope.information.movieNo}&cpage=${requestScope.pi.maxPage}';">&gt;&gt;</button> <!-- to LastPage -->
                        </c:if>
                	</div>
                	
                </div>
            </div>
        </div>
    </div>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const navItems = document.querySelectorAll("#nav > ul > li");
    
        navItems.forEach(item => {
            item.addEventListener("click", function () {
                // 모든 항목에서 selected 클래스 제거
                navItems.forEach(nav => nav.classList.remove("selected"));
    
                // 클릭된 항목에 selected 클래스 추가
                this.classList.add("selected");
            });
        });
    });
    
    function forceDeleteReview(rid) {
    	let mno=$("#mno").val();
    	$.ajax({
    		url:'admin.f_delrv.mo?rid='+rid,
    		type:"post",
    		data:{"rid" : rid},
    		
    		success:function(result) {
    			if(result == "success") {
    				alert("리뷰가 삭제되었습니다.");
    				location.href="admin.managereview.mo?mno="+mno;
    			} else {
    				alert("리뷰가 삭제되지 않았습니다.");
    			}
    		},
    		error:function() {
    			alert("An error has occurred.");
    		}
    	});
    }

    </script>
    
</body>
</html>