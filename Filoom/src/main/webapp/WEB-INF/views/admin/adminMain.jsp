<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
   
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
		
		
		/*----------------- admin 기본 -------------------*/
		
		#adminMain1{
		
		    width: 50%;
		    height: 100%;
		    float: left;
		
		}
		
		#memberChart{
		
		    margin: 5px;
		    margin-left: 20px;
		    width: 95%;
		    height: 48%;
		    background-color: #D9D9D9;
		    border-radius: 5px;
		
		}
		
		#movieChart{
		
		    margin: 5px;
		    margin-left: 20px;
		    width: 95%;
		    height: 48%;
		    background-color: #D9D9D9;
		    border-radius: 5px;
		
		}
		
		#adminMain2{
		
		    width: 30%;
		    height: 100%;
		    float: left;
		    
		}
		
		#MSC1{
		   
		    width: 90%;
		    height: 90%;
		
		}
		
		#MSC2{
		    width: 90%;
		    height: 90%;
		}
		
		#movieSubChart1{
		
		    width: 100%;
		    height: 48%;
		    margin-left: 10px;
		
		}
		
		#movieSubChart2{
		
		    width: 100%;
		    height: 48%;
		    margin-left: 10px;
		    margin-top: 30px;
		
		}
		
		#adminMain3{
		
		    width: 18%;
		    height: 100%;
		    float: left;
		    display: flex;
		    flex-direction: column;
		    gap: 3px;
		    text-align: center;
		    font-size: 20px;
		
		}
		
		#data1{
		    width: 100%;
		    height: 20%;
		    background-color: #D2CECF;
		    border-radius: 5px;
		    margin: auto;
		    text-align: center;
		}  
		
		#data2{
		    width: 100%;
		    height: 20%;
		    background-color: #D2CECF;
		    border-radius: 5px;
		    margin: auto;
		}
		
		#data3{
		    width: 100%;
		    height: 20%;
		    background-color: #D2CECF;
		    border-radius: 5px;
		    margin: auto;
		}   
		
		#data4{
		    width: 100%;
		    height: 20%;
		    background-color: #D2CECF;
		    border-radius: 5px;
		    margin: auto;
		}
				
			
	</style>

