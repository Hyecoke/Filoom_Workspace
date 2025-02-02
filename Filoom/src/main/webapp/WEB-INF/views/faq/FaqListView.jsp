<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자주 묻는 질문</title>
<style>

	body{
        background-color: black;
    }
    	
    	
	    /*전체를 감싸는 영역*/
	.container {
	    background-color: #313131;
	    box-sizing: border-box;
	    margin : auto;
	    width : 1900px;
	    max-width: 1900px;
	    padding : 20px;
	}
	
	/*faq*/
	.faq {
	    padding : 10px;
	}
	
	.faq>a:hover {
	    color : #E4E0E1;
	}
	
	/*자주 묻는 질문 필터링*/
	.filter-buttons {
	    border : 2px solid #E4E0E1;
	    border-radius: 4px;
	    margin-top: 10px;
	    display: flex;
	    justify-content: ceter;
	    align-items: center;
	    gap : 20px;
	    padding : 10px;
	    margin-bottom: 10px;
	}
	
	.filter-button {
	    border-radius: 4px;
	    background-color: #E4E0E1;
	    width : 350px;
	    height : 150px;
	    border : none;
	    cursor: pointer;
	    
	}
	
	.filter-button.active  {
	    background-color: #AB886D;
	    
	}
	
	#all, #theaterUse, #member, #movieReservation, #payTicket {
	    padding : 10px;
	    text-align: center;
	    font-size: 35px;
	    font-weight: bold;
	    color : #493628;
	    line-height: 70px;
	}
	
	/*자주 묻는 질문 FAQ 영역*/
	.faqArea {
	    width : 100%;
	    /*border : 2px solid #E4E0E1;*/
	    border : none;
	    border-collapse: collapse;
	    color : #E4E0E1;
	    margin-bottom: 20px;
	}
	
	thead th {
	    background-color: #E4E0E1;
	    color : #493628;
	    font-size: 25px;
	    font-weight: bold;
	}
	
	tbody td {
	    text-align: left;
	}
	
	.faqArea td:first-child,
	.faqArea td:last-child {
	    text-align: center;
	    vertical-align: middle;
	}
	
	.faq-q {
	    background-color: #F3F3F3;
	    color : #493628;
	    font-size: 23px;
	    font-weight: bold;
	    height : 80px;
	    cursor: pointer;
	}
	
	#category {
	    text-align: center;
	    padding : 10px;
	}
	
	#q {
	    padding : 10px;
	}
	
	#arrow {
	    padding : 10px;
	    text-align: center;
	    font-size: 30px;
	    font-weight: bolder;
	    cursor: pointer;
	}
	
	.arrow {
	    cursor: pointer;
	    font-size : 20px;
	}
	
	.arrow:hover {
	    color : #AB886D;
	}
	
	.faq-a {
	    background-color: #E4E0E1;
	    color : #493628;
	    font-size: 23px;
	    font-weight: bold;
	    height : 90px;
	    display: none;
	    display: none;
	}
	
	#a {
	    padding : 10px;
	}
	
	/*페이징영역*/
	.pagingArea {
	    display: flex;
	    justify-content: center;
	    padding : 20px;
	    font-size: 20px;
	    font-weight: bold;
	
	}
	.pagination {
	    list-style-type : none;
	    display: flex;
	    padding : 0;
	    margin: 0;
	    font-size: 20px;
	    font-weight: bold;
	}
	.pagination>li {
	    margin : 0 10px; /*리스트 항목 간의 간격*/
	    cursor: pointer;
	    transition: color 0.3s ease; /*색상 전환 효과*/
	    font-size: 25px;
	    font-weight: bold;
	    color : #F3F3F3;
	}
	
	.pagination>li:hover {
	    text-decoration-line: none;
	    color : #AB886D;
	}
	
	.pagination > li.disabled {
	    color: #AB886D;
	    pointer-events: none;
	}
	
	.pagination > li.active {
	    color: #AB886D;
	}
	
	/*li>a:hover, li>a:active {
	    color : #AB886D;
	}
	
	.page-item.disabled>a {
	    color : #ccc;
	} */

</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	
    <div class="container">
        <div class="faq">
            <h2 style="color : #E4E0E1;">자주 묻는 질문</h2>
            <h3 style="color : #E4E0E1; ">더 궁금한 점이 있거나, 이미 문의한 내용과 답변을 확인하려면?</h3>
            <a href="#"><h4 style="text-decoration: underline; color : #AB886D;">1:1문의 채팅 바로가기</h4></a>
        </div>

        <!-- 자주 묻는 질문 필터링 -->
        <div class="filter-buttons">
            <button class="filter-button active" id="all" data-category="">🍿🍿🍿<br>전체</button>
            <button class="filter-button" id="theaterUse" data-category="영화관 이용">🍿🍿🍿<br>영화관이용</button>
            <button class="filter-button" id="member" data-category="회원">🍿🍿🍿<br>회원</button>
            <button class="filter-button" id="movieReservation" data-category="영화예매">🍿🍿🍿<br>영화예매</button>
            <button class="filter-button" id="payTicket" data-category="결제수단/관람권">🍿🍿🍿<br>결제수단/관람권</button>
        </div>

        <!-- 자주 묻는 질문 FAQ 영역 -->
        <div style="box-sizing: border-box; padding : 10px;">
            <table class="faqArea">
                <thead>
                    <tr>
                        <th style="width : 20%; height : 80px;">구분</th>
                        <th style="width : 70%;">질문</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="faq-tbody">
                    <!-- FAQ 데이터 동적으로 추가 -->
                    
                </tbody>
            </table>

            <!-- 페이징바 -->
            <div class="pagingArea">
                <ul class="pagination" id="pagination">
                    <li class="page-item disabled"><a class="page-link" href="#">«</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">4</a></li>
                    <li class="page-item"><a class="page-link" href="#">5</a></li>
                    <li class="page-item"><a class="page-link" href="#">6</a></li>
                    <li class="page-item"><a class="page-link" href="#">7</a></li>
                    <li class="page-item"><a class="page-link" href="#">8</a></li>
                    <li class="page-item"><a class="page-link" href="#">9</a></li>
                    <li class="page-item"><a class="page-link" href="#">10</a></li>
                    <li class="page-item"><a class="page-link" href="#">»</a></li>
                </ul>
            </div>

        </div>
    </div>

    <script>
        // FAQ 데이터 배열
        const faqData = [
            { category: "영화관 이용", question: "영화관 입장 시간은 어떻게 되나요?", answer: "영화 시작 15분 전에 입장 가능합니다." },
            { category: "영화관 이용", question: "영화관 내에서 음료나 간식을 먹을 수 있나요?", answer: "네, 영화관 내에서는 음료와 간식을 드실 수 있습니다." },
            { category: "영화관 이용", question: "어린이와 함께 영화관에 가도 되나요?", answer: "어린이와 함께 영화 관람 가능합니다. 단, 연령 제한이 있는 영화는 제외입니다." },
            { category: "영화관 이용", question: "영화관에서 장애인 지원 서비스를 제공하나요?", answer: "네, 장애인 전용 좌석과 지원 서비스를 제공하고 있습니다." },
            { category: "영화관 이용", question: "영화관에 주차 공간이 있나요?", answer: "영화관에 주차 공간이 마련되어 있으나, 사전 예약은 불가합니다." },
            { category: "영화관 이용", question: "영화 시작 전에 영화관에 가면 무엇을 할 수 있나요?", answer: "영화 시작 전에 로비에서 음료와 간식을 구입하거나, 영화 예고편을 관람하실 수 있습니다." },
            { category: "영화관 이용", question: "영화관에서 자주 사용하는 멤버십 프로그램은 무엇인가요?", answer: "멤버십 프로그램에 가입하시면 할인 혜택을 받을 수 있습니다." },
            { category: "영화관 이용", question: "영화관에서 영화 상영을 취소할 수 있나요?", answer: "영화관 내에서는 영화 상영 취소가 불가능합니다. 예매 취소는 온라인을 통해 가능합니다." },
            { category: "영화관 이용", question: "영화관의 좌석은 어떻게 선택하나요?", answer: "예매 시 좌석을 선택하실 수 있습니다. 원하는 좌석을 클릭하여 선택해주세요." },
            { category: "영화관 이용", question: "영화관에서 기차표를 예매할 수 있나요?", answer: "영화관에서는 기차표 예매 서비스를 제공하지 않습니다." },
            { category: "영화관 이용", question: "영화관 내에서 모바일 기기를 사용할 수 있나요?", answer: "영화 상영 중에는 모바일 기기 사용을 자제해 주세요." },
            { category: "영화관 이용", question: "영화 상영 시간이 지연될 경우 어떻게 되나요?", answer: "상영 시간이 지연되면 안내 메시지가 제공됩니다." },
            { category: "영화관 이용", question: "영화관 내에서는 어떤 방식으로 결제를 하나요?", answer: "현금, 카드, 모바일 결제 등 다양한 결제 방법을 지원합니다." },
            { category: "영화관 이용", question: "영화관에서 제공하는 추가 서비스가 있나요?", answer: "영화관에서는 3D 영화, VIP 좌석, 프리미엄 서비스를 제공하고 있습니다." },
            { category: "영화관 이용", question: "영화관 예약 후 입장하지 않으면 어떻게 되나요?", answer: "예약 후 30분 이내 입장하지 않으면 예매가 취소될 수 있습니다." },
            { category: "영화관 이용", question: "영화관 내에서 무료 Wi-Fi를 사용할 수 있나요?", answer: "네, 영화관에서는 무료 Wi-Fi 서비스를 제공합니다." },
            { category: "영화관 이용", question: "영화관에 반려동물을 데려갈 수 있나요?", answer: "반려동물은 영화관 내에 데려올 수 없습니다." },
            { category: "영화관 이용", question: "영화관에서는 어떤 영화 장르를 상영하나요?", answer: "액션, 드라마, 코미디, 애니메이션 등 다양한 장르의 영화를 상영합니다." },
            { category: "영화관 이용", question: "영화관에서 예약 변경이 가능한가요?", answer: "예매한 좌석의 변경은 온라인을 통해 가능합니다." },
            { category: "영화관 이용", question: "영화관에서는 특별 상영을 진행하나요?", answer: "네, 특별 상영회나 이벤트 상영이 자주 열립니다." },

            { category: "회원", question: "회원 가입은 어떻게 하나요?", answer: "회원 가입은 사이트에서 간단한 양식 작성 후 가능합니다." },
            { category: "회원", question: "회원 정보를 수정하려면 어떻게 해야 하나요?", answer: "마이페이지에서 회원 정보를 수정할 수 있습니다." },
            { category: "회원", question: "비밀번호를 잊어버렸어요. 어떻게 해야 하나요?", answer: "비밀번호 찾기 메뉴에서 이메일을 입력하면 비밀번호를 재설정할 수 있습니다." },
            { category: "회원", question: "회원 탈퇴는 어떻게 하나요?", answer: "마이페이지에서 회원 탈퇴를 진행하실 수 있습니다." },
            { category: "회원", question: "회원 가입 시 이메일 인증이 필요한가요?", answer: "네, 이메일 인증을 통해 가입을 완료할 수 있습니다." },
            { category: "회원", question: "회원 가입 시 필요한 정보는 무엇인가요?", answer: "이메일, 비밀번호, 이름, 연락처 정보가 필요합니다." },
            { category: "회원", question: "회원 가입을 하지 않으면 예매가 불가능한가요?", answer: "예매를 위해 회원 가입은 필수입니다." },
            { category: "회원", question: "회원 정보 삭제가 가능한가요?", answer: "회원 정보 삭제는 탈퇴 절차를 통해 진행됩니다." },
            { category: "회원", question: "회원 탈퇴 후 재가입이 가능한가요?", answer: "네, 탈퇴 후 일정 기간이 지나면 재가입이 가능합니다." },
            { category: "회원", question: "회원 가입 후 즉시 예매가 가능한가요?", answer: "회원 가입 후 바로 예매가 가능합니다." },
            { category: "회원", question: "회원 등급이 있나요?", answer: "회원 등급은 영화 예매 금액에 따라 자동으로 부여됩니다." },
            { category: "회원", question: "회원 정보 변경 시 로그인해야 하나요?", answer: "네, 로그인 후 회원 정보 변경이 가능합니다." },
            { category: "회원", question: "아이디 변경이 가능한가요?", answer: "아이디는 변경할 수 없습니다." },
            { category: "회원", question: "회원 가입 후 이메일이 확인되지 않으면 어떻게 해야 하나요?", answer: "이메일 확인 메일이 스팸으로 분류될 수 있으니, 스팸함도 확인해 주세요." },
            { category: "회원", question: "회원 가입 시 개인정보를 어떻게 보호하나요?", answer: "모든 개인정보는 안전하게 암호화되어 저장됩니다." },
            { category: "회원", question: "회원 가입 후 바로 영화 예매를 해도 되나요?", answer: "가입 즉시 영화 예매가 가능합니다." },
            { category: "회원", question: "회원 가입 후 영화 예매 내역을 볼 수 있나요?", answer: "마이페이지에서 예매 내역을 확인할 수 있습니다." },
            { category: "회원", question: "회원 탈퇴 후 예매 기록은 어떻게 되나요?", answer: "회원 탈퇴 후 예매 기록은 삭제됩니다." },
            { category: "회원", question: "회원 가입 시 오류가 발생하면 어떻게 해야 하나요?", answer: "회원 가입 시 오류가 발생하면 고객센터로 문의해 주세요." },

            { category: "영화예매", question: "영화 예매는 어떻게 하나요?", answer: "홈페이지에서 영화를 선택하고 좌석을 선택 후 결제하면 예매가 완료됩니다." },
            { category: "영화예매", question: "예매 가능한 영화는 어디서 확인하나요?", answer: "영화 목록에서 예매 가능한 영화를 확인할 수 있습니다." },
            { category: "영화예매", question: "영화 예매는 언제부터 가능한가요?", answer: "영화 예매는 상영 1개월 전부터 가능합니다." },
            { category: "영화예매", question: "영화 예매 취소는 어떻게 하나요?", answer: "마이페이지에서 예매 취소가 가능합니다." },
            { category: "영화예매", question: "영화 예매 시 결제는 어떻게 하나요?", answer: "결제는 카드, 모바일 결제, 계좌이체 등 다양한 방법으로 가능합니다." },
            { category: "영화예매", question: "영화 예매 후 좌석을 변경할 수 있나요?", answer: "예매 후 좌석 변경은 불가능합니다." },
            { category: "영화예매", question: "영화 예매 후 예매 내역은 어디서 확인하나요?", answer: "마이페이지에서 예매 내역을 확인할 수 있습니다." },
            { category: "영화예매", question: "영화 예매 후 예매 확인서를 받을 수 있나요?", answer: "예매 확인서는 이메일로 발송됩니다." },
            { category: "영화예매", question: "예매한 영화의 시간 변경은 어떻게 하나요?", answer: "영화 상영 시간 변경은 예매 취소 후 재예매를 진행해야 합니다." },
            { category: "영화예매", question: "예매 후 결제를 취소할 수 있나요?", answer: "결제 취소는 영화 상영 전에만 가능합니다." },
            { category: "영화예매", question: "예매 후 티켓을 어떻게 받을 수 있나요?", answer: "온라인 예매 후 현장에서 티켓을 발권하거나 모바일로 발급 가능합니다." },
            { category: "영화예매", question: "예매한 영화의 상영 시간이 지나면 어떻게 되나요?", answer: "상영 시간에 맞춰 입장하지 않으면 예매가 취소됩니다." },
            { category: "영화예매", question: "영화 예매한 티켓은 다른 사람에게 양도할 수 있나요?", answer: "예매한 티켓은 다른 사람에게 양도할 수 없습니다." },
            { category: "영화예매", question: "영화 예매한 후 환불이 가능한가요?", answer: "영화 상영 전까지 환불이 가능합니다." },
            { category: "영화예매", question: "영화 예매 후 환불 절차는 어떻게 되나요?", answer: "환불은 마이페이지에서 신청할 수 있습니다." },
            { category: "영화예매", question: "영화 예매 시 멤버십 할인은 적용되나요?", answer: "멤버십 등급에 따라 할인 혜택이 적용됩니다." },
            { category: "영화예매", question: "영화 예매 시 좌석 선택은 어떻게 하나요?", answer: "예매 시 상영관과 좌석을 선택할 수 있습니다." },
            { category: "영화예매", question: "영화 예매 후 좌석이 비어 있으면 변경할 수 있나요?", answer: "좌석은 예매 후 변경이 불가능합니다." },

            { category: "결제수단/관람권", question: "결제는 어떤 방법으로 하나요?", answer: "카드, 계좌이체, 휴대폰 결제 등 다양한 방법이 지원됩니다." },
            { category: "결제수단/관람권", question: "결제 수단에 제한이 있나요?", answer: "결제 수단에 특별한 제한은 없습니다." },
            { category: "결제수단/관람권", question: "온라인 결제 후 티켓은 어떻게 받나요?", answer: "온라인 결제 후 티켓은 현장에서 발권하거나 모바일로 확인 가능합니다." },
            { category: "결제수단/관람권", question: "모바일 결제는 어떻게 하나요?", answer: "모바일 결제는 영화 예매 시 결제 화면에서 선택할 수 있습니다." },
            { category: "결제수단/관람권", question: "관람권은 어디서 구매할 수 있나요?", answer: "관람권은 사이트에서 예매하거나, 영화관 내에서 구매 가능합니다." },
            { category: "결제수단/관람권", question: "관람권의 유효 기간은 어떻게 되나요?", answer: "관람권은 발급일로부터 3개월 이내 사용 가능합니다." },
            { category: "결제수단/관람권", question: "영화 예매 시 결제 금액은 언제 청구되나요?", answer: "결제 금액은 예매 시 즉시 청구됩니다." },
            { category: "결제수단/관람권", question: "결제 시 카드 정보가 안전한가요?", answer: "카드 정보는 안전한 결제 시스템을 통해 처리됩니다." },
            { category: "결제수단/관람권", question: "관람권을 환불할 수 있나요?", answer: "관람권은 예매 취소 시 환불이 가능합니다." },
            { category: "결제수단/관람권", question: "결제 수단은 어떻게 변경하나요?", answer: "결제 수단 변경은 예매 시 가능합니다." },
            { category: "결제수단/관람권", question: "결제 영수증은 어떻게 받을 수 있나요?", answer: "결제 후 이메일로 영수증이 발송됩니다." },
            { category: "결제수단/관람권", question: "관람권 할인은 어떻게 적용되나요?", answer: "할인 혜택은 회원 등급 및 이벤트에 따라 적용됩니다." },
            { category: "결제수단/관람권", question: "결제 후 티켓을 양도할 수 있나요?", answer: "티켓은 양도가 불가능합니다." },
            { category: "결제수단/관람권", question: "결제 방법에 따라 혜택이 있나요?", answer: "결제 수단에 따라 적립 포인트나 할인 혜택이 제공됩니다." },
            { category: "결제수단/관람권", question: "관람권을 여러 개 묶어서 구매할 수 있나요?", answer: "관람권은 묶음 구매가 가능하며, 할인 혜택도 제공됩니다." },
            { category: "결제수단/관람권", question: "휴대폰 결제는 어떤 방법으로 하나요?", answer: "휴대폰 결제는 예매 시 결제 방법으로 선택할 수 있습니다." },
            { category: "결제수단/관람권", question: "결제 후 환불이 가능하나요?", answer: "영화 상영 전까지 결제 환불이 가능합니다." },
            { category: "결제수단/관람권", question: "관람권을 환불하려면 어떻게 하나요?", answer: "관람권 환불은 예매 취소 절차를 통해 가능합니다." },
            { category: "결제수단/관람권", question: "결제 후 카드 정보를 변경할 수 있나요?", answer: "결제 후에는 카드 정보를 변경할 수 없습니다." }
        ];

     	// 페이지 관련 변수
        let currentPage = 1; // 현재 페이지
        const itemsPerPage = 10; // 페이지당 항목 수
        let currentCategory = ''; // 현재 카테고리 (필터 상태)

        // FAQ 동적으로 생성 (필터 + 페이징 적용)
        function generateFAQ(categoryFilter = '') {
            const tbody = document.getElementById('faq-tbody');
            tbody.innerHTML = ''; // 기존 내용 제거

            // 필터링된 데이터 가져오기
            const filteredData = faqData.filter(item => {
                return categoryFilter === '' || item.category === categoryFilter;
            });

            // 페이징 처리를 위한 데이터 슬라이싱
            const startIndex = (currentPage - 1) * itemsPerPage;
            const endIndex = startIndex + itemsPerPage;
            const paginatedData = filteredData.slice(startIndex, endIndex);

            // 필터링 + 페이징된 데이터 렌더링
            paginatedData.forEach(faq => {
                const tr = document.createElement('tr');
                tr.classList.add("faq-q");
                tr.setAttribute("data-category", faq.category);

                const categoryCell = document.createElement("td");
                categoryCell.classList.add("category");
                categoryCell.textContent = faq.category;

                const questionCell = document.createElement("td");
                questionCell.classList.add("question");
                questionCell.textContent = faq.question;

                const arrowCell = document.createElement("td");
                arrowCell.classList.add("arrow");
                arrowCell.textContent = "﹀";

                // 답변을 보여줄 tr
                const answerRow = document.createElement("tr");
                answerRow.classList.add("faq-a");
                answerRow.setAttribute("data-category", faq.category);
                answerRow.style.display = "none"; // 기본적으로 숨김

                const emptyCell1 = document.createElement("td"); // 첫 번째 빈 셀
                const answerCell = document.createElement("td");
                answerCell.classList.add("answer");
                answerCell.textContent = faq.answer;
                const emptyCell2 = document.createElement("td"); // 두 번째 빈 셀

                // 각 셀을 answerRow에 추가
                answerRow.appendChild(emptyCell1);
                answerRow.appendChild(answerCell);
                answerRow.appendChild(emptyCell2);

                // questionRow에 td들 추가
                tr.appendChild(categoryCell);
                tr.appendChild(questionCell);
                tr.appendChild(arrowCell);

                // faqTbody 에 questionRow와 answerRow 추가
                tbody.appendChild(tr);
                tbody.appendChild(answerRow);

             	// 각 화살표 클릭 시 답변 열기/닫기
                arrowCell.addEventListener("click", () => {
                    // 모든 답변 행을 닫고 화살표를 원 상태로 되돌림
                    const allAnswerRows = document.querySelectorAll(".faq-a");
                    const allArrowCells = document.querySelectorAll(".arrow");

                    // 현재 클릭한 답변 행
                    const isCurrentlyVisible = answerRow.style.display === "table-row"; 

                    // 다른 모든 답변을 닫음
                    allAnswerRows.forEach(row => row.style.display = "none");
                    allArrowCells.forEach(cell => (cell.textContent = "﹀")); // 화살표 초기화

                    // 현재 클릭한 답변을 열거나 닫음
                    if (isCurrentlyVisible) {
                        answerRow.style.display = "none";
                        arrowCell.textContent = "﹀";  // 화살표를 내려놓은 상태로 표시
                    } else {
                        answerRow.style.display = "table-row";  // 답변 열기
                        arrowCell.textContent = "︿";  // 화살표를 위로 표시
                    }
                });
            });

            // 페이지 버튼 렌더링
            renderPagination(filteredData.length);
        }

            // 페이지 버튼 렌더링 시 활성화된 버튼에 직접 스타일 적용
            function renderPagination(totalItems) {
                const paginationContainer = document.getElementById('pagination');
                paginationContainer.innerHTML = ''; // 기존 버튼 초기화

                const totalPages = Math.ceil(totalItems / itemsPerPage);

                // 이전 버튼
                const prevButton = document.createElement('li');
                prevButton.textContent = '«';
                prevButton.classList.add('pagination-button');
                prevButton.style.cursor = 'pointer'; // 커서 포인터 추가
                prevButton.disabled = currentPage === 1; // 첫 페이지에서는 비활성화
                prevButton.addEventListener('click', () => {
                    if (currentPage > 1) {
                        currentPage--;
                        generateFAQ(currentCategory);
                    }
                });
                paginationContainer.appendChild(prevButton);

                // 페이지 번호 버튼들
                for (let i = 1; i <= totalPages; i++) {
                    const button = document.createElement('li');
                    button.textContent = i;
                    button.className = i === currentPage ? 'active' : 'pagination-button';
                    button.style.cursor = 'pointer'; // 커서 포인터 추가
                    button.addEventListener('click', () => {
                        currentPage = i;
                        generateFAQ(currentCategory);
                    });
                    paginationContainer.appendChild(button);
                }

                // 다음 버튼
                const nextButton = document.createElement('li');
                nextButton.textContent = '»';
                nextButton.classList.add('pagination-button');
                nextButton.style.cursor = 'pointer'; // 커서 포인터 추가
                nextButton.disabled = currentPage === totalPages; // 마지막 페이지에서는 비활성화
                nextButton.addEventListener('click', () => {
                    if (currentPage < totalPages) {
                        currentPage++;
                        generateFAQ(currentCategory);
                    }
                });
                paginationContainer.appendChild(nextButton);
            }

            // 필터 버튼 상태 변경 함수
            function setActiveFilterButton(button) {
                // 모든 버튼의 'active' 클래스 제거
                const buttons = document.querySelectorAll('.filter-button');
                buttons.forEach(btn => btn.classList.remove('active'));

                // 클릭된 버튼에 'active' 클래스 추가
                button.classList.add('active');
            }

            // 카테고리 필터 버튼 클릭 이벤트
            document.querySelectorAll('.filter-button').forEach(button => {
                button.addEventListener('click', () => {
                    currentPage = 1; // 필터 변경 시 첫 페이지로 초기화
                    currentCategory = button.dataset.category || ''; // 필터 카테고리 설정
                    setActiveFilterButton(button); // 버튼 상태 업데이트
                    generateFAQ(currentCategory);
                });
            });

            // 초기 데이터 로드 (전체 FAQ)
            generateFAQ();
            
    </script>
    
    <!--Start of Tawk.to Script-->
   	<script type="text/javascript">
   		var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
   		(function(){
   		var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
   		s1.async=true;
   		s1.src='https://embed.tawk.to/6767f7c649e2fd8dfefbe09c/1ifn1vnud';
   		s1.charset='UTF-8';
   		s1.setAttribute('crossorigin','*');
   		s0.parentNode.insertBefore(s1,s0);
   		})();
   	</script>
   	<!--End of Tawk.to Script-->
    
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>