<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 이벤트 상세조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="resources/css/admin.css" />
    <style>
        #admin_title_content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #boardTitle {
            font-size: 30px;
            font-weight: bold;
            color : #493628;
            padding : 20px; 
        }

        #applicant {
            width : 150px;
            margin-right: 25px;
        }

        .title_date_count {
            border-bottom : 4px solid #493628;
            padding: 10px;
            display: flex;
            justify-content: left;
            gap : 40px;
            /*border : 1px solid blue;*/
        }

        .contentArea {
            border-bottom : 4px solid #493628;
            margin-left: 0px;
            padding: 10px;
            display : flex;
            align-items: left;
            gap : 3px;
        }

        .content {
            padding: 10px;
        }

        .title, .startDate, .endDate, .content, #thumbnail {
            font-size: 24px;
            font-weight: bold;
            color : #493628;
            padding-left : 5px;
            display: flex;
            justify-content: left;
            gap : 10px;
            margin-left: 5px;
        }

        #title, #startDate, #endDate, #content {
            height: 40px;
            border: none;
            border-radius: 5px;
            box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
            outline: none;
            margin-bottom : 10px;
            background-color: white;
            
        }

        #content {
            width : 1300px;
            height : 340px;
            text-align: left;
            padding-left : 10px;
            
        }

        #title {
            width : 460px;
            text-align: left;
            padding-left : 10px;
        }

        #startDate {
            width : 185px;
            text-align: center;
        }

        #endDate {
            width : 185px;
            text-align: center;
        }

        /*사진첨부영역*/
        .thumbnailArea {
            border-bottom : 4px solid #493628;
            margin-left: 0px;
            padding: 10px;
            display : flex;
            align-items: left;
            gap : 15px;
        }

        #thumbnail {
            padding: 10px 0 10px 10px;
        }

        #contentImg1, #event_img {
            height: 170px;
            width : 170px;
            border: none;
            border-radius: 5px;
            box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
            outline: none;
            margin-bottom : 5px;
            background-color: white;
        }

        /*이벤트 종류, 종료여부, 버튼*/
        .type-status-btn {
            display: flex;
            justify-content: right;
            gap : 25px;
            padding : 10px;
        }

        /*이벤트 종류*/
        .type, .status {
            display: flex;
            justify-content: right;
            gap : 25px;
            font-size: 20px;
            font-weight: bold;
            color: #493628;
            padding : 10px;
        }

        #type-method, #eventStatus {
            font-size: 17px;
            padding : 3px;
            color: #AB886D;
        }

        #type-method>input, #eventStatus>input {
            width: 12px;
            height : 12px;
        }
        
        .readonly-radio {
        	width: 12px;         /* 라디오 버튼 크기 */
		    height: 12px;        /* 라디오 버튼 크기 */
		    border-radius: 50%;  /* 동그라미 모양 */
		    border: 2px solid #aaa; /* 기본 테두리 색상 */
		    background-color: white; /* 기본 배경 색상 */
		    cursor: not-allowed; /* 비활성화 상태로 처리 */
		    pointer-events: none; /* 클릭을 막는 설정 */
		    position: relative;
        }
        
        /* 라디오 버튼 체크 상태일 때 파란색으로 스타일 적용 */
		.checked-style {
		    background-color:  white; /* 배경을 파란색으로 */
		    border-color:  #aaa;     /* 테두리 색상을 파란색으로 */
		}
		
		.checked-style::after {
		    content: '';            /* 체크된 표시 추가 */
		    position: absolute;
            top : 2px;
            left: 2px;
            bottom: 2px;
            right : 2px;
		    width: 8px;             /* 체크 표시 크기 */
		    height: 8px;            /* 체크 표시 크기 */
		    background-color: rgb(32, 104, 176); /* 체크 표시 색상 */
		    border-radius: 50%;      /* 원 모양 */
		}


        /*버튼*/
        .btn {
            box-sizing: border-box;
            padding : 5px;

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

                <!-- 혜원 - 관리자 이벤트 상세조회 -->
                <div id = "admin_title_content" >
                    <div id="boardTitle" >이벤트 게시글 상세조회</div>
                    <div><a href="#" onclick="location.href='aplist.ev?eventNo=' + eventNo + '&eventType=' + eventType + '&cpage=1'"><button class="btn" id="applicant">응모자 확인</button></a></div>
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
                        <div class="title">
                            제목<b style="color : red;">*</b> <div id="title">${e.eventTitle }</div>
                        </div>
	                       <div class="startDate">
	                       		<c:choose>
	                       			<c:when test="${empty e.startDate and empty e.endDate }">
	                       				이벤트 시작일<b style="color : red;">*</b> <div id="startDate">상시진행</div>
	                       			</c:when>
	                       			<c:otherwise>
	                       				이벤트 시작일<b style="color : red;">*</b> <div id="startDate">${e.startDate }</div>
	                       			</c:otherwise>
	                       		</c:choose>
	                       </div>
	
	                       <div class="endDate">
	                       		<c:choose>
	                       			<c:when test="${empty e.startDate and empty e.endDate }">
	                       				이벤트 종료일<b style="color : red;">*</b><div id="endDate">상시진행</div>
	                       			</c:when>
	                       			<c:otherwise>
	                       				이벤트 종료일<b style="color : red;">*</b><div id="endDate">${e.endDate }</div>
	                       			</c:otherwise>
	                       		</c:choose>
	                       </div>
                    </div>

                    <!-- 내용 -->
                    <div class="contentArea">
                        <div class="content">내용<b style="color : red;">*</b></div>
                        <div id="content">${e.eventContent }</div>
                    </div>

                    <!-- 사진첨부 -->
                    <div class="thumbnailArea">
                        <div id="thumbnail">사진<br>첨부<b style="color : red;">*</b></div>
                        <img id="contentImg1" src="${ pageContext.request.contextPath }${e.contentImg1}">
                        
                        
                        <!-- 첨부된 파일 수만큼 이미지 보여주기 (순차적으로 추가) -->
                        <c:forEach var="file" items="${requestScope.list }" >
                        	 <img id="event_img" src="${ pageContext.request.contextPath }${file.changeName}">
                        </c:forEach>
                        <!-- 
                        <img id="contentImg1" src="${ pageContext.request.contextPath }${e.contentImg1}">
                        <img id="event_img" src="${ pageContext.request.contextPath }${file.changeName}">
                        <img id="event_img" src="${ pageContext.request.contextPath }${file.changeName}">
                        <img id="event_img" src="${ pageContext.request.contextPath }${file.changeName}"> -->
                        <div class="comment" style="padding : 10px;">
                            <div style="color : #493628; font-size: 16px; font-weight : bold; margin-top: 10px;">
                                * JPEG, PNG 형식의 5M 이하의 파일만 첨부 가능합니다.(최대 4개)<br><br>
                                * 개인정보가 포함된 이미지 등록은 자제하여 주시기 바랍니다. 
                            </div>
                        </div>
                    </div>

                    <!--이벤트 종류 / 종료 여부 / 버튼-->
                    <div class="type-status-btn">
                        <div class="type">
                            <div style="margin-top: 2px;">이벤트 참여 방법<b style="color : red;">*</b></div>
                            <div id="type-method">
                                댓글<input type="radio" name="eventType" value="1" class="readonly-radio">
                                응모버튼<input type="radio" name="eventType" value="2" class="readonly-radio">
                                오프라인<input type="radio" name="eventType" value="3" class="readonly-radio">
                                
                                <!-- 숨겨진 필드 -->
                                <input type="hidden" name="eventType" value="${e.eventType }">
                            </div>
                        </div>

                        <div class="status">
                            <div style="margin-top: 2px;">이벤트 종료 여부<b style="color : red;">*</b></div>
                            <div id="eventStatus">
                                진행중인 이벤트<input type="radio" name="eventStatus" value="N" class="readonly-radio">
                                종료된 이벤트<input type="radio" name="eventStatus" value="Y" class="readonly-radio">
                                
                                <!-- 숨겨진 필드 -->
                                <input type="hidden" name="eventStatus" value="${e.eventStatus}">
                            </div>
                        </div>
                        
                        <!-- 라디오 버튼 체크된 값, 비활성화 -->
                        <script>
					    document.addEventListener("DOMContentLoaded", function () {
					        // 서버에서 가져온 값을 변수로 설정
					        const eventTypeValue = "${e.eventType}";
					        const eventStatusValue = "${e.eventStatus}";
					
					        // eventType 라디오 버튼 체크 상태 설정
					        document.querySelectorAll("input[name='eventType']").forEach(radio => {
					            if (radio.value === eventTypeValue) {
					                radio.checked = true;
					                radio.disabled = true; // 읽기 전용으로 비활성화
					                radio.classList.add("checked-style"); // 체크된 라디오 버튼에 스타일 클래스 추가
					            }
					        });
					
					        // eventStatus 라디오 버튼 체크 상태 설정
					        document.querySelectorAll("input[name='eventStatus']").forEach(radio => {
					            if (radio.value === eventStatusValue) {
					                radio.checked = true;
					                radio.disabled = true; // 읽기 전용으로 비활성화
					                radio.classList.add("checked-style"); // 체크된 라디오 버튼에 스타일 클래스 추가
					            }
					        });
					    });
					</script>
					
					<form id="postForm" action="" method="post">
	                	<input type="hidden" name="eno" value="${requestScope.e.eventNo }">
	                	<input type="hidden" name="filePath" value="${file.changeName }">
                	</form>
                    
                        <!--목록, 수정, 삭제 버튼-->
                        <div class="btn">
                            <button id="backList" style="width : 100px; margin-right : 5px;" onclick="history.back()">목록</button>
                            
                            <c:if test="${sessionScope.loginUser.userNo eq 1 }">
	                            <!-- <button id="update" style="width : 130px; margin-right : 5px;" onclick="postFormSubmit(1);">수정</button>-->
	                            <button id="delete" style="width : 130px;" onclick="postFormSubmit(2);">삭제</button>
                            </c:if>
                        </div>
                        
                        <script>
			            	function postFormSubmit(num) {
			            		console.log(num);
			            		
			            		if(num == 1) {
			            			$("#postForm").attr("action", "updateForm.ev").submit();
			            		} else {
			            			$("#postForm").attr("action", "delete.ev").submit();
			            		}
			            	}
			            </script>
                    </div>

                </div>


            </div>
        </div>
    </div>

    
    
    </div>
    </div>
    <script>
    // 메뉴바
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
    
    // 응모자확인 링크 이동 변수
    var eventNo = ${e.eventNo}; // JSP 변수에서 자바스크립트 변수로 전달
    var eventType = ${e.eventType};
	</script>

    
</body>
</html>