</head>
<body>
	
	


    <div id = "admin_content">
        
        <jsp:include page="../common/adminHeader.jsp" />	
        
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 여기가 관리자 상단 회원번호, 회원아이디 이런거 적는 곳
                    구상은 각자 알아서~ 
                -->
                <div id = "admin_title_content">



                </div>

            </div>

            <div id = "admin_detail">
                
                <!-- 여기 안이 관리자 컨텐츠 영역이에요~-->
                <div id ="admin_page">
                    
                    <div id = "adminMain1">
                        <div id = "memberChart">
                            <canvas id="memberMainChart"></canvas>
                        </div>
                        <div id = "movieChart">
                            <canvas id="movieMainChart"></canvas>
                        </div>
                    </div>

                    <div id = "adminMain2">
                        <div id = "movieSubChart1">
                            <canvas id="MSC1"></canvas>  
                        </div>
                        <div id = "movieSubChart2">
                            <canvas id="MSC2"></canvas>  
                        </div>
                    </div>
                    <div id = "adminMain3">
                        <div id = "data1">
                            <h3>등록된 영화 개수</h3>
                            <a>${ ch2.movieCount }</a>
                        </div>
                        <div id = "data2">
                            <h3>상영중인 영화 개수</h3>
                            <a>${ ch3.playingMovieCount }</a>
                        </div>
                        <div id = "data3">
                            <h3>총 회원 수</h3>
                            <a>${ ch4.memberCount }</a>
                        </div>
                        <div id = "data4">
                            <h3>당일 매출 액</h3>
                            <a>${ ch7.totalInput } 원</a>
                        </div>
                        
                    </div>


                    <!--이건 버튼 이랑 text 샘플-->
                    <!--<input type ="text" id ="text_sample">
                    <input type="button" id ="button_sample" value="샘플">
                -->
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


    // chart.js 단 
	
    	let twoMonthLaterMemberCount = '${ch1.twoMonthLaterMemberCount}';
    	let oneMonthLaterMemberCount = '${ch1.oneMonthLaterMemberCount}';
		let currentMonthLaterMemberCount = '${ch1.currentMonthMemberCount}';
		let oneMonthAfterMemberCount = '${ch1.oneMonthAfterMemberCount}';
		let	twoMonthAfterMemberCount = '${ch1.twoMonthAfterMemberCount}';
    	
		let twoMonthLaterBookCount = '${ch5.twoMonthLaterBookCount}';
		let oneMonthLaterBookCount = '${ch5.oneMonthLaterBookCount}';
		let currnetMonthBookCount = '${ch5.currnetMonthBookCount}';
		let oneMonthAfterBookCount = '${ch5.oneMonthAfterBookCount}';
		let twoMonthAfterBookCount = '${ch5.twoMonthAfterBookCount}';
		
		let teenager='${ch1.teenager}';
		let twenty='${ch1.twenty}';
		let thirty='${ch1.thirty}';
		let fourty='${ch1.fourty}';
		let fifty='${ch1.fifty}';
		let sixty='${ch1.sixty}';
		
		console.log("teenager : " + teenager);
		console.log("twenty : " + twenty);
		
		let action = '${ch6.action}';
		let horror = '${ch6.horror}';
		let romance = '${ch6.romance}';
		let drama = '${ch6.drama}';
		let documentary = '${ch6.documentary}';
		let animation = '${ch6.animation}';
		
    	console.log(oneMonthLaterMemberCount);
    	

    	function generateMonthLabels() {
            const currentDate = new Date();
            const currentMonth = currentDate.getMonth(); // 현재 달 (0부터 시작: 0=1월, 11=12월)
            const monthLabels = [];
            
            // 월 이름 배열 (0 = 1월, 11 = 12월)
            const monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', 
                                '7월', '8월', '9월', '10월', '11월', '12월'];

            // 현재 달을 기준으로 지난 2개월과 앞으로 2개월을 포함한 배열 생성
            for (let i = -2; i <= 2; i++) {
                const monthIndex = (currentMonth + i + 12) % 12; // 음수 처리 및 12월 이후 처리
                monthLabels.push(monthNames[monthIndex]);
            }

            return monthLabels;
        }

  
        const labels = generateMonthLabels();
        console.log(labels); 
    	
    // memberChart
        const ctx1 = document.getElementById('memberMainChart');

        new Chart(ctx1, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '사용자 수',
                data: [twoMonthLaterMemberCount, 
                	oneMonthLaterMemberCount, 
                	currentMonthLaterMemberCount, 
                	oneMonthAfterMemberCount, 
                	twoMonthAfterMemberCount],
                borderWidth: 1,
                borderColor : '#151515',
             
            }]
        },
        options: {
            scales: {
            y: {
                beginAtZero: true
            }
            }
        }
        });

        const ctx2 = document.getElementById('movieMainChart');

        new Chart(ctx2, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '예매 수',
                data: [twoMonthLaterBookCount,
                	oneMonthLaterBookCount,
                	currnetMonthBookCount,
                	oneMonthAfterBookCount,
                	twoMonthAfterBookCount],
                borderWidth: 1,
                borderColor : '#151515',
            }]
        },
        options: {
            scales: {
            y: {
                beginAtZero: true
            }
            }
        }
        });


        // 회원의 나이대

        const MSC1 = document.getElementById('MSC1');

        new Chart(MSC1, {
            type : 'doughnut',
            data : {
                labels: [
                '액션',
                '공포',
                '로맨스',
                '드라마',
                '다큐멘터리',
                '애니메이션'
            ],
            datasets: [{
                label: '영화 장르',
                data: [
                	action, 
                	horror, 
                	romance,
                	drama,
                	documentary,
                	animation
                ],
                backgroundColor: [
                '#151515',
                '#D9D9D9',
                '#D6C0B3',
                '#AB886D',
                '#493628',
                '#6F6464'
                ],
                hoverOffset: 4
            }]
            }

        });

        // 영화 장르별

        const MSC2 = document.getElementById('MSC2');

        new Chart(MSC2, {
            type : 'doughnut',
            data : {
                labels: [
                '10대',
                '20대',
                '30대',
                '40대',
                '50대',
                '60대 이상'
            ],
            datasets: [{
                label: '연령대',
                data: [
                	teenager, 
                	twenty, 
                	thirty,
                	fourty,
                	fifty,
                	sixty
                ],
                backgroundColor: [
                '#151515',
                '#D9D9D9',
                '#D6C0B3',
                '#AB886D',
                '#493628',
                '#6F6464'
                ],
                hoverOffset: 4
            }]
            }

        });

       


    </script>
    
</body>
</html>