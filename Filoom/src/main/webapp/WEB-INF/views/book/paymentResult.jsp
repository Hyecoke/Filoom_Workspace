<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>paymentResult</title>
</head>
<style>


body{
    background-color: black;
    color:gray;
    
}

#outer{
    width:60%;
    background-color: #222222;
    /* border:1px dashed #696868; */
    margin: auto;
    padding: 5%;
    
}




/* ==========================예매내역 영역====================== */


#message{
    /* border: 1px solid blue; */
    
    font-size: 40px;
    text-align: center;
    border-bottom: 1px solid gray;
    padding-bottom: 3%;

}

 /* 예매내역 영영 */
#bookInfoArea{
    display:flex;
    margin-right: 3%;
    margin-left: 3%;
    /* border:1px solid red; */
}

#bookInfoArea>div{
    margin:3%;
    
}
/* 이미지 영역 */
#imgArea{
    /* border: 1px solid yellow; */
    width:35%;
    text-align: center;
}
#imgArea>img{
    width: 100%;
}

/* 예매내역정보 */
#bookArea{
    /* border:1px solid white; */
    width:70%;
}

/* 영화이름 */
#movieName{
    font-size: 50px;
    border-bottom: 1px solid gray;
    padding-bottom: 1%;
}
/* 영화상영정보 */
#playingInfo{
    /* border:1px solid red; */
    padding: 3%;
}

/* 예매정보 테이블 */
#playingInfo>table td{
    width:30%;
    height: 50px;
}

/* 예매정보 테이블 td들 */
#playingInfo td:nth-child(1),
#playingInfo td:nth-child(3){

    font-size: 25px;
    font-weight: lighter;
    color:gainsboro;
}

#playingInfo td:nth-child(2),
#playingInfo td:nth-child(4){
    font-size: 20px;
    font-weight: bolder;
}


/* 결제내역 정보 */
#paymentInfo{
    border:1px solid white;
    margin-left: 3%;
    margin-right: 3%;
    padding:3%;
}

#paymentInfo>div{
    padding:3%;
}

#paymentInfo>div>div:nth-child(1){
    /* color:red; */
    font-size: 25px;
    font-weight: bolder;
    border-bottom: 1px solid white;
    padding-bottom: 1%;
}

/* 결제내역 정보 테이블 */
#paymentInfo table{
    padding:3%;
}
#paymentInfo td:nth-child(1){
    width: 50%;
    color:gainsboro;

    /* border: 1px solid yellow; */
}

#paymentInfo td:nth-child(2){
    font-weight: bold;
}

/* 총결제금액 */
#totalPrice{
    /* padding-left: 3%; */
    text-align: center;
}
#totalPrice>span:nth-child(1){

    display: inline-block;
    /* width:40%; */
}

#totalPrice>span:nth-child(2){
    /* color:red; */
    font-weight: bolder;
    font-size: 25px;
}

#paymentInfo>div{

    /* border:1px solid yellow; */
}

#paymentInfo>div>div{
    /* border:1px solid blue; */
}










/*========================== 버튼========================== */
#btnArea{
    text-align: center;
}

/* 버튼 */
#btnArea>button{
    width:15%;
    height:70px;
    background-color: #ab886d;
    border: none;
    border-radius: 5%;
    color:white;
    font-weight: bolder;
}
/* 버튼 호버 기능 */
#btnArea>button:hover{
    border: 3px solid white;
    opacity: 90%;
}



/*========================== 안내글 영역=================== */
#comment{
    
    margin:5%;
    padding:3%;
    color:gray;
}
#comment>div{
    width:70%;
    border: 1px solid gray;
    margin: auto;
    padding: 7%;
    
    
}


</style>
<body>
	<jsp:include page="../common/header.jsp" />	
    
    <div id="outer">
        <!-- 예매/결제 내역 div -->
        <div>
            <div id="message"> "${sessionScope.loginUser.userName}" 회원님, 결제가 성공적으로 완료되었습니다.  </div>
            <div id="bookInfoArea">
                <div id="imgArea">
                     <img src="${pageContext.request.contextPath}/resources/images/posters/${requestScope.movie.fileCodename}" alt="영화이미지" width="100%" />
                </div>
                <div id="bookArea">
                    <div id="movieName">
                    	<span>
                        	<img src="resources/images/posters/${requestScope.movie.filmRate}.svg" height="25px">	
                        </span>
                        <span>${requestScope.movie.movieTitle}</span>
                    </div>
                    <div id="playingInfo">
                        <table>
                            <tr>
                                <td>예매번호</td>
                                <td>${requestScope.booking.bookNo}</td>
                                <td>관람인원</td>
                                <td>${requestScope.bookingSeatList.size()}</td>
                            </tr>
                            <tr>
                                <td>상영관</td>
                                <td>${requestScope.movie.screenName}</td>
                                <td>관람좌석</td>
                                <td>
                                <c:forEach  items="${requestScope.bookingSeatList}" var="item">
                                	'${item.seatNo}'
                                </c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <td>관람일</td>
                                <td colspan="3">
                                	<div id="playDate">${requestScope.movie.playTime}</div>
                                	<%-- <div>${requestScope.movie.runtime}</div> --%>
                                </td>
                            </tr>
                            <tr>
                            	<td>상영시간</td>
                            	<td colspan="3">
                            		<div id="playTime"></div>
                            </tr>
                        </table>

                    </div>
                    <div id="paymentInfo">
                        <div>
                            <div>결제내역</div>
                            <div>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td>결제금액</td>
                                            <td>${requestScope.booking.bookTotalCost}원</td>
                                        </tr>
                                       	<c:if test="${not empty requestScope.couponUserList}">
	                                        <tr>
	                                            <td>영화쿠폰 </td>
	                                            <td>
													<c:forEach items="${requestScope.couponUserList}" var="item">
														'${item.couponName}'
													</c:forEach>
												</td>
	                                        </tr>
	                                        <tr>
	                                        	<td>할인금액</td>
	                                        	<td>${requestScope.booking.bookCost-requestScope.booking.bookTotalCost}원</td>
	                                        </tr>
                                        </c:if>
                                        <tr>
                                            <td>결제일시</td>
                                            <td id="payTime">${requestScope.booking.bookDate}</td>
                                        </tr>
                                        <tr>
                                            <td>결제방식 </td>
                                            <td>${requestScope.booking.costProcess}</td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colcapn="2"></td>
                                        </tr>
                                    </tfoot>
                                </table>
                                <div></div>
                                <div></div>
                                <div></div>
                                <div></div>
                            </div>
                            <div id="totalPrice">
                                <span>총결제 금액</span> 
                                <span>${requestScope.booking.bookCost}</span>
                            </div>
                        </div>

                    </div>    
                </div>
            </div>
        </div>
        

        
        
        

        <!-- 버튼 영역 -->

        <div id="btnArea">
            <button onclick="location.href='${request.contextPath}/filoom'">메인화면</button>
            <button onclick="canelRequest(${requestScope.booking.bookNo})">예매취소</button>
        </div>
        <!-- 안내글 영역 -->
        <div id="comment">
             <!-- if 문 19 영화-->
            <div id="comment2">
                   
                    
                        
 <!--                        <ul>
                            <li>본 영화는 만 19세 이상 관람 가능한 영화입니다.</li>
                            <li>연령 확인 불가 시 입장이 제한될 수 있습니다.</li>
                            <li>※ 연령 확인 수단 (사진,캡쳐본 불가) : 학생증, 모바일 학생증, 청소년증, 여권</li>
                        </ul>
                    if 문
                    관람 전 반드시 확인 하세요! 
                        <ul>
                            <li>본 영화는 만 (12)세 이상 관람 가능한 영화입니다.</li>
                            <li>만 (12)세 미만 고객은 만 19세 이상 성인 보호자 동반 시 관람이 가능합니다. 연령 확인 불가 시 입장이 제한될 수 있습니다.</li>
                            <li>※ 연령 확인 수단 (사진,캡쳐본 불가) : 학생증, 모바일 학생증, 청소년증, 여권</li>
                        </ul> -->


                   
                        <ul>
                            <li>쾌적한 관람 환경을 위해 상영시간 이전에 입장 부탁드립니다.</li>
                            <li>입장 지연에 따른 관람 불편을 최소화하기 위해 본 영화는 10분 후 상영이 시작됩니다.</li>
                        </ul>
                        
                        취소 및 환불 규정
                        <ul>
                            <li>상영시간 전까지 취소 가능하며, 캡쳐화면으로는 입장하실 수 없습니다.</li>
                            <li>현장에서 직접 방문하실 경우 상영시간 전까지 취소하실 수 있습니다.</li>
                            <li>상영시간 이후 취소/환불/결제수단 변경은 불가합니다.</li>

                        </ul>

                    주차안내
                        <ul>
                            <li>지하주차장 이용, 영화관람 시 3시간 무료 (초과 시 10분당 1,000원 부과)</li>
                            <li>당일관람 영화티켓 하단 주차바코드를 이용하여 주차장 무인정산기 또는 출차 시 주차게이트에서 정산</li>
                        </ul>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />
</body>

<script>



	let bookingUserList = "${requestScope.couponUserList}";
	let bookNo = "${requestScope.bookNo}";
	let booking = "${requestScope.booking}";
	console.log("콘솔실행");
	console.log(bookingUserList);
	console.log(booking);
	
	const playTime = "${requestScope.movie.playTime}";
	const runTime = "${requestScope.movie.runtime}";
	$(function(){	
		showMovieDate(playTime);
		showPlayTime(playTime,runTime);
		showPayTime()
	});
	
	
	function canelRequest(bookNo){
		
		let cancelConfirm = confirm("예메를 취소 하시겠습니까 ? ");
		if(cancelConfirm){
			$.ajax({
				url:"cancelRequest.pm",
				type:"post",
				data:{bookNo:bookNo},
				success:function(result){
					console.log("결제취소요청성공-ajax")
					console.log(result);
					if(result==="success"){
						alert("결제가 취소되었습니다. ");
						location.href = '${request.contextPath}/filoom/reserve.me';
					}else{
						alert("죄송합니다. 상영시간 이후 취소/환불은 불가합니다.)")
						
					}
					
				},
				error:function(){
					console.log("결제취소요청실패-ajax")
				}
			});
		}
	}
	
	/* <td id="payTime">${requestScope.booking.bookDate}</td> */
	
	function showPayTime(){
	
		let bookDate = "${requestScope.booking.bookDate}";
		bookDate2 = bookDate.substring(0,16);
		$("#payTime").text(bookDate2);
	}
	
	
	// 영화상영날짜 뿌려주기 
	function showMovieDate(playTime){
		
		let date = dateTimeToDate(playTime);
	
		$("#playDate").text(date);
	}
	
	
	//날짜시간(문자열) -> 년,월,일, 요일 
	function dateTimeToDate(dateString){
		
		let playTimeObj = new Date(dateString);
		let yyyy = playTimeObj.getFullYear();
		
        let mm = String(playTimeObj.getMonth()+1).padStart(2,'0');
        let dd = String(playTimeObj.getDate()).padStart(2,'0');
        
        const daysOfWeek = ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"];
        let dayOfWeek = daysOfWeek[playTimeObj.getDay()];
        
        let date =yyyy + "년 " + mm + "월 "+dd+"일 "+ dayOfWeek;
		
        return date;
		
	};
	
	
	//날짜시간+러닝타임 -> 시작시간~종료시간
	function showPlayTime(playTime, runTime){
		
		let startTime = playTime.substring(11,16);
		console.log(startTime);
		let [hours, minutes] = startTime.split(":").map(Number);

		minutes += +runTime; //숫자로써 계산 문자열앞에+			
	
		hours += Math.floor(minutes/60);	
		
		minutes %=60;
		
		hours %= 24
		
		let endTime = String(hours).padStart(2,"0")+":"+String(minutes).padStart(2,"0");
		
		let moviePlayTime = startTime + " ~ " + endTime;
		
		$("#playTime").text(moviePlayTime);
			
		
	}

	
	
	
</script>
</html>