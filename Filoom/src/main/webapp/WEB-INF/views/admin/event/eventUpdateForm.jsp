<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 이벤트 글수정</title>
<link rel="stylesheet" href="resources/css/admin.css" />
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


#navbar{
    width: 20%;
    height: 100%;
    /*background-color: #4b8492;*/
    float: left;
    
}


#logo{
    position: relative;
    width: 100%;
    height: 15%;
    /*background-color: aliceblue;*/
}

#logo>img{
    position: absolute;
    left: 50%;
    right:  50%; 
    transform: translate(-50%, 80%);
    width: 60%;
    height: auto;
}

#nav {
    margin: auto;
    width: 90%;
    height: 80%;
    background-color: #151515;
    border-radius: 10px;
    cursor: pointer;
}

#nav > ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    width: 100%;
    height: 80%;
    text-align: center;
}

#nav > ul > li {
    margin: auto;
    gap: 2px;
    width: 90%;
    height: 20%;
    /*background-color: aliceblue;*/
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: background-color 0.3s; 
}

#nav > ul > li:hover {
    background-color: #d6c0b3; 
}

#nav > ul > li.selected {
    background-color: #ab886d; 
}

#nav > ul > li > a {
    color: #313131;
    font-size: 30px;
    font-weight: bold;
    text-decoration: none;
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

/*내거 영역*/
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

    #sub {
        font-size: 20px;
        font-weight: bold;
        color : #493628;
        padding : 25px; 
        margin-top: 5px;
    }

    .title_date_count {
        border-bottom : 4px solid #493628;
        padding: 10px;
        display: flex;
        justify-content: left;
        gap : 32px;
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
        height : 320px;
        resize: none;
        
    }

    #title {
        width : 450px;
    }

    #startDate {
        width : 200px;
    }

    #endDate {
        width : 200px;
    }

    /*사진첨부영역*/
    .fileArea {
        border-bottom : 4px solid #493628;
        margin-left: 0px;
        padding: 10px;
        display : flex;
        align-items: left;
        gap : 15px;
    }

    #file {
        padding: 10px 0 10px 10px;
    }
    
    
    #contentImg1, #contentImg2, #contentImg3, #contentImg4
    #emptyImage1, #emptyImage2, #emptyImage3, #emptyImage4 {
            height: 170px;
            width : 170px;
            border: none;
            border-radius: 5px;
            box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
            outline: none;
            margin-bottom : 5px;
            background-color: white;
            cursor : pointer
            
     }
	
	/*
    .thumbnailArea>input {
        height: 170px;
        width : 170px;
        border: none;
        border-radius: 5px;
        box-shadow: 3px 3px 3px rgb(0, 0, 0, 0.2);
        outline: none;
        margin-bottom : 5px;
        background-color: white;
    } */

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
    }

    #type-method>input, #eventStatus>input {
        width: 12px;
        height : 12px;
        cursor : pointer;
    }
    
    /* 브라우저 기본 스타일 초기화 */
	input[type="file"] {
	    display : none;
	}

    /*버튼*/
    .btn {
        text-align: right;
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
        transform: scale(1.1em); !important;
    }

    button:active {
        background-color: #AB886D; !important;
    }
    

    </style>

</style>

</head>
<body>
    <div id = "admin_content">
        <jsp:include page="../../common/adminHeader.jsp" />
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 혜원 - 관리자 이벤트 글작성 -->
                <div id = "admin_title_content">
                    <div id="boardTitle">이벤트 글 수정</div>
                    <div id="sub">체크(<b style="color : red;">*</b>)된 항목은 필수 입력사항입니다.</div>
                </div>
            </div>

            <div id = "admin_detail">
                
                <!-- 혜원 목록테이블-->
                <div id ="admin_page">
                    <!--이건 버튼 이랑 text 샘플
                    <input type ="text" id ="text_sample">
                    <input type="button" id ="button_sample" value="샘플">-->
                    
                    
                    <form id="updateForm" action="update.ev" method="POST" enctype="multipart/form-data">
                    <!-- 어떤 게시글인지 정확하게 파악하기 위해 게시글 번호도 같이 넘기기 -->
                    <input type="hidden" name="eventNo" value="${requestScope.e.eventNo }" >
                    
                        <!--제목, 작성일, 조회수-->
                        <div class="title_date_count">
                            <div class="title">
                                <label for="title">제목<b style="color : red;">*</b></label><input type="text" id="title" name="eventTitle" value="${requestScope.e.eventTitle }"></input>
                            </div>

                            <div class="startDate">
                                <label for="startDate">이벤트 시작일<b style="color : red;">*</b></label> <input type="date" id="startDate" min="" name="startDate" value="${requestScope.e.startDate }"></input>
                            </div>

                            <div class="endDate">
                                <label for="endDate">이벤트 종료일<b style="color : red;">*</b></label><input type="date" id="endDate" min="" name="endDate" value="${requestScope.e.endDate }"></input>
                            </div>
                        </div>
                        
                        <!-- 날짜 관련 스크립트 -->
                        <script>
						    document.addEventListener("DOMContentLoaded", function() {
						        const startDateInput = document.getElementById("startDate");
						        const endDateInput = document.getElementById("endDate");
						
						        // 오늘 날짜 (yyyy-mm-dd 형식) 계산
						        const today = new Date().toISOString().split('T')[0];
						
						        // 시작일을 오늘 날짜 이상으로 제한
						        startDateInput.setAttribute("min", today);
						
						        // 종료일의 최소 날짜를 오늘 날짜로 설정
						        endDateInput.setAttribute("min", today);
						
						        // 시작일이 변경될 때, 종료일의 min 속성도 시작일 이후로 업데이트
						        startDateInput.addEventListener("change", function() {
						            const startDate = startDateInput.value;
						            endDateInput.setAttribute("min", startDate); // 종료일은 시작일 이후로만 선택 가능
						        });
						    });
						</script>

                        <!-- 내용 -->
                        <div class="contentArea">
                            <label for="content" class="content">내용<b style="color : red;">*</b></label>
                            <textarea id="content" name="eventContent">${requestScope.e.eventContent }</textarea>
                        </div>

                        <!-- 사진첨부 -->
                        <div class="fileArea">
					    <label for="fileInput1" id="file">사진<br>첨부<b style="color : red;">*</b></label>

					    <!-- 첫 번째 이미지 -->
					    <img id="contentImg1" 
					    src="${pageContext.request.contextPath}${e.contentImg1}" alt="Preview Image 1" 
					    data-target="file1" onclick="confirmAndDeleteImage(1, '${e.contentImg1}', this)" />
					    <input type = "hidden" name="contentImg1" value="${e.contentImg1}"/>
					    <!-- 첫 번째 이미지에 맞는 파일 입력 창 -->
						<input type="file" id="file1" name="currentImage1" data-index="1" onchange="loadImg(this);" multiple required>
						
						<!-- 두 번째부터 네 번째 이미지 처리 -->
					    <!-- 첫 번째 이미지 -->
					    <img id="contentImg1" 
					    src="${pageContext.request.contextPath}${e.contentImg1}" alt="Preview Image 1" 
					    data-target="file1" onclick="confirmAndDeleteImage(1, '${e.contentImg1}', this)" />
					    <input type = "hidden" name="contentImg1" value="${e.contentImg1}"/>
					    <!-- 첫 번째 이미지에 맞는 파일 입력 창 -->
						<input type="file" id="file1" name="currentImage1" data-index="1" onchange="loadImg(this);" multiple required>
					    
						
						
						
						
						
						
						
						
						
					    <!-- 두 번째부터 네 번째 이미지 처리 -->
					    <div>
					        <c:forEach var="i" begin="1" end="3">
					            <c:choose>
					                <c:when test="${i <= list.size()}">
					                    <c:set var="file" value="${list[i - 1]}" />
					                    <label for="file${i + 1}"></label>
					                    <img id="contentImg${i + 1}" src="${pageContext.request.contextPath}${file.changeName}" alt="Attachment Preview ${i + 1}" data-target="file${i + 1}" onclick="confirmAndDeleteImage(${i + 1}, '${file.changeName}', this)" />
					                    <!-- 해당 이미지를 위한 파일 입력 창 -->
					                    <input type ="hidden" name="contentImg${i + 1}" value="${pageContext.request.contextPath}${file.changeName}"/>
					                    <input type="file" id="file${status.index + 1}" name="newUpfiles" data-index="${status.index + 1}" onchange="loadImg(this);" multiple>
					                   
					                </c:when>
					                
					            </c:choose>
					        </c:forEach>
					    </div>
					    
					    
					    
					    
					    <script>
					 	// 이미지 첨부 스크립트 (중복 방지 적용)
					    document.addEventListener("DOMContentLoaded", function () {
					        const images = document.querySelectorAll("img[data-target]");
					        const fileInputs = document.querySelectorAll('input[name="upfiles"]');

					        // 이미지 클릭 시 파일 입력창 열기
					        images.forEach((img) => {
					            const boundClickEvent = img.getAttribute("data-bound-click");

					            // 중복 클릭 방지를 위한 속성 확인
					            if (!boundClickEvent) {
					                img.addEventListener("click", function () {
					                    const fileInputId = img.getAttribute("data-target");
					                    const fileInput = document.getElementById(fileInputId);
					                    if (fileInput) fileInput.click(); // 파일 입력창 열기
					                });
					                img.setAttribute("data-bound-click", "true"); // 이벤트 등록 표기
					            }
					        });

					        // 파일 입력 변화 시 미리보기 업데이트
					        fileInputs.forEach((input) => {
					            const boundChangeEvent = input.getAttribute("data-bound-change");

					            // 중복 체인지 방지를 위한 속성 확인
					            if (!boundChangeEvent) {
					                input.addEventListener("change", function () {
					                    loadImg(input); // 이미지 처리
					                });
					                input.setAttribute("data-bound-change", "true"); // 이벤트 등록 표기
					            }
					        });
					    });

					    // 파일을 선택하면 미리보기 이미지에 표시
					    function loadImg(input) {
					        const index = input.dataset.index;
					        const previewImg = document.getElementById("contentImg" + index);
					        const file = input.files[0];

					        if (!previewImg) {
					            console.error(`Image element with id 'contentImg${index}' not found.`);
					            return;
					        }

					        if (file && file.type.startsWith("image/")) {
					            const reader = new FileReader();
					            reader.onload = function (e) {
					                previewImg.src = e.target.result;
					                previewImg.style.display = "block"; // 미리보기 이미지 보이게 처리
					            };
					            reader.readAsDataURL(file); // 파일을 데이터 URL로 변환하여 미리보기 이미지를 설정
					        } else {
					            alert("이미지 파일만 선택 가능합니다.");
					        }
					    }

					    // 이미지 삭제 및 상태값 변경, 새로운 파일 미리보기 처리
					    function confirmAndDeleteImage(fileIndex, filePath, imgElement) {
					        const userConfirmed = confirm("해당 이미지를 삭제하시겠습니까?");
					        if (userConfirmed) {
					            // 삭제 상태값을 서버에 전달할 수 있도록 업데이트 (상태를 "n"으로 설정)
					            const deletedFileInput = document.getElementById('deletedFile' + fileIndex);
					            if (deletedFileInput) {
					                deletedFileInput.value = "Y";  // 'n' 값으로 상태값 설정
					            }

					            // 이미지를 화면에서 "보이지 않게 처리"
					            imgElement.style.display = "none";  // 이미지 숨기기
					            imgElement.src = '';  // 이미지를 빈 이미지로 변경

					            // 파일 입력창 열기 (기존 이미지가 삭제된 후 파일 업로드 창을 보여줌)
					            const fileInput = document.getElementById('file' + fileIndex);
					            if (fileInput) {
					                fileInput.style.display = "block";  // 파일 입력창 보이게 하기
					            } else {
					                console.error('File input element with id "fileInput' + fileIndex + '" not found');
					            }
					        }
					    }

					   		 // 파일을 첨부하면서 이미지 업로드 후 미리보기 갱신 및 상태값 업데이트
						    function updateImagePreview(fileIndex, inputElement) {
						    const file = inputElement.files[0];
						    const imgElement = document.getElementById('contentImg' + fileIndex);
						
						    if (file) {
						        const reader = new FileReader();
						        
						        // 이미지 파일을 데이터 URL로 읽어들여 `img` 엘리먼트에 표시
						        reader.onload = function (e) {
						            imgElement.src = e.target.result;  // 이미지를 읽어온 데이터로 설정
						            imgElement.style.display = "block";  // 이미지를 보이도록 설정

						            // 새 파일이 선택되었으면 기존 "삭제" 버튼 등을 초기화 처리하기
						            const deletedFileInput = document.getElementById('deletedFile' + fileIndex);
						            if (deletedFileInput) {
						                deletedFileInput.value = "";  // 삭제된 상태값을 초기화 (빈 값으로 설정)
						            }
						        };

						        reader.readAsDataURL(file); // 파일을 읽어서 base64 URL 형식으로 변환하여 미리보기 처리
						    }
						}
					</script>
					<!-- 파일 입력 태그 예시 -->
					                            
                            <div class="comment" style="padding : 10px;">
                                <!--button type="button" class="btn" id="fileButton" style="width : 140px; text-align: center;">파일첨부</button>
                                <!--input type="file" id="fileInput" style="display:none;"> -->
                                <!-- 썸네일은 필수입력사항으로 지정 
	                            <input type="file" id="file1" name="upfiles" onchange="loadImg(this, 1);" multiple style="display:none;">
	                            
	                            <!-- 기본이미지 --
	                            <input type="file" id="file2" name="upfiles" onchange="loadImg(this, 2);" multiple style="display:none;">
	                            <input type="file" id="file3" name="upfiles" onchange="loadImg(this, 3);" multiple style="display:none;">
	                            <input type="file" id="file4" name="upfiles" onchange="loadImg(this, 4);" multiple style="display:none;"> -->
                                
                                <div style="color : #493628; font-size: 16px; font-weight : bold; margin-top: 10px;">
                                    * JPEG, PNG 형식의 10M 이하의 파일만 첨부 가능합니다.(최대 4개)<br><br>
                                    * 개인정보가 포함된 이미지 등록은 자제하여 주시기 바랍니다. 
                                </div>
                            </div>
                        </div>
                        

                        <!--이벤트 종류 / 종료 여부 / 버튼-->
                        <div class="type-status-btn">
                            <div class="type">
                                <div style="margin-top: 2px;">이벤트 참여 방법<b style="color : red;">*</b></div>
                                <div id="type-method">
                                    댓글<input type="radio" name="eventType" value="1" ${e.eventType == 1 ? 'checked' : ''} required>
                                    응모버튼<input type="radio" name="eventType" value="2" ${e.eventType == 2 ? 'checked' : ''} required>
                                    오프라인<input type="radio" name="eventType" value="3" ${e.eventType == 3 ? 'checked' : ''} required>
                                </div>
                            </div>

                            <div class="status">
                                <div style="margin-top: 2px;">이벤트 종료 여부<b style="color : red;">*</b></div>
                                <div id="eventStatus">
                                    진행중인 이벤트<input type="radio" name="eventStatus" value="N" ${e.eventStatus != null && e.eventStatus.equals("N") ? 'checked' : ''} required> <!-- N 으로 변경 -->
                                    종료된 이벤트<input type="radio" name="eventStatus" value="Y" ${e.eventStatus != null && e.eventStatus.equals("Y") ? 'checked' : ''} required>  <!-- Y 으로 변경 -->
                                </div>
                            </div>
                        
                            <!--수정, 취소 버튼-->
                            <div class="btn">
                                <button id="cancle" style="width : 100px; margin-right : 5px;" onclick="javascript:history.go(-1);">취소</button>
                                <button type="submit" id="submit" style="width : 130px;">수정하기</button>
                            </div>
                        </div>

                    </form>

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