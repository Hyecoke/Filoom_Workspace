<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>꿈을 담는 공간, Filoom</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <style>
        /* === Overall Font === */
        * {
            font-family: "Poppins", sans-serif;
        }

        body {
            background-color: #151515;
        }
        
        /* === 내부 div === */
        .backStage {
            background-color: #313131;
            color:white;
            width:1324px;
            margin:auto;
            border-radius:5px;
        }

        .backStage #title>* {
            display:inline;
        }

        .backStage h1 {
            font-size:45px;
            padding-left:40px;
            margin-top:20px;
        }

        #showMore {
            text-align:right;
            padding-left:20px;
            color:white;
            text-decoration:none;
        }

        .middle>a {
            text-decoration: none;
            color:white;
        }
        .middle>a:hover {
            color:black;
        }

        .search-bar {
            font-style:italic;
        }

        .poster {
            width:240px;
            /* height:480px; */
            border-radius:5px;
            margin-bottom:5px;
        }
        .poster:hover {
        	cursor:pointer;
        }

        #filmrate {
            width:50px;
        }
        .filmrate {
            width:45px;
        }

        /**/

        .movie {
            display:inline-block;
            /* 이걸로 충분함. 굳이 4x4를 고민할 필요 없음 */
            margin:10px 30px;
            /* font-size:24px; */
            text-align:left;
        }
        .movie:hover {
        	cursor:pointer;
        }

        .movie-info {
            font-size:20px;
        }
        
        .box-is-empty {
        	filter:invert(100%) sepia(100%) saturate(2%) hue-rotate(74deg) brightness(104%) contrast(101%)
        }

    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="backStage">
        
        <div class="movie-pool" align="center">
            <div id="title" align="left">
                <h1 align="left">박스 오피스</h1>
                <a id="showMore" href="boxoffice.mo">
                    더 보기 &gt;&gt;
                </a> 
            </div>
            <hr style="width:95%;">
            <br>
            
            <c:choose>
            	<c:when test="${not empty now}">
					<c:forEach var="pic" items="${now}">
		            	<div class="movie" onclick="location.href='detail.mo?movieNo=${pic.movieNo}';">
			                <img src="${pageContext.request.contextPath}/resources/images/posters/${pic.fileCodename}" class="poster">
			                <table class="movie-info">
			                    <tr>
			                        <td id="filmrate"><img src="resources/images/posters/${pic.filmRate}.svg" class="filmrate"></td>
			                        <td><b>${pic.movieTitle}</b><br></td>
			                    </tr>
			                    <tr>
			                        <td colspan="2">${pic.openDate} ${pic.premiere eq 'Y' ? '개봉' : '개봉예정'} </td>
			                    </tr>
			                </table>
		            	</div>
		            </c:forEach>
            	</c:when>
            	
            	<c:otherwise>
            		<img src="resources/images/icons/projector-128px.svg" class="box-is-empty">
            		<br>준비된 영화가 없습니다.
            	</c:otherwise>
            </c:choose>


        </div>
        <br><br>

        <div class="movie-pool" align="center">
            <div id="title" align="left">
                <h1>개봉 예정작</h1>
                <a id="showMore" href="preopen.mo">
                    더 보기 &gt;&gt;
                </a> 
            </div>
            <hr style="width:95%;">
            <br>

			<c:choose>
				<c:when test="${not empty pre}">
					<c:forEach var="pic" items="${pre}">
		            	<div class="movie" onclick="location.href='detail.mo?movieNo=${pic.movieNo}';">
			                <img src="${pageContext.request.contextPath}/resources/images/posters/${pic.fileCodename}" class="poster">
			                <table class="movie-info">
			                    <tr>
			                        <td id="filmrate"><img src="resources/images/posters/${pic.filmRate}.svg" class="filmrate"></td>
			                        <td><b>${pic.movieTitle}</b><br></td>
			                    </tr>
			                    <tr>
			                        <td colspan="2">${pic.openDate} 개봉예정 </td>
			                    </tr>
			                </table>
		            	</div>
		            </c:forEach>
				</c:when>
				
				<c:otherwise>
					<img src="resources/images/icons/projector-128px.svg" class="box-is-empty">
					<br>상영을 앞둔 영화가 없습니다.
				</c:otherwise>
			</c:choose>

        </div>
        <br><br>
        
    </div>

    <br><br>

    <jsp:include page="../common/footer.jsp" />
    
</body>
</html>