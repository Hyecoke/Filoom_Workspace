<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 이벤트 목록조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="resources/css/admin.css" />
    <style>
        /*메뉴 부분*/
        #titleContent {
            height : 65px;
            font-size: 30px;
            font-weight: bold;
            color : #493628;
        }

        .menu {
            box-sizing: border-box;
            padding: 5px;
            margin: 5px;
            width : 100%;
            display: flex;
            justify-content: left;
            gap : 10px;
        }

        #eventNo, #thumb, #eventTitle, #startDate, #endDate, #eventStatus, #status {
            box-sizing: border-box;
            font-size: 25px;
            font-weight: bold;
            color : #493628;
            padding: 13px 0;
        }

        #eventNo {
            margin-left: 45px;
        }

        #thumb {
            margin-left:105px;
        }

        #eventTitle {
            margin-left: 55px;
        }

        #startDate {
            margin-left: 480px;
        }

        #endDate {
            margin-left: 63px;
        }

        #eventStatus {
            margin-left: 46px;
        }

        #status {
            margin-left: 36px;
        }

        
        /*목록영역*/
        table {
            border : none;
            border-collapse: collapse;
            box-sizing: border-box;
            width : 100%;
            margin-bottom: 10px;
        }

        #list {
            height : 63px;
            font-size: 20px;
            font-weight: bold;
            border-bottom: 2.5px solid #493628;
            text-align: center;
        }

        #list:hover {
            background-color: white;
            border-bottom : 2px solid #493628;
            text-align : center;
            font-weight: bold;
            height : 63px;
        }

        #event-status, #estatus {
            width : 10%;
        }

        .eno {
            
            width : 10%;
        }

        #event-thumb {
           
            width : 15%;
        }

        #event-title {
            
            width : 35%;
            text-align: left;
            cursor: pointer;
        }

        #event-startDate, #event-endDate {
           
            width : 10%;
        }

        #contentImg1 {
            box-sizing: border-box; 
            width: 90px; 
            height : 115px; 
            border-radius: 4px;
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
		    color : #493628;
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
		    color: #493628; 
		    text-decoration: none;
		}
		
		.pagination .disabled .page-link {
		    color: #ccc;
		    pointer-events: none;
		    cursor: default;
		}


        /*버튼*/
        .btn {
            padding-right : 13px;
            box-sizing: border-box;
            position: absolute; 
            right: 0;
        }

        #enrollForm, #applicant {
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

        #enrollForm:hover, #applicant:hover {
            transform: scale(1.1em);
        }

        #enrollForm:active, #applicant:active {
            background-color: #AB886D;
        }
        
    </style>

</head>
<body>
    <div id = "admin_content">
     <jsp:include page="../../common/adminHeader.jsp" />
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 혜원 - 관리자 이벤트 목록 조회 -->
                <div id = "admin_title_content">
                    <div class="menu">
                        <div id="eventNo">번호</div>
                        <div id="thumb">썸네일</div>
                        <div id="eventTitle">제목</div>
                        <div id="startDate">시작일</div>
                        <div id="endDate">종료일</div>
                        <div id="eventStatus">종료여부</div>
                        <div id="status">삭제여부</div>
                    </div>
                </div>

            </div>

            <div id = "admin_detail">
                
                <!-- 혜원 목록테이블-->
                <div id ="admin_page">
                    <!--이건 버튼 이랑 text 샘플
                    <input type ="text" id ="text_sample">
                    <input type="button" id ="button_sample" value="샘플">-->

                    <table id="eventList">
                    	<tbody>
	                    	<c:forEach var="e" items="${requestScope.list }">
		                        <tr id="list">
		                            <td class="eno">${e.eventNo}</td>
		                            <td id="event-thumb">
		                                <div id="img" style="box-sizing: border-box; margin-top : 3px;">
		                                    <img id="contentImg1" src="${pageContext.request.contextPath}${e.contentImg1}" style="box-sizing: border-box; width : 90px; height : 115px; border-radius : 4px;">                      
	                                    </div>
		                            </td>
		                            <td id="event-title">${e.eventTitle}</td>
			                            <c:choose>
			                            	<c:when test="${empty e.startDate and empty e.endDate }">
			                            		<td colspan="2" style="text-align: center;">상시진행</td>
			                            	</c:when>
			                            	<c:otherwise>
			                            		<td id="event-startDate">${e.startDate}</td>
				                            	<td id="event-endDate">${e.endDate}</td>
			                            	</c:otherwise>
			                            </c:choose>
		                            <td id="event-status">${e.eventStatus}</td>
		                            <td id="estatus">${e.status}</td>
		                        </tr>
	                        </tbody>
                        </c:forEach>

                    </table>
                    
                    <script>
                    	$(function() {
                    		$("#eventList>tbody>tr").click(function() {
                    			
                    			// 글번호 뽑기 
                    			let eno = $(this).children(".eno").text();
                    			console.log(eno);
                    			
                    			location.href = "adetail.ev?eno=" + eno;
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
					                        <a class="page-link" href="alist.ev?cpage=${requestScope.pi.currentPage - 1}">«</a>
					                    </li>
					                </c:otherwise>
					            </c:choose>
					
					            <!-- 페이지 번호 출력 -->
					            <c:forEach var="p" begin="${requestScope.pi.startPage}" end="${requestScope.pi.endPage}">
					                <li class="page-item ${p == requestScope.pi.currentPage ? 'active' : ''}">
					                    <a class="page-link" href="alist.ev?cpage=${p}">${p}</a>
					                </li>
					            </c:forEach>
					
					            <!-- 다음 페이지 버튼 -->
					            <c:choose>
					                <c:when test="${requestScope.pi.currentPage < requestScope.pi.maxPage}">
					                    <li class="page-item">
					                        <a class="page-link" href="alist.ev?cpage=${requestScope.pi.currentPage + 1}">»</a>
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
	                        		<a href="enrollForm.ev"><button id="enrollForm">이벤트 등록</button></a>
	                        	</c:if>
	                        </div>
           				
           				
		    		</div>
                        
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
    </script>
    
</body>
</html>