<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 공지사항 상세조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="resources/css/admin.css" />
    <style>
        #title {
            font-size: 25px;
            font-weight: bold;
            color : #493628;
            padding : 27px 20px; 
        }

        .title_date_count {
            border-bottom : 4px solid #493628;
            padding: 10px;
            display: flex;
            justify-content: left;
            gap : 26px;
        }

        .content {
            padding: 10px;
            display : flex;
            align-items: center;
            gap : 10px;
        }

        #nTitlearea, #nDatearea, #nCountarea, #nContentarea {
            font-size: 24px;
            font-weight: bold;
            color : #493628;
            padding-left : 5px;
            display: flex;
            justify-content: left;
            gap : 10px;
            margin-left: 5px;
            
        }

        #ntitle, #ndate, #ncount, #ncontent {
            height: 40px;
            border: none;
            border-radius: 5px;
            box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
            outline: none;
            margin-bottom : 10px;
            background-color: white;
        }

        #ncontent {
            width : 1304px;
            height : 550px;
            padding-left: 10px;
            font-weight: 500;
            
        }

        #ntitle {
            width : 515px;
            padding-left: 10px;
        }

        #ndate {
            width : 335px;
            text-align: center;
        }

        #ncount {
            width : 190px;
            text-align: center;
        }

        /*버튼*/
        .btn {
            padding-right : 13px;
            text-align: right;
            box-sizing: border-box;
        }

        button {
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

        button:hover {
            transform: scale(1.1em);
        }

        button:active {
            background-color: #AB886D;
        }

    </style>

</head>
<body>
    <div id = "admin_content">
		<jsp:include page="../../common/adminHeader.jsp" />
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 혜원 - 관리자 공지사항 상세조회 -->
                <div id = "admin_title_content">
                    <div id="title">공지사항 게시글 상세조회</div>
                </div>
            </div>

            <div id = "admin_detail">
                
                <!-- 혜원 목록테이블-->
                <div id ="admin_page">
                    <!--이건 버튼 이랑 text 샘플
                    <input type ="text" id ="text_sample">
                    <input type="button" id ="button_sample" value="샘플">-->

                    <!--제목, 작성일, 조회수-->
                    <div class="title_date_count">
                        <div id="nTitlearea">
                            제목<b style="color : red;">*</b> <div id="ntitle">${n.noticeTitle}</div>
                        </div>

                        <div id="nDatearea">
                            작성일<b style="color : red;">*</b> <div id="ndate">${n.createDate}</div>
                        </div>

                        <div id="nCountarea">
                            조회수 <div id="ncount">${n.count}</div>
                        </div>
                    </div>

                    <!-- 내용 -->
                    <div class="content">
                        <div id="nContentarea">
                            내용<b style="color : red;">*</b><div id="ncontent">${n.noticeContent }</div>
                        </div>
                    </div>
                    
                    
                    <form id="postForm" action="" method="post">
                    	<input type="hidden" name="nno" value="${requestScope.n.noticeNo }">
                    </form> 

                    <!--목록, 수정, 삭제 버튼-->
                    <div class="btn">
                        <button id="backList" style="width : 100px; margin-right : 5px;" onclick="history.back();">목록</button>
                        
                        <c:if test="${sessionScope.loginUser.userNo eq 1 }" >
                        	<button id="update" style="width : 130px; margin-right : 5px;" onclick="postFormSubmit(1);">수정</button>
                        	<button id="delete" style="width : 130px;" onclick="postFormSubmit(2);">삭제</button>	
                        </c:if>
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