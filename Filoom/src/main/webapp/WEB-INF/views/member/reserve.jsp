<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예매 내역 조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	/* 기본 스타일 초기화 */
	* {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	}
	
	body {
	    font-family: Arial, sans-serif;
	    background-color: #121212;
	    color: #ffffff;
	}
	
	/* 마이페이지 컨테이너 */
	.mypage-container {
	    display: flex;
	    width: 1100px;
	    background-color: #1e1e1e;
	    border-radius: 10px;
	    padding: 50px;
	    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
	    overflow: hidden;
	    margin: 50px auto;
	}
	
	/* 사이드바 */
	.mypage-sidebar {
	    width: 20%;
	    padding: 10px;
	}
	
	.mypage-sidebar h2 a {
	    color: #fff; /* 흰 글씨 */
	    font-size: 20px; /* 큰 폰트 크기 */
	    font-weight: bold; /* 굵은 폰트 */
	    text-decoration: none; /* 밑줄 제거 */
	    display: block;
	    margin-bottom: 30px; /* 아래 간격 */
	}
	
	.menu-list {
	    list-style: none;
	    padding: 0;
	    margin: 0;
	}
	
	.menu-list li a {
	    color: #aaa; /* 기본 회색 글씨 */
	    font-size: 14px; /* 작은 폰트 크기 */
	    font-weight: normal; /* 얇은 폰트 */
	    text-decoration: none; /* 밑줄 제거 */
	    display: block;
	    padding: 10px 0; /* 상하 간격 */
	    transition: color 0.3s ease;
	}
	
	.menu-list li.active a {
	    color: #fff; /* 흰 글씨 */
	    font-size: 16px; /* 작지만 조금 큰 폰트 크기 */
	    font-weight: bold; /* 굵은 폰트 */
	}
	
	.menu-list li a:hover {
	    color: #ffffff;
	    font-weight: bold;
	}
	
	/* 콘텐츠 영역 */
	.mypage-content {
	    width: 80%;
	    padding: 10px;
	}
	
	.reserve-header {
		display: flex;
		border-bottom: 1px solid #333;
		margin-bottom: 30px;
	    padding-bottom: 10px;
		align-items: center;
	}

	.reserve-header h1 {
	    font-size: 24px;
	    font-weight: bold;
	}
	
	.reserve-header p {
	    font-size: 14px;
	    margin-left: 12px;
	    color: #aaa;
	}

	.reserve-list {
	    padding: 10px 20px;
	}
	
	.reserve-item {
	    border-bottom: 1px solid #aaa;
	    padding-bottom: 20px;
	    margin-bottom: 50px;
	}
	
	.box-info {
	    display: flex;
	    gap: 10px; /* 좌우 박스 간 간격 */
	}
	
	.poster {
	    width: 90px;
	    height: 140px;
	    margin-right: 20px;
	}
	
	.reserve-info,
	.title-price,
	.reserve-content ul {
	    overflow: hidden;
	}
	
	.reserve-info {
	    width: 100%;
	    display: flex;
	    flex-direction: column; /* 상하 배치 */
	    margin-top: 15px;
	}
	
	.title-price {
	    width: 100%;
	    display: flex;
	    justify-content: space-between;
	    border-bottom: 1px solid white;
	    padding-bottom: 13px;
	    padding-right: 20px;
	    margin-bottom: 20px;
	}
	
	.movie-title {
	    text-decoration: none;
	    color: #fff;
	    font-weight: bold;
	}
	
	.cancel-btn, .review-btn {
		background: none;
		border: none;
		color: #aaa;
		cursor: pointer;
		font-size: 12px;
		margin-left: 5px;
		transition: color 0.3s ease;
	}

	.cancel-btn:hover, .review-btn:hover {
	    color: #fff;
	    font-weight: bold;
	}
	
	/* 전체 예약 내용 컨테이너 */
	.reserve-content {
	    display: flex;
	    justify-content: space-between; /* 좌우로 정렬 */
	    flex-wrap: wrap; /* 두 줄로 나뉘도록 설정 */
	    gap: 10px; /* 아이템 간격 */
	    font-size: 14px;
	}
	
	/* ul 스타일 초기화 */
	.reserve-content ul {
	    list-style: none;
	    padding: 0;
	    margin: 0;
	    display: flex;
	    flex-wrap: wrap; /* 두 줄로 정렬되게 설정 */
	    gap: 15px; /* 각 아이템 간 간격 */
	    width: 100%; /* 전체 너비 차지 */
	}
	
	/* 각 li 아이템 */
	.reserve-content ul li {
	    flex: 1 1 calc(50% - 20px); /* 너비를 반으로 설정 */
	    display: flex;
	}
	
	/* dl 태그 스타일 */
	.reserve-content dl {
	    display: flex;
	    justify-content: space-between; /* 제목과 내용 좌우 배치 */
	    width: 100%;
	}
	
	/* dt와 dd 스타일 */
	.reserve-content dt {
	    color: #a5a5a5; /* 제목 글자 색 */
	    text-align: left; /* 제목 왼쪽 정렬 */
	}
	
	.reserve-content dd {
	    color: #ffffff; /* 내용 글자 색 */
	    flex-basis: 75%; /* 내용 너비 */
	}
	
	.payment-info {
	    margin-top: 32px;
	    margin-bottom: 30px;
	    padding-left: 120px;
	}
	
	.payment-info h4 {
	    margin-bottom: 10px;
	    font-size: 16px;
	}
	
	.reserve-payment {
	    border: 1px solid #aaa;
		border-radius: 4px;
	    padding: 20px;
		box-shadow: 5px 5px 5px 5px rgba(0, 0, 0, 0.5);
	}
	
	.final-price {
	    display: flex;
	    justify-content: space-between;
	    border-bottom: 1px solid white;
	    margin-bottom: 15px;
	    padding-bottom: 20px;
	    font-size: 14px;
	    font-weight: bold;
	}
	
	.total-price, .coupon-discount, .payment-method {
	    display: flex;
	    justify-content: space-between;
	    font-size: 14px;
	}

	.total-price , .coupon-discount {
		padding: 5px 0;
	}

	.coupon-discount {
		font-size: 12px;
	}

	.payment-method {
		border-top: 1px solid white;
		margin-top: 15px;
		padding-top: 15px;
	}
	
	.btn_incomeDeduction {
	    display: flex;
	    justify-content: space-between;
	    margin-top: 25px;
	}
	
	.btn_incomeDeduction span {
	    font-size: 12px;
	    font-weight: bold;
	}
	
	.open-content-btn {
	    background: none;
	    border: none;
	    color: #aaa;
	    cursor: pointer;
	    font-size: 12px;
	}
	
	.incomeDeduction-content {
	    display: none;
	}
	
	.incomeDeduction-content h6 {
	    font-size: 12px;
	    font-weight: bold;
	    margin-top: 16px;
	    margin-bottom: 10px;
	}
	
	.incomeDeduction-content .first-content, 
	.incomeDeduction-content p,
	.incomeDeduction-content>ul>li {
	    font-size: 11px;
	    margin-top: 5px;
	}
	
	.incomeDeduction-content .first-content{
	    margin-top: 14px;
	}
	
	.incomeDeduction-content>ul>li {
	    margin-left: 16px;
	}
	
	.msg-expired {
	    text-align: right;
	    font-size: 13px;
	    font-weight: bold;
	    color: #fb4357;
	    /* display: none; */
	}
	
	.cancel-header {
	    display: flex;
	}
	
	.cancel-header h4 {
	    font-size: 14px;
	}
	
	.cancel-header p {
	    font-size: 12px;
	    margin-left: 10px;
	    color: #aaa;
	    line-height: 24px;
	}
	
	.cencel-content table {
	    width: 100%;
	    text-align: center;
		border-collapse: collapse;
		font-size: 14px;
	}
	
	.cencel-content thead {
	    background-color: #444;
		font-weight: 300;
		color: #999;
	}
	
	.nodata {
	    padding: 50px 0;
	    font-size: 14px;
	    color: #aaa;
	}

	.cancel-data>td {
		padding: 10px;
		border-bottom: 1px solid #aaa;
		height: 60px;
	}

	.sect-box-descri {
	    margin-top: 70px;
	    border: 1px solid #aaa;
	}
	
	/* 컨테이너 스타일 */
	.sect-box-descri {
	    padding: 20px; /* 내부 여백 */
	    line-height: 1.6; /* 줄 간격 */
	}
	
	/* 리스트 스타일 초기화 */
	.sect-box-descri ul {
	    list-style-type: none; /* 기본 불릿 제거 */
	    padding-left: 0;
	    margin: 0;
	}
	
	/* 첫 번째 리스트 아이템 */
	.sect-box-descri > ul > li {
	    margin-bottom: 20px;
	}
	
	/* 정의 리스트 스타일 */
	.sect-box-descri dl {
	    margin: 0;
	}
	
	.sect-box-descri dt {
	    font-weight: bold; /* 제목 강조 */
	    font-size: 14px; /* 제목 글자 크기 */
	    margin-bottom: 10px;
	    color: #fff;
	}
	
	.sect-box-descri dd {
	    margin: 0;
	    font-size: 12px;
	    color: #aaa; /* 글자색 */
	}
	
	.sect-box-descri strong {
	    color: #fff;
	}
	
	/* 내부 리스트 스타일 */
	.sect-box-descri dd ul {
	    list-style-type: disc; /* 불릿 형태 */
	    margin-left: 20px; /* 들여쓰기 */
	}
	
	.sect-box-descri dd ul li {
	    margin-bottom: 10px;
	}
	
	.no-reserve {
		padding: 10px 0 100px 0;
		text-align: center;
		font-size: 20px;
		/* font-weight: bold; */
    	color: #aaa;
	}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp" />

    <div class="mypage-container">
        <div class="mypage-sidebar">
            <h2><a href="#">마이 페이지</a></h2>
            <ul class="menu-list">
                <li><a href="profile.me">내 정보</a></li>
                <li><a href="coupon.me">쿠폰 조회</a></li>
                <li class="active"><a href="reserve.me">예매 내역 조회</a></li>
                <li><a href="history.me">내가 본 영화 조회</a></li>
                <li><a href="favorite.me">보고 싶은 영화 조회</a></li>
                <li><a href="review.me">내가 쓴 리뷰 조회</a></li>
            </ul>
        </div>
        <div class="mypage-content">
        	<div class="reserve-header">
	            <h1>나의 예매 내역</h1>
	            <p>지난 1개월까지의 예매내역을 확인하실 수 있습니다.</p>
			</div>
            <!-- 예매 내역과 취소 내역을 합친 div -->
            <div class="reserve-body">
            
                <!-- 예매 내역들만 묶은 div -->
                <div class="reserve-list">
                    <c:choose>
                    
	                    <c:when test="${empty reserveList}">
						    <div class="no-reserve">
						        최근 1개월간 예매 내역이 존재하지 않습니다.
						    </div>
						</c:when>
						
						<c:otherwise>
		                    <c:forEach var="reserve" items="${reserveList}">
		                    	<!-- 예매 내역 하나의 div -->
			                    <div class="reserve-item">
			                        <div class="box-info">
			                            <div class="box-image">
			                                <a href="detail.mo?movieNo=${reserve.movieNo}"><img src="${ pageContext.request.contextPath }/resources/images/posters/${ reserve.fileCodename }" class="poster"></a>
			                            </div>
			                            <input type="hidden" id="hiddenEndTime" value="${reserve.endTime}">
			                            <div class="reserve-info">
			                                <div class="title-price">
			                                    <div><a href="detail.mo?movieNo=${reserve.movieNo}" class="movie-title">${reserve.movieTitle}</a></div>
			                                    <div class="cancel-review">
			                                    	<button type="button" class="cancel-btn" onclick="canelRequest(${reserve.bookNo})">예매 취소</button>
			                                    	<button type="button" class="review-btn" onClick="location.href='detail.mo?movieNo=${reserve.movieNo}'">리뷰 남기러 가기</button>
			                                    </div>
			                                </div>
			                                <div class="reserve-content">
			                                    <ul>
			                                        <li>
			                                            <dl>
			                                                <dt>관람일시</dt>
			                                                <dd class="d-day"><fmt:formatDate value="${reserve.playtime}" pattern="yyyy.MM.dd(E) HH:mm" /></dd>
			                                            </dl>
			                                        </li>
			                                        <li>
			                                            <dl>
			                                                <dt>관람좌석</dt>
			                                                <dd>${reserve.seatNo}</dd>
			                                            </dl>
			                                        </li>
			                                        <li>
			                                            <dl>
			                                                <dt>상영관</dt>
			                                                <dd>${reserve.screenName} 관</dd>
			                                            </dl>
			                                        </li>
			                                        <li>
			                                            <dl>
			                                                <dt>매수</dt>
			                                                <dd>${reserve.totalTickets} 매</dd>
			                                            </dl>
			                                        </li>
			                                    </ul>
			                                </div>
			                            </div>
			                        </div>
			                        <div class="payment-info">
			                            <h4>결제내역</h4>
			                            <div class="reserve-payment">

			                                <p class="final-price">
			                                    <span>최종 결제금액</span>
			                                    <span><fmt:formatNumber value="${reserve.bookCost}" type="number" pattern="#,##0" />원</span>
			                                </p>
			                                
			                                <p class="total-price">
			                                    <span>총 금액</span>
			                                    <span><fmt:formatNumber value="${reserve.bookTotalCost}" type="number" pattern="#,##0" />원</span>
			                                </p>
			                                
			                                <c:if test="${not empty useCouponList}">
											    <c:forEach var="coupon" items="${useCouponList}">
											        <c:if test="${coupon.bookNo == reserve.bookNo}">
											            <p class="coupon-discount">
											                <span>└ 쿠폰 할인 (${coupon.couponName})</span>
											                <span>-<fmt:formatNumber value="${reserve.bookTotalCost / reserve.totalTickets}" type="number" pattern="#,##0" />원</span>
											            </p>
											        </c:if>
											    </c:forEach>
											</c:if>
			                                
			                                <p class="payment-method">
			                                    <span>${reserve.costProcess}</span>
			                                    <span><fmt:formatNumber value="${reserve.bookCost}" type="number" pattern="#,##0" />원</span>
			                                </p>
			                                
			                                <div class="btn_incomeDeduction">
			                                    <span>* 영화관람료 소득공제 대상</span>
			                                    <button type="button" class="open-content-btn">자세히 보기</button>
			                                </div>
			                                <div class="incomeDeduction-content">
			                                    <p class="first-content">본 콘텐츠는 영화관람료 소득공제 대상 상품입니다.</p>
			                                    <p>문화비소득공제는 자동 적용되며, 결제완료 후 변경이 불가합니다.</p>
			                                    <h6>1. 영화 관람료 소득공제란?</h6>
			                                    <p>2023년 7월 1일 결제분 부터 영화 관람료에 대해 문화비 소득공제가 적용됩니다.</p>
			                                    <ul>
			                                        <li>총급여 7천만 원 이하 근로자 중 신용카드 등 사용액이 총급여액의 25 % 가 넘는 근로소득자를 대상으로 적용됩니다.</li>
			                                        <li>공제율은 30%, 공제한도는 전통시장 사용분, 대중교통 사용분, 문화비 사용분에 대한 소득공제를 합해 총 300만원 입니다.</li>
			                                    </ul>
			                                    <h6>2. 영화 관람료 소득공제 대상</h6>
			                                    <ul>
			                                        <li>영화 및 공연상품 (단, 영화와 매점(패스트오더) 상품 통합결제 시 대상 제외 / 스포츠 중계, 게임 중계, 강연 등 일부 콘텐츠 제외)</li>
			                                    </ul>
			                                    <h6>3. 영화 관람료 소득공제 제외 대상</h6>
			                                    <ul>
			                                        <li>매점(패스트오더), 씨네샵, 포토티켓 등 영화와 무관한 상품 제외</li>
			                                        <li>비상설상영관 등 일부 상영관 제외</li>
			                                    </ul>
			                                    <h6>4. 영화 관람료 소득공제 가능 결제수단</h6>
			                                    <ul>
			                                        <li>카드결제: 신용카드(법인카드 불가, 개인카드에 한함)</li>
			                                        <li>현금결제: 관람권, 포인트 등 현금영수증 처리가 가능한 결제수단</li>
			                                        <li>간편결제: 네이버페이, 카카오페이, Payco, 토스페이</li>
			                                        <li>휴대폰결제</li>
			                                    </ul>
			                                    <h6>5. 영화 관람료 소득공제 제외 결제수단</h6>
			                                    <ul>
			                                        <li>현금영수증 처리가 불가한 제휴 결제수단</li>
			                                        <li>그 외 OK캐쉬백 등 일부 결제수단</li>
			                                    </ul>
			                                </div>
			                            </div>
			                        </div>
			                        <!-- 상영시간 종료 여부 -->
							        <div class="msg-expired" style="display: none;">
							        	상영시간이 지난 영화입니다.
							        </div>
			                    </div>
			                </c:forEach>
	                    </c:otherwise>
	                    
	                </c:choose>
                </div>

                <!-- 취소 내역들만 묶은 div -->
                <div class="cancel-list">
                    <!-- 취소 내역 하나의 div -->
                    <div class="cancel-item">
                        <div class="cancel-header">
                            <h4>나의 취소내역</h4>
                            <p>상영일 기준 지난 7일 동안의 취소내역입니다.</p>
                        </div>
                        <div class="cencel-content">
                            <table>
                                <thead>
                                    <tr>
                                        <th style="width: 30%;">관람 영화</th>
                                        <th style="width: 25%">관람 일시</th>
                                        <th style="width: 25%">취소 일시</th>
                                        <th style="width: 20%">결제취소 금액</th>
                                    </tr>
                                </thead>
                                <tbody>

									<c:choose>
										<c:when test="${empty cancelList}">
											<tr>
												<td colspan="4" class="nodata">고객님의 최근 취소내역이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										
										<c:otherwise>
											<c:forEach var="cancel" items="${cancelList}">
												<tr class="cancel-data">
													<td>${cancel.movieTitle}</td>
													<td><fmt:formatDate value="${cancel.playtime}" pattern="yyyy.MM.dd(E) HH:mm" /></td>
													<td><fmt:formatDate value="${cancel.modifyDate}" pattern="yyyy.MM.dd(E) HH:mm" /></td>
													<td><strong><fmt:formatNumber value="${cancel.bookCost}" type="number" pattern="#,##0" /></strong>원</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="sect-box-descri">
                    <ul>
                        <li>
                            <dl>
                                <dt>이용안내</dt>
                                <dd>
                                    <ul>
                                        <li>예매 변경은 불가능하며, 취소 후 재 예매를 하셔야만 합니다.</li>
                                        <li>영수증은 상영 시간 전까지 My Filoom 에서 출력하실 수 있습니다. 단, 신용카드로 예매하신 경우만 한합니다.</li>
                                        <li>상영 시간 이후 관람하신 영화의 영수증 출력을 원하실 경우, 1544-1122로 문의 주시기 바랍니다.</li>
                                        <li>취소하신 내역이 나타나지 않거나 궁금하신 사항이 있으시면, 고객센터로 문의해 주시기 바랍니다.</li>
                                    </ul>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>예매 취소 안내</dt>
                                <dd>
                                    <ul>
                                        <li>
                                            <strong>신용카드</strong>
                                            <p>결제 후 3일 이내 취소 시 승인 취소 가능, 3일 이후 매입 취소시 영업일 기준 3~5일 소요</p>
                                        </li>
                                        <li>
                                            <strong>체크카드</strong>
                                            <p>결제 후 3일 이내 취소 시 당일 카드사에서 환불처리. 3일 이후 매입 취소 시 카드사에 따라 3~10일 이내 카드사에서 환불</p>
                                        </li>
                                        <li>
                                            <strong>휴대폰 결제</strong>
                                            <p>결제 일자 기준 당월(1~말일)취소만 가능. 익월 취소 관련 문의는 CGV고객센터(1544-1122) 연락 요망<br>
                                                예매취소 후 당일 환불이 원칙이나 현장 취소 시 경우에 따라 익일 처리 될 수 있음.</p>
                                        </li>
                                        <li>
                                            <strong>카카오페이</strong>
                                            <p>카카오페이머니나 카카오포인트를 사용하신 경우 각각의 잔액으로 원복되며, 카드 결제를 하신 경우는 카드사 정책에 따라 승인취소가 진행되며 3일 이후 매입 취소시 영업일 기준 3~10일 소요됩니다.</p>
                                        </li>
                                        <li>
                                            <strong>계좌이체</strong>
                                            <p>
                                                1. 예매일 이후 7일 이내 취소 시<br>
                                                - 자동 환불 은행: 취소 후 즉시 처리가능<br>
                                                - 조흥, 신한, 외한, 한미, 우리, 우체국, 전북, 경남, 광주, 대구, 새마을, 제주<br>
                                                - 우리은행의 경우 당일 취소분만 즉시 처리 가능<br>
                                                - 수동 환불 은행: 농협(취소 후 2~3일 이내 입금), 부산/제일/우리(취소 후 3~5일 이내 입금)<br>
                                                <br>
                                                2. 예매 7일 이후~상영시간 30분 전 취소 시(단, 일부 당일 취소 불가 행사의 경우 전일 취소 시)<br>
                                                - 환불은 환불 요청일로부터 7일 이상 소요됨<br>
                                                <br>
                                                ※ 기타 환불 관련 문의는 Filoom고객센터 1544-1122로 연락바랍니다.
                                            </p>
                                        </li>
                                    </ul>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />

    <script>
    
        // 소득공제 슬라이드 다운
        $(function() {
		    $('.open-content-btn').on('click', function() {
		        // 현재 클릭한 버튼의 부모 요소를 기준으로 슬라이드 토글
		        $(this).closest('.reserve-item').find('.incomeDeduction-content').slideToggle();
		    });
		});

        $(function () {
            $(".reserve-item").each(function () {
                // 각 reserve-item 내에서 작업
                const endTimeText = $(this).find("#hiddenEndTime").val(); // 해당 예약의 hiddenEndTime 값을 가져옴
                const now = new Date(); // 현재 시간

                if (!endTimeText) return; // endTimeText가 없으면 건너뜀

                const parts = endTimeText.split(" ");
                const months = {
                    Jan: 0, Feb: 1, Mar: 2, Apr: 3, May: 4, Jun: 5,
                    Jul: 6, Aug: 7, Sep: 8, Oct: 9, Nov: 10, Dec: 11
                };

                const year = parseInt(parts[5], 10);
                const month = months[parts[1]];
                const day = parseInt(parts[2], 10);
                const [hours, minutes, seconds] = parts[3].split(":").map(Number);

                const endTime = new Date(year, month, day, hours, minutes, seconds);

                if (now > endTime) {
                    // 상영 시간이 지난 경우
                    $(this).find(".msg-expired").show();
                    $(this).find(".d-day").css("color", "#fb4357");
                    $(this).find(".cancel-btn").hide();
                    $(this).find(".review-btn").show();
                } else {
                    // 상영 시간이 지나지 않은 경우
                    $(this).find(".msg-expired").hide();
                    $(this).find(".d-day").css("color", "");
                    $(this).find(".cancel-btn").show();
                    $(this).find(".review-btn").hide();
                }
            });
        });
        
        //형문 -결제 취소
        function canelRequest(bookNo){
			let cancelConfirm = confirm("예매를 취소 하시겠습니까 ? ");
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
							alert("죄송합니다. 상영시간 이후 취소/환불은 불가합니다.")
						}
					},
					error:function(){
						console.log("결제취소요청실패-ajax")
					}
				});
			}
		}

    </script>

</body>
</html>