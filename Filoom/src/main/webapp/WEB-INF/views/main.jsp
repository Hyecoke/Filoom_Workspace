<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/mainstyle.css" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ca4036e4722868bde0211b5c0b8f26e"></script>

</head>
<body>
	
	<c:choose>
	    <c:when test="${!empty sessionScope.loginUser && sessionScope.loginUser.userId == 'admin'}">
	        <!-- 로그인한 사용자가 admin일 경우 -->
			<div id="manager" style="display: flex; justify-content: center; align-items: center; height: 100px; background-color: #000;">
			    <a href="/filoom/ad.li" style="text-decoration: none; font-size: 30px; color: white;">관리자 메인페이지</a>
			</div>
	    </c:when>
	    <c:otherwise>
	        <!-- 로그인한 사용자가 admin이 아닐 경우 아무것도 표시되지 않음 -->
	    </c:otherwise>
	</c:choose>
		
	
	<div id = "main_content1">
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
		                    	<a class="logo" style="margin-left:1px;" href="${ pageContext.request.contextPath }">Filoom</a>
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
            <hr >
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
        
        <div id="content1_real">
            <div id="video">
                  <iframe 
				    id="movie-video" 
				    width="1900" 
				    height="1080" 
				    src="https://www.youtube.com/embed/4DM8_51bz-c?autoplay=1&mute=1" 
				    title="YouTube video player" 
				    frameborder="0" 
				    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
				    allowfullscreen>
				</iframe>
            </div>
            <div id="content1_detail">
                <div id="detail_main">
                    <div id="main_blank">
                        <div id="blank_blank"></div>
                        <!-- 여기에 영화 제목 -->
                        <div id="detail_title">
                            <a></a>
                        </div>
                    </div>
                    <div id="main_detail">
                        <div id="detail_sum">
                        <!--  -->
                        </div>
                        <div id="another_movie">
                            
                        </div>
                        
                    </div>
                    <div id="main_detail_overlay"></div>
                </div>
            </div>
        </div>  


    </div>

    <div id = "main_content3">
        
        <div id = "main_content3_1">
            <div id = "main_content3_title">
                영화 리뷰
            </div>
            <div id = "content3_real">

                <div id = "content3_thumbnail">
                    <img src="resources/images/posters/wicked1.jpg" alt="위키드">
                </div>
                <div id = "content3_detail">
                    <div id = "content3_summary" style="height:50%; color:white;">
						<h1>위키드</h1><br>
						<h3>작성자 : tenl****</h3>
						<h3>★★★★★</h3>
						<br><br>
						<p>동명의 소설을 N번, 동명의 뮤지컬을 1N번 본 사람으로써, 원작 팬으로써의 엄격한 잣대를 가지고 영화를 보러 갔다. 조금이라도 맘에 안 들면 바로 1점 때릴 생각으로.  그런데 이 영화는, 맘에 안 드는 구석을 전혀 찾을 수 없었다...</p>
						
                    </div>
                    <div id = "content3_subimg">
                        <img src="resources/images/posters/wicked3.jpg" alt="영화 2">
                        <img src="resources/images/posters/wicked4.jpg" alt="영화 2">
                        <img src="resources/images/posters/wicked5.jpg" alt="영화 2">
                    </div>
                </div>

            </div>
          
            <div id="content3_booking">
                <button>예약하러 가기</button>
            </div>

        </div>
       
       

    </div>

    

    <div id = "service">
        <div id ="service1">
            <div id = "service1_img">
                <img src ="resources/images/posters/notification.png">
            </div>
            <div id = "service1_detail">
                <a href="${ pageContext.request.contextPath }/list.no" style="text-decoration:none; color:black;">공지사항</a>
            </div>
        </div>
        <div id = "service1">
            <div id = "service1_img">
                <img src ="resources/images/posters/question.png">
            </div>
            <div id = "service1_detail">
                <a href="${ pageContext.request.contextPath }/list.fa" style="text-decoration:none; color:black;">자주 묻는 질문</a>
            </div>
        </div>
   

    </div>


    <div id="main_content2">
       
        <div id ="content2_real">
            <div id="content2_title">
                최신 상영작
            </div>
        
            <div id="content2_movies">
                

                

                

            </div>
        
            <div id="content2_booking">
                <button onclick="location.href=boxoffice.mo;">더보기</button>
            </div>
        </div>
    </div>

   
	<br><br>
	
	<div style = "width:1400px; height:950px;margin:auto; border:1px solid #E4E0E1;">
	
	<div id = "map_title" style="margin:auto; margin-top:60px; text-align:center;" ><h1 style="color:white;">찾아오시는 길</h1></div>
		<br>
		<br>
        
		<div id="map" style="width:800px;height:600px; margin:auto;"></div><br>
		<div id = "map_title" style="margin:auto; margin-top:60px; text-align:center;" ><h1 style="color:white;">
			서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F, 20F (T: 1544-0000 / F: 02-2000-0000)
		</h1></div>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=516002f043bc29ef122d1d4a95ed7be4"></script>
    </div>



    <script>
    
    	
       const contextPath = "${pageContext.request.contextPath}";
    
       document.addEventListener('DOMContentLoaded', function() {
            // 첫 번째 영화 카드 선택
            setSelectedCard('movie1');
            changeVideo('"https://www.youtube.com/watch?v=4DM8_51bz-c"', '조커');

            // 각 영화 카드 클릭 이벤트 리스너
            document.getElementById('movie1').addEventListener('click', function() {
                changeVideo('images/joker.mp4', '조커');
                setSelectedCard('movie1');
            });

            document.getElementById('movie2').addEventListener('click', function() {
                changeVideo('images/gladiator.mp4', '글래디에이터');
                setSelectedCard('movie2');
            });

            // 선택된 카드에 'selected' 클래스를 추가하는 함수
            function setSelectedCard(selectedId) {
			    // 모든 movie-card에서 'selected' 클래스를 제거
			    var allCards = document.querySelectorAll('.movie-card');
			    allCards.forEach(function(card) {
			        card.classList.remove('selected');
			    });
			
			    // 클릭된 카드에 'selected' 클래스를 추가
			    var selectedCard = document.getElementById(selectedId);
			    if (selectedCard) {
			        selectedCard.classList.add('selected');
			    }
			}
        });

       /*
        function changeVideo(videoSrc, videoTitle) {
            var videoElement = document.getElementById('movie-video');
            var sourceElement = document.getElementById('video-source');
            var titleElement = document.getElementById('detail_title').querySelector('a');

            if (sourceElement) {
                // 비디오 소스 변경
                sourceElement.src = videoSrc;
                videoElement.load();  // 비디오 재로드
            }

            // 제목 변경
            if (titleElement) {
                titleElement.textContent = videoTitle;
            }
        }
		*/
        
        function changeVideo(videoSrc, videoTitle) {
            var videoElement = document.getElementById('movie-video');
            var sourceElement = document.getElementById('video-source');
            var titleElement = document.getElementById('detail_title').querySelector('a');

            if (sourceElement) {
                // 비디오 소스 변경
                sourceElement.src = videoSrc;
                videoElement.load(); // 비디오 재로드
            }

            // 제목 변경
            if (titleElement) {
                titleElement.textContent = videoTitle;
            }
        }
        
        function requireLoginAlert() {
		    alert("로그인이 필요한 기능입니다!");
		}
        
        
        $(document).ready(function () {
            const moviesData = []; // 영화 데이터를 저장할 배열
            let currentIndex = 0; // 현재 표시된 영화의 마지막 인덱스
            const itemsPerPage = 12; // 처음 표시할 영화 수
            const loadMoreCount = 3; // 더보기 클릭 시 추가로 표시할 영화 수

            // 초기 데이터 로드
            callMainEndpoint();
            
            
            // AJAX 요청 함수
            
            function callMainEndpoint() {
                $.ajax({
                    url: "main.do", 
                    type: "POST",
                    dataType: "json",
                    success: function (response) {
                        console.log("Response from main.do:", response);
                        moviesData.push(...response.list3); // 영화 데이터를 배열에 추가
                        renderMovies(); // 초기 렌더링
                        
                        if (response.list1) {
                            renderAnotherMovies(response.list1); // list1 데이터를 렌더링
                        } else {
                            console.error("No data in response.list1:", response);
                            alert("데이터가 없습니다.");
                        }
                        
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX Error:", status, error);
                        alert("데이터를 가져오는 데 실패했습니다.");
                    }
                });
            }
            

            function renderAnotherMovies(moviesData) {
                // 영화 데이터를 렌더링할 대상 div
                var anotherMovieDiv = document.getElementById('another_movie');
                anotherMovieDiv.innerHTML = ''; // 기존 내용을 초기화

                console.log("무비 데이터: ", moviesData);

                
                // moviesData 배열의 각 항목을 순회하며 HTML 생성
                moviesData.forEach(function(movie, index) {
                    var movieCard =
                        '<div class="movie-card" id="movie' + (index + 1) + '" onclick="updateMovieDetail(' + index + ')">' +
                            '<img src="' + contextPath + '/resources/images/posters/' + movie.fileCodename + '" alt="' + movie.movieTitle + '"' +
                            ' onerror="this.onerror=null; this.src=\'' + contextPath + '/resources/images/default.jpg\';">' 
                            +
                            //'<p style = "width">' + movie.movieTitle + '</p>' +
                        '</div>';
                    anotherMovieDiv.innerHTML += movieCard; // 새 카드 추가
                });
                
                moviesData.forEach(function(movie, index) {
                    const movieCardElement = document.getElementById('movie' + (index + 1));
                    if (movieCardElement) {
                        movieCardElement.addEventListener('click', function () {
                            // 비디오와 제목 업데이트
                            changeVideo(movie.imagePath + '/' + movie.fileCodename, movie.movieTitle);
                            setSelectedCard('movie' + (index + 1)); // 선택된 카드 강조
                        });
                    }
                });

                // 전역 변수로 영화 데이터를 저장
                window.moviesData = moviesData;

            }

            // 영화 데이터를 동적으로 렌더링
            function renderMovies() {
    			const container = $("#content2_movies");
			    const maxIndex = Math.min(currentIndex + itemsPerPage, moviesData.length);
			
			    for (let i = currentIndex; i < maxIndex; i++) {
			        const movie = moviesData[i];
			        if (!movie) continue; // 유효하지 않은 데이터 건너뛰기
				
			        console.log(movie.moiveTitle);
			        
			        // 영화 카드 HTML 문자열 생성
			       const movieCard = '<div id="content2_card">' +
					    '<div id="content2_img">' +
					    '<img src="${pageContext.request.contextPath}/resources/images/posters/' 
					    + movie.fileCodename 
					    + '" alt="' 
					    + movie.movieTitle + '"' +
				        ' onerror="this.onerror=null; this.src=\'${pageContext.request.contextPath}/resources/images/default.jpg\';">' +
					    '</div>' +
					    '<div class="movie-title">' + movie.movieTitle + '</div>' +
					'</div>';
			
			        container.append(movieCard); // 영화 카드를 컨테이너에 추가
			    }
			
			    currentIndex = maxIndex;
			
			    
			    if (currentIndex >= moviesData.length) {
			        $("#content2_booking button").hide();
			    }
			}
           


            // "더보기" 버튼 클릭 이벤트
            $("#content2_booking button").click(function () {
                const prevIndex = currentIndex;
                const newMaxIndex = Math.min(currentIndex + loadMoreCount, moviesData.length); // 최대 인덱스 계산

                if (prevIndex === newMaxIndex) {
                    $(this).hide(); // 더 이상 데이터가 없으면 버튼 숨기기
                } else {
                    renderMovies(); // 추가 영화 렌더링
                }
            });
        });
        
        function updateMovieDetail(index) {
            const movie = moviesData[index];

            // 제목 업데이트
            var titleElement = document.getElementById('detail_title').querySelector('a');
            titleElement.textContent = movie.movieTitle;

            // 상세 설명 업데이트
            //var descriptionElement = document.getElementById('detail_sum').querySelector('a');
            //descriptionElement.textContent = movie.description;

            // 동영상 업데이트
            
            
            var iframe = document.getElementById('movie-video');
            const videoId = movie.trailer.split('v=')[1]; // YouTube Video ID 추출
            
            console.log("비디오 아이디 : " +videoId);
            
            iframe.src = "https://www.youtube.com/embed/" + videoId + "?autoplay=1&mute=1&controls=0&loop=1";
        }
        
        
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.533813, 126.896863), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(37.533813, 126.896863); 
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
       
		
    </script>

	
	
	<jsp:include page="common/footer.jsp" />
	
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
</body>
</html>