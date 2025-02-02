<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록조회</title>
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
	    /*padding : 20px;*/
	    padding : 20px;
	}
	
	/*목록조회 메뉴 영역*/
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
	
	#no, #title, #createDate, #count {
	    padding: 3px;
	}
	
	#no {
	    margin-left: 55px;
	}
	
	#title {
	    margin-left: 40px;
	}
	
	#createDate {
	    margin-left: 1180px;
	}
	
	#count {
	    margin-left: 175px;
	}
	
	/*목록 테이블을 감싸는 div*/
	.list-area {
	    border-radius : 4px;
	    overflow: hidden;
	}
	
	/*목록 테이블*/
	.noticeList {
	    width : 100%;
	    border-collapse : collapse;
	    overflow: hidden;
	}
	
	#nNo, #nCount {
	    width : 10%;
	}
	
	#nTitle {
	    width : 60%;
	}
	#nTitle:hover {
		cursor:pointer;
	}
	
	#nCreateDate {
	    width : 20%;
	}
	
	/*목록영역*/
	.list {
	    background-color: #F3F3F3;
	    border-bottom : 2px solid #493628;
	    text-align : center;
	    font-weight: bold;
	    height : 60px;
	    font-size: 20px;
	}
	.list:hover {
	    background-color: #E4E0E1;
	    border-bottom : 2px solid #493628;
	    text-align : center;
	    font-weight: bold;
	    height : 60px;
	}
	
	#ntitle {
	    cursor : pointer;
	}
	
	/*페이징영역*/
        
	.foot {
	 	box-sizing : border-box;
	 	display: flex;
	 	justify-content: center;
	 	align-items : center;
	 	flex-direction: column;
	 	position: relative;
	
	}
       
	.pagingArea {
	    display: flex;
	    justify-content: center;
	    padding : 20px;
	    font-size: 20px;
	    font-weight: bold;
	
	}
	.pagination {
	    list-style-type : none;
	    display: flex;
	    padding : 0;
	    margin: 0;
	    font-size: 20px;
	    font-weight: bold;
	}
	.pagination>li {
	    margin : 0 10px; /*리스트 항목 간의 간격*/
	    cursor: pointer;
	    transition: color 0.3s ease; /*색상 전환 효과*/
	    font-size: 25px;
	    font-weight: bold;
	    color : #F3F3F3;
	}
	
	.pagination>li>a {
	    margin : 0 10px; /*리스트 항목 간의 간격*/
	    cursor: pointer;
	    transition: color 0.3s ease; /*색상 전환 효과*/
	    font-size: 25px;
	    font-weight: bold;
	    color : #E4E0E1;
	    text-decoration : none;
	}
	
	.pagination>li>a:hover {
	    text-decoration-line: none;
	    color : #AB886D;
	}
	
	.pagination > li>a.active {
	    color: #493628; 
	}
	
	.pagination .active .page-link {
	
	    color: #AB886D;
	
	}
	
	.pagination .page-link {
	    color: #E4E0E1; 
	    text-decoration: none;
	}
	
	.pagination .disabled .page-link {
	    color: #ccc;
	    pointer-events: none;
	    cursor: default;
	}
	
	/*글작성버튼*/
    .btn {
        padding-right : 13px;
        box-sizing: border-box;
        position: absolute; 
        right: 0;
    }

    #enrollForm {
        width: 170px;
        height: 38px;
        border: none;
        border-radius: 5px;
        color: #D2CECF;
        font-size: 20px;
        font-weight: bolder;
        box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
        background-color: #493628;
        cursor: pointer;
    }

    #enrollForm:hover {
        transform: scale(1.1em);
    }

    #enrollForm:active {
        background-color: #AB886D;
    }

</style>
</head>
<body>
    
    <jsp:include page="../common/header.jsp" />
    
    <!--전체영역을 감싸는 container-->
    <div class="container">

        <h2 style="color : #E4E0E1;">공지사항</h2>
        <h3 style="color : #E4E0E1; ">FILOOM의 주요한 이슈 및 여러가지 소식들을 확인할 수 있습니다.</h3>
        <div style="font-weight: bold; color : #E4E0E1; margin-bottom : 20px;">총<b style="color : #AB886D;" id="ncount">${listCount }</b>건</div>

        <!--공지사항 게시글 목록 리스트 영역-->
        <div class="listArea">
            <div class="menu">
                <div id="no">번호</div>
                <div id="title">제목</div>
                <div id="createDate">작성일</div>
                <div id="count">조회수</div>
            </div>

            <!--목록테이블-->
            <div class="list-area">
                <table class="noticeList">
                    <tbody>
                    	<c:forEach var="n" items="${requestScope.list }">
                    		<tr class="list">
	                            <td class="nno" id="nNo">${n.noticeNo }</td>
	                            <td id="nTitle" align="left">${n.noticeTitle }</td>
	                            <td id="nCreateDate">${n.createDate }</td>
	                            <td id="nCount">${n.count }</td>
                        	</tr> 
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <script>
			$(function() {
				$(".noticeList>tbody>tr").click(function() {
					// 글번호 뽑기
					let nno = $(this).children(".nno").text();
					console.log(nno);
					
					location.href = "detail.no?nno=" + nno;
				});
				
			});        
        </script>

	    <div class="foot" style="box-sizing: border-box;">
		<!-- 페이징바 -->
		<div class="pagingArea">
		    <ul class="pagination" id="pagination">
		        <!-- 이전 페이지 버튼 -->
		<c:choose>
		    <c:when test="${requestScope.pi.currentPage == 1}">
		    <li class="page-item disabled">
		        <a class="page-link" href="#">«</a>
		    </li>
		</c:when>
		<c:otherwise>
		    <li class="page-item">
		        <a class="page-link" href="list.no?cpage=${requestScope.pi.currentPage - 1}">«</a>
		        </li>
		    </c:otherwise>
		</c:choose>
		
		<!-- 페이지 번호 출력 -->
		<c:forEach var="p" begin="${requestScope.pi.startPage}" end="${requestScope.pi.endPage}">
		<li class="page-item ${p == requestScope.pi.currentPage ? 'active' : ''}">
		<a class="page-link" href="list.no?cpage=${p}">${p}</a>
		    </li>
		</c:forEach>
		
		<!-- 다음 페이지 버튼 -->
		<c:choose>
		    <c:when test="${requestScope.pi.currentPage < requestScope.pi.maxPage}">
		<li class="page-item">
		    <a class="page-link" href="list.no?cpage=${requestScope.pi.currentPage + 1}">»</a>
		                </li>
		            </c:when>
		            <c:otherwise>
		                <li class="page-item disabled">
		                    <a class="page-link" href="#">»</a>
		                </li>
		            </c:otherwise>
		        </c:choose>
		    </ul>
		</div>
		
		<!--버튼--> 
        <div class="btn">
        	<c:if test="${sessionScope.loginUser.userNo eq 1 }">
        		<a href="enrollForm.no"><button id="enrollForm">글 작성</button></a>
        	</c:if>
        </div>
    </div>
	</div>
	
	 <jsp include page="../common/footer.jsp" />
	
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
    </script>
</body>
</html>