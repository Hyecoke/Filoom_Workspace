<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 공지사항 목록조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/admin.css" />
    <style>
        /*메뉴 부분*/
        #titleContent {
            font-size: 20px;
            font-weight: bold;
            color : #493628;
            padding : 27px 20px;
        }

        .menu {
            box-sizing: border-box;
            padding : 27px 20px;
            width : 100%;
            display: flex;
            justify-content: left;
            gap : 25px;
            margin-bottom : 10px;
        }

        #noticeNo, #noticeTitle, #noticeDate, #noticeStatus {
            font-size: 20px;
            font-weight: bold;
            color : #493628;
        }

        #noticeNo {
            margin-left: 36px;
        }

        #noticeTitle {
            margin-left: 25px;
        }

        #noticeDate {
            margin-left: 915px;
        }

        #noticeStatus {
            margin-left: 140px;
        }

        /*목록영역*/
        table {
            border : none;
            border-collapse: collapse;
            box-sizing: border-box;
            width : 100%;
            margin: 5px 0;
        }
        #nlist {
            height : 65px;
            font-size: 20px;
            font-weight: bold;
            border-bottom: 2px solid #493628;

        }

        #nno, #nstatus {
            text-align: center;
            width : 10%;
        }
        
        #ntitle {
            text-align: left;
            width : 60%
        }

        #ndate {
            text-align: center;
            width : 20%;
        }

        #nlist:hover {
            background-color: white;
            border-bottom : 2px solid #493628;
            text-align : center;
            font-weight: bold;
            height : 65px;
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
		    font-size: 20px;
		    font-weight: bold;
		    color : #F3F3F3;
		}
		
		.pagination>li>a {
		    margin : 0 10px; /*리스트 항목 간의 간격*/
		    cursor: pointer;
		    transition: color 0.3s ease; /*색상 전환 효과*/
		    font-size: 20px;
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
    <div id = "admin_content">
         <jsp:include page="../../common/adminHeader.jsp" />
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 혜원 - 관리자 공지사항 목록 조회 -->
                <div id = "admin_title_content">
                    <div class="menu">
                        <div id="noticeNo">번호</div>
                        <div id="noticeTitle">제목</div>
                        <div id="noticeDate">작성일</div>
                        <div id="noticeStatus">상태값</div>
                    </div>
                </div>

            </div>

            <div id = "admin_detail">
                
                <!-- 혜원 목록테이블-->
                <div id ="admin_page">
                    <!--이건 버튼 이랑 text 샘플
                    <input type ="text" id ="text_sample">
                    <input type="button" id ="button_sample" value="샘플">-->

                    <table class="noticeList">
                    	<tbody>
                    		<c:forEach var="n" items="${requestScope.list }">
                    			<tr id="nlist">
		                            <td id="nno" class="nno">${n.noticeNo }</td>
		                            <td id="ntitle">${n.noticeTitle }</td>
		                            <td id="ndate">${n.createDate }</td>
		                            <td id="nstatus">${n.status }</td>
		                        </tr>
                        
                    		</c:forEach>
                    	</tbody>
                    </table>
                    
                    <script>
	                    $(function() {
	        				$(".noticeList>tbody>tr").click(function() {
	        					// 글번호 뽑기
	        					let nno = $(this).children(".nno").text();
	        					console.log(nno);
	        					
	        					location.href = "adetail.no?nno=" + nno;
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
					                        <a class="page-link" href="alist.no?cpage=${requestScope.pi.currentPage - 1}">«</a>
					                    </li>
					                </c:otherwise>
					            </c:choose>
					
					            <!-- 페이지 번호 출력 -->
					            <c:forEach var="p" begin="${requestScope.pi.startPage}" end="${requestScope.pi.endPage}">
					                <li class="page-item ${p == requestScope.pi.currentPage ? 'active' : ''}">
					                    <a class="page-link" href="alist.no?cpage=${p}">${p}</a>
					                </li>
					            </c:forEach>
					
					            <!-- 다음 페이지 버튼 -->
					            <c:choose>
					                <c:when test="${requestScope.pi.currentPage < requestScope.pi.maxPage}">
					                    <li class="page-item">
					                        <a class="page-link" href="alist.no?cpage=${requestScope.pi.currentPage + 1}">»</a>
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