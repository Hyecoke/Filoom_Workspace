<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자용 이벤트 글작성</title>
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
    
    
    #contentImg1, #contentImg2, #contentImg3, #contentImg4 {
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

</head>
<body>
    <div id = "admin_content">
    <jsp:include page="../../common/adminHeader.jsp" />   
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 혜원 - 관리자 이벤트 상세조회 -->
                <div id = "admin_title_content">
                    <div id="boardTitle">이벤트 글 작성</div>
                    <div id="sub">체크(<b style="color : red;">*</b>)된 항목은 필수 입력사항입니다.</div>
                </div>
            </div>

            <div id = "admin_detail">
                
                <!-- 혜원 목록테이블-->
                <div id ="admin_page">
                    <!--이건 버튼 이랑 text 샘플
                    <input type ="text" id ="text_sample">
                    <input type="button" id ="button_sample" value="샘플">-->
                    
                    
                    <form id="enrollForm" action="insert.ev" method="post" enctype="multipart/form-data">
                    	<!-- 쿠폰 정보 넘기기 -->
                    	<input type="hidden" id="couponNo" name="couponNo" value="${couponNo != null ? couponNo : 0}">
                    	<input type="hidden" id="refEno" name="refEno" value="${eventNo != null ? eventNo : 0}">
                    	<input type="hidden" id="couponName" name="coupoName" value="${requestScope.e.eventTitle }">
                    	<input type="hidden" id="couponLevel" name="couponLevel" value="${requestScope.e.eventType }">
                    	<input type="hidden" id="couponExpDate" name="couponExpDate" value="${couponExpDate != null ? couponExpDate.toString('yyyy-MM-dd') : ''}">
                    	<input type="hidden" id="couponStatus" name="couponStatus" value="${requestScope.c.couponStatus }">
                    
                        <!--제목, 작성일, 조회수-->
                        <div class="title_date_count">
                            <div class="title">
                                <label for="title">제목<b style="color : red;">*</b></label><input type="text" id="title" name="eventTitle"></input>
                            </div>

                            <div class="startDate">
                                <label for="startDate">이벤트 시작일<b style="color : red;">*</b></label> <input type="date" id="startDate" min="" name="startDate"></input>
                            </div>

                            <div class="endDate">
                                <label for="endDate">이벤트 종료일<b style="color : red;">*</b></label><input type="date" id="endDate" min="" name="endDate"></input>
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
                            <textarea id="content" name="eventContent"></textarea>
                        </div>

                        <!-- 사진첨부 -->
                        <div class="fileArea">
                            <label for="fileInput" id="file">사진<br>첨부<b style="color : red;">*</b></label>
                            
                            <img id="contentImg1" src="#" alt="Preview Image 1" data-target="file1" />
							<img id="contentImg2" src="#" alt="Preview Image 2" data-target="file2" />
							<img id="contentImg3" src="#" alt="Preview Image 3" data-target="file3" />
							<img id="contentImg4" src="#" alt="Preview Image 4" data-target="file4" />
                            
                            <!-- 파일 입력받는 요소  -->
                            <div id="file-area" style="display : none;">
	                            <!-- 썸네일은 필수입력사항으로 지정 -->
	                            <input type="file" id="file1" name="upfiles" data-index="1" onchange="loadImg(this);" multiple required>
								<input type="file" id="file2" name="upfiles" data-index="2" onchange="loadImg(this);" multiple>
								<input type="file" id="file3" name="upfiles" data-index="3" onchange="loadImg(this);" multiple>
								<input type="file" id="file4" name="upfiles" data-index="4" onchange="loadImg(this);" multiple>
                            </div>
                            
                            
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
                                    댓글<input type="radio" name="eventType" value="1" required>
                                    응모버튼<input type="radio" name="eventType" value="2" required>
                                    오프라인<input type="radio" name="eventType" value="3" required>
                                </div>
                            </div>

                            <div class="status">
                                <div style="margin-top: 2px;">이벤트 종료 여부<b style="color : red;">*</b></div>
                                <div id="eventStatus">
                                    진행중인 이벤트<input type="radio" name="eventStatus" value="N" required> <!-- N 으로 변경 -->
                                    종료된 이벤트<input type="radio" name="eventStatus" value="Y" disabled>  <!-- Y 으로 변경 -->
                                </div>
                            </div>
                        
                            <!--등록, 취소 버튼-->
                            <div class="btn">
                                <button id="cancle" style="width : 100px; margin-right : 5px;" onclick="history.back()">취소</button>
                                <button type="submit" id="submit" style="width : 130px;" onclick="setCouponData()">등록</button>
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
        
        previewImg.addEventListener('click', () => {
            // console.log(`contentImg${index} clicked`);
        });

        if (!previewImg) {
            console.error(`Image element with id 'contentImg${index}' not found.`);
            return;
        }

        if (file && file.type.startsWith("image/")) {
            // console.log("Selected File:", file); // 단일 로그
            const reader = new FileReader();
            reader.onload = function (e) {
                previewImg.src = e.target.result;
            };
            reader.readAsDataURL(file);
        } else {
            alert("이미지 파일만 선택 가능합니다.");
        }
    }

        document.addEventListener('DOMContentLoaded', function() {
            const fileInputs = document.querySelectorAll('input[name="upfiles"]');
            fileInputs.forEach((input, index) => {
                input.addEventListener('change', function() {
                    loadImg(input, index + 1);  // 1부터 시작하도록 index + 1
                });
            });
        });
        
        // 쿠폰 데이터 넘기는 스크립트 
        function setCouponData() {
	    // 서버에서 받은 값을 JavaScript 변수에 할당
	    var couponNo = "${requestScope.c.couponNo}"; // 쿠폰 번호 (서버에서 전달받은 값)
	    var refEno = "${requestScope.e.eventNo}"; // 이벤트 번호 (서버에서 전달받은 값)
	    var couponName = "${requestScope.e.eventTitle}"; // 이벤트 제목 (쿠폰 이름)
	    var couponLevel = "${requestScope.c.couponLevel}"; // 쿠폰 레벨 (서버에서 전달받은 값)
	    var couponExpDate = "${requestScope.c.couponExpDate}"; // 만료일 (서버에서 전달받은 값)
	    var couponStatus = "${requestScope.c.couponStatus}"; // 쿠폰 상태 (서버에서 전달받은 값)
	
	    
	    
	    console.log("couponExpDate : " + couponExpDate);
	    
	    
	    // hidden input에 쿠폰 정보 설정
	    document.getElementById("couponNo").value = couponNo;
	    document.getElementById("refEno").value = refEno;
	    document.getElementById("couponName").value = couponName;
	    document.getElementById("couponLevel").value = couponLevel;
	    document.getElementById("couponExpDate").value = couponExpDate;
	    document.getElementById("couponStatus").value = couponStatus;
	
	    // 폼 제출
	    document.getElementById("eventForm").submit(); // 폼 ID가 "eventForm"이면 이를 사용하여 제출
	}
    </script>
</body>
</html>