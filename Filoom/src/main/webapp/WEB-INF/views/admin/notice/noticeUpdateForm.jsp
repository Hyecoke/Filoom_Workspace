<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 공지사항 글수정</title>
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
    #title {
        font-size: 25px;
        font-weight: bold;
        color : #493628;
        padding : 27px 20px;
        margin-bottom: 10px;
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
        gap : 15px;
    }

    .content {
        padding: 10px;
        display : flex;
        align-items: center;
        gap : 10px;
    }

    #nTitlearea, #nContentarea {
        font-size: 28px;
        font-weight: bold;
        color : #493628;
        padding-left : 5px;
        display: flex;
        justify-content: left;
        gap : 10px;
        margin-left: 5px;
    }

    #ntitle, #ncontent {
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
        resize: none;
    }

    #ntitle {
        width : 1304px;
    }

    /*버튼*/
    .btn {
        padding-right : 13px;
        text-align: right;
        box-sizing: border-box;
    }

    #check {
        transform: scale(1.5,1.5);
        margin-right: 20px;
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

                <!-- 혜원 - 관리자 공지사항 글작성-->
                <div id = "admin_title_content">
                    <div id="title">공지사항 글 수정</div>
                    <div id="sub">체크(<b style="color : red;">*</b>)된 항목은 필수 입력사항입니다.</div>
                </div>
            </div>
            
                <div id = "admin_detail">                
                    <!-- 혜원 목록테이블 -->
                    <div id ="admin_page">
                        <!--이건 버튼 이랑 text 샘플
                        <input type ="text" id ="text_sample">
                        <input type="button" id ="button_sample" value="샘플">-->
                        <form id="updateForm" action="update.no" method="post">
                        <input type="hidden" name="noticeNo" value="${requestScope.n.noticeNo }">
                            <!--제목-->
                            <div class="title_date_count">
                                <div id="nTitlearea">
                                    <label for="title">제목<b style="color : red;">*</b></label><input type="text" id="ntitle" name="noticeTitle" value="${requestScope.n.noticeTitle }" required>
                                </div>
                            </div>

                            <!-- 내용 -->
                            <div class="content">
                                <div id="nContentarea">
                                    <label for="content">내용<b style="color : red;">*</b></label><textarea id="ncontent"  name="noticeContent" required>${requestScope.n.noticeContent }</textarea>
                                </div>
                            </div>

                            <!--등록, 취소 버튼-->
                            <div class="btn" style="font-size: 20px; font-weight: bold;">
                                <!--게시물 상단 고정 <input id="check" type="checkbox">-->
                                <button id="cancle" style="width : 100px; margin-right : 5px;" onclick="javascript:history.go(-1);">취소</button>
                                <button type="submit" id="submit" style="width : 130px;">수정</button>
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