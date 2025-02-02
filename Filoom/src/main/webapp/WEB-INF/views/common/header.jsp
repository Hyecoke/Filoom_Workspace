<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FILOOM</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}
        
#header {
   
   margin: auto;
   z-index: 1000;
   width: 100%;
   margin: 30px 0 50px 0;
   opacity: 90%;
   /*background-color: aqua;*/
}


#header_top {

   width: 100%;
   display: flex; 
   align-items: center;
   justify-content: space-between; 
   padding: 0 20px;
   border-bottom: 3px solid #E4E0E1;
}


.logo {

   margin: 0;
   font-size: 50px; 
   font-weight: bold; 
   color: #E4E0E1; 
   text-decoration: none; 
   font-family: 'Arial', sans-serif;
	pointer: cursor;
}


#header_top ul {
  
   list-style: none;
   display: flex;
   margin: 0;
   padding: 0;
   align-items: center;
  
}

#header_top ul li {
   
   margin: 0 15px;
   width: auto;
   font-size: 25px;
   color: #E4E0E1;
   cursor: pointer;
   transition: color 0.3s ease;
   font-weight: bolder;
  
}

#header_top ul li a {
	color: #E4E0E1;
	text-decoration: none;
	transition: color 0.3s ease;
}

#header_top li>a {
	text-decoration: none; 
   	color: #8B8B8B;
}


#header_top ul li:hover, #header_top ul li a:hover {
   color: #493628; 
}


/* 아래는 하단 네비바 */

#header_bottom {
   margin: auto;
   width: 100%;
   height: 70px;
   display: flex; 
   align-items: center; 
   justify-content: center;
   border-bottom: 3px solid #E4E0E1;
}

#header_bottom ul {
   list-style: none; 
   display: flex;
   margin: 0;
   padding: 0;
   cursor: pointer;
}

#header_bottom li {
   margin: 0 60px; 
   text-decoration: none; 
   color: #8B8B8B; 
   font-size: 40px; 
   font-weight: bold; 
   transition: color 0.3s ease, transform 0.3s ease;
   
}

#header_bottom li>a {
	text-decoration: none; 
   	color: #8B8B8B;
}


#header_bottom li:hover {
   color: #493628; 
   transform: scale(1.1); 
}

#header_bottom li>a:hover {
	text-decoration: none; 
   	color: #493628;
   	transform: scale(1.1); 
}



    </style>
</head>
<body>

	<!-- alertMsg 구문 -->
	<script>
		if("${sessionScope.alertMsg}" != ""){
			alert("${sessionScope.alertMsg}");		
		}
	</script>
	<c:remove var="alertMsg" scope="session"/>
	
	
	
	<div id = "header">
        <div id = "header_top">

            <ul>
   
               <li><a href="${ pageContext.request.contextPath }/list.no">공지사항</a></li> &nbsp;&nbsp;&nbsp;&nbsp;
               <li><a href="${ pageContext.request.contextPath }/list.fa">문의</a></li>

         	</ul>


			<c:choose>
				<c:when test="${ empty sessionScope.loginUser }">
	                <!-- 로그인 전 -->
	                <ul>
		                <a class="logo"  href="${ pageContext.request.contextPath }">Filoom</a>
	                </ul>
	            </c:when>
	            <c:otherwise>    
	                <!-- 로그인 후 -->
	                <ul>
	                   	<a class="logo" style="margin-left:30px;" href="${ pageContext.request.contextPath }">Filoom</a>
	                   </ul>
	            </c:otherwise>
        	</c:choose>
        	
			<c:choose>
				<c:when test="${ empty sessionScope.loginUser }">
	                <!-- 로그인 전 -->
	                <ul>
		                <li><a href="${ pageContext.request.contextPath }/loginForm.me">로그인</a></li> &nbsp;&nbsp;&nbsp;&nbsp;
		                <li><a href="${ pageContext.request.contextPath }/enrollForm.me">회원가입</a></li>
	                </ul>
	            </c:when>
	            <c:otherwise>    
	                <!-- 로그인 후 -->
	                <ul>
                    	<li><a href="${ pageContext.request.contextPath }/profile.me">마이페이지</a></li> &nbsp;&nbsp;&nbsp;&nbsp;
                    	<li><a href="${ pageContext.request.contextPath }/logout.me">로그아웃</a></li>
                    </ul>
	            </c:otherwise>
            </c:choose>

        </div>

        <div id = "header_bottom">
            <ul>
                <li><a href="${ pageContext.request.contextPath }/movies.mo">영화</a></li>
               
                 <c:choose>
		            <c:when test="${ empty sessionScope.loginUser }">
		                <!-- 로그인 전 -->
		                <li><a href="javascript:void(0);" onclick="requireLoginAlert();">예매</a></li>
		            </c:when>
		            <c:otherwise>
		                <!-- 로그인 후 -->
		                <li><a href="${ pageContext.request.contextPath }/book.do">예매</a></li>
		            </c:otherwise>
		        </c:choose>
                
                <li><a href="${ pageContext.request.contextPath }/list.ev">이벤트</a></li>

            </ul>
        </div>

    </div>
    
    <script>
    	function requireLoginAlert() {
		    alert("로그인이 필요한 기능입니다!");
		}
    </script>
</body>
</html>