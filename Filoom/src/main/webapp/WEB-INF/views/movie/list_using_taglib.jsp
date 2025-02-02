<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
			<input type="hidden" id="first" value="${requestScope.pi.startPage}">
			<input type="hidden" id="last" value="${requestScope.pi.endPage}">
			<input type="hidden" id="MX" value="${requestScope.pi.maxPage}">
            <c:forEach var="pic" items="${box}">
            	<div class="movie" onclick="location.href='detail.mo?movieNo=${pic.movieNo}';">
	                <!-- <img src="resources/images/posters/moana.jpg" class="poster"> -->
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
</body>
</html>