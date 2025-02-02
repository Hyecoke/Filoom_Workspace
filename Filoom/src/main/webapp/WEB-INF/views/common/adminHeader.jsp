<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
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
	    margin-top: 3px;
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
	

</style>
</head>
<body>
	<div id = "navbar">
            
            <div id = "logo">
                <img src="resources/images/icons/Filoom.png">
            </div>
           
            <div id = "nav">
                <ul>
                	<li><a href="/filoom/ad.li">관리자메인</a></li>
                    <li><a href="memberList_ad.me">회원 관리</a></li>
                    <li><a href="movielist_ad.mo">영화 관리</a></li>
                    <li><a href="/filoom/adminBooking.ad">예약 관리</a></li>
                    <li><a href="/filoom/alist.no">공지 관리</a></li>
                    <li><a href="/filoom/alist.ev">이벤트 관리</a></li>
                </ul>
    
            </div>
        </div>
</body>
</html>