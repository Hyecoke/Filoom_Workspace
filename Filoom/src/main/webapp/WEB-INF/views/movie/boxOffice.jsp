<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>꿈을 돌리는 영사기, Filoom</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    
    <!-- fontawesome 연동 - 검색 아이콘 넣을 용도 -->
    <!-- ※ 계정을 파야 embed code를 제공해주던데
     혹시 다른 분들 자리에서도 검색 아이콘 뜨는지 확인바람
     참고로 이거 무료는 한 달에 1만 번 로드 횟수 제한 있으니까 테스트할 때는 비활성화 필요함
     Ctrl+Q,S로 여는 프리뷰 창도 카운트 되는 것으로 알고 있음 -->
    <script src="https://kit.fontawesome.com/4c4be5559b.js" crossorigin="anonymous"></script>

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

        .backStage>#title {
            display:inline-block;
        }

        .backStage h1 {
            font-size:45px;
            padding-left:40px;
            margin-top:20px;
        }

        #showMore {
            text-align:right;
            padding-right:120px;
            font-size:30px;
        }
        
        /* === 영화 목록 바로 위 설정란 === */
        /* === Toggle Switch === */
        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 22px;
            vertical-align:middle;
        }

        /* Hide default HTML checkbox */
        .switch input {display:none;}

        /* The slider */
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #939393;
            -webkit-transition: .4s;
            transition: .4s;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 2px;
            bottom: 2px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
        }

        input:checked + .slider {
            background-color: #AB886D;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #67503F;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(18px);
            -ms-transform: translateX(18px);
            transform: translateX(18px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }

        /* === Toggle Switch END === */

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

        .movie-info {
            font-size:20px;
            
        }

        /* 페이징바 */
        .pagingbar {
            margin-bottom:10px;
        }

        .pagingbar button {
            border:0;
            background-color: transparent;
            color:white;
            font-size:32px;
            font-weight:lighter;
        }

        .pagingbar button:hover {
            transform: scale(1.1);
            font-weight: normal;
        }

    </style>
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <div class="backStage">
        
        <div class="movie-pool" align="center">
            <div id="title" align="left">
                <h1>박스 오피스</h1>
            </div>
            
            <hr style="width:95%;">

            <div style="display:flex; justify-content:space-between;">
                <div class="left" style="padding-left:30px;">
                    <label for="openedOnly">상영중인 영화만 표시</label>    
                        <label class="switch">
                            <input id="openedOnly" type="checkbox" onchange="toggleSwitch();">
                            <span class="slider round"></span>
                        </label>
                </div>

                <!-- ※ 상세 정렬 기준
                 default : MOVIE_NO 역순 (관리자 측 영화 목록과 동일)
                 개봉순 : "현재 상영작" 중 개봉이 빠른 순.
                 평점순 : "현재 상영작" 중 리뷰 평점 높은 순, 같을 경우 개봉이 빠른 순
                    ※ 재개봉작의 개봉일자는 마지막 재개봉 날짜로 간주
                 ※ 위 두 정렬 기준 사용 중에는 switch#openedOnly가 ON으로 고정
                 이름순 = 한글 제목을 기준으로 ㄱ-ㅎ, 0-9 순
                  -->
                <div class="middle">
                    <!-- <p>정렬 기준 |</p> -->
                    정렬 기준 |
                    <a href="javascript:listbyOpenedOrder(1);">개봉순</a>
                    <a href="javascript:listbyCritics(1);">평점순</a>
                    <a href="javascript:listbyName(1);">이름순</a>
                </div>
                <div class="right" style="padding-right:30px;">
                    <input type="search" class="search-bar" placeholder="제목으로 검색..."
                    	name="keyword" value="${requestScope.keyword}">
                    <i class="fa-solid fa-magnifying-glass"
                    	onclick="searchMovie();"></i>
                    <!-- ↑ 이게 검색 아이콘인데 횟수 절약을 위해 잠시 비활성화 처리하였음 -->
                </div>
            </div>
            <br>

			<div class="movie-list">
	            <!--  -->
            </div>

        </div>
        
        <script>
        	$(function() {
        		viewAll(1);
        	});
        	
        	function toggleSwitch() {
        		// alert($("#openedOnly").prop("checked"));
        		if(!$("#openedOnly").prop("checked")) {
        			viewAll(1);
        		} else {
        			openedOnly(1);
        		}
        	}
        	
        	// 별도의 jsp에 JSTL을 적용한 것을 AJAX로 띄우는 방식
        	// 출처: https://velog.io/@hana78786/Ajax를-활용하여-jstl-적용하기
        	function viewAll(cpage) {
        		$.ajax({
    				url: "viewall.mo?cpage="+cpage,
    				type: "get",
    				dataType:"html",
    				
    				success: function(result) {
    					$(".movie-list").empty();
    					$(".movie-list").append(result);
    					refreshPagingBar('all', cpage);
    				},
    				error: function() {
    					alert("Mission Failure");
    				}
    			});	
        	}
        	
        	function openedOnly(cpage) {
        		$.ajax({
    				url: "viewopened.mo?cpage="+cpage,
    				type: "get",
    				dataType:"html",
    				
    				success: function(result) {    					
    					$(".movie-list").empty();
    					$(".movie-list").append(result);
    					refreshPagingBar('open', cpage);
    				},
    				error: function() {
    					alert("Mission Failure");
    				}
    			});
        	}
        	
        	// 상영작 한정 스위치 체크 여부에 따라 함수 나누고 싶은데 고민 중
        	function listbyOpenedOrder(cpage) {
        		$.ajax({
    				url: "openorder.mo?cpage="+cpage,
    				type: "get",
    				dataType:"html",
    				
    				success: function(result) {
    					$(".movie-list").empty();
    					$(".movie-list").append(result);
    					refreshPagingBar('order', cpage);
    				},
    				error: function() {
    					alert("Mission Failure");
    				}
    			});
        	}
        	
        	function listbyCritics(cpage) {
        		$.ajax({
    				url: "criticchoice.mo?cpage="+cpage,
    				type: "get",
    				dataType:"html",
    				
    				success: function(result) {    					
    					$(".movie-list").empty();
    					$(".movie-list").append(result);
    					refreshPagingBar('critic', cpage);
    				},
    				error: function() {
    					alert("Mission Failure");
    				}
    			});
        	}
        	
        	// '이름순'을 눌렀을 때, '상영중인 영화만 표시' 스위치가 켜져 있으면 상영중인 영화만 가지고 정렬함
        	function listbyName(cpage) {

        		$.ajax({
//         			if($("#openedOnly").prop("checked")) {
//         				url: "nameorderplaying.mo?cpage="+cpage
//         			} else {
//         				url: "nameorder.mo?cpage="+cpage
//         			},
					url: ($("#openedOnly").prop("checked") ? "nameorderplaying" : "nameorder")
						+".mo?cpage="+cpage,
    				type: "get",
    				dataType:"html",
    				
    				success: function(result) {
    					$(".movie-list").empty();
    					$(".movie-list").append(result);
    					refreshPagingBar('name', cpage);
    				},
    				error: function() {
    					alert("Mission Failure");
    				}
    			});

        	}
        	
        	function searchMovie() {
        		let keyword = $("input[name=keyword]").val();
        		console.log(keyword);
        		// status = '상영중인 영화만 표시' 스위치 체크 여부
        		let status = $("#openedOnly").prop("checked") ? 1 : 0;
        		if(keyword != "") {
        			$.ajax({
	        			url: "searchMovie.mo",
	        			type: "get",
	        			data: {"keyword" : keyword, "status" : status},
	        			dataType:"html",
	        			
	        			success: function(result) {
	    					$(".movie-list").empty();
	    					$(".movie-list").append(result);
	    					$(".pagingbar").empty();
	    					//refreshPagingBar(??);
	    					/* 검색 기능에서는 일부러 페이징바를 넣지 않으려고 하는데
	    					 더미데이터(30편)에서 '아' 한 글자로 검색해도 10편 정도밖에 안 되기 때문임
	    					 대신 페이징바를 없애는 기능으로 구현하였음
	    					*/
	    				},
	    				error: function() {
	    					alert("Mission Failure");
	    				}
        			});
        		}
        	}
        	
        	
        	function refreshPagingBar(sort, cpage) {
        		$(".pagingbar").empty();
        		let link = '';
        		let pgbar = '';

        		switch(sort) {
        			case 'all' : link ="viewAll("; break;
        			case 'open' : link ="openedOnly("; break;
        			case 'order' : link = "listbyOpenedOrder("; break;
        			case 'critic' : link = "listbyCritics("; break;
        			case 'name' : link = "listbyName("; break;
        			// default : alert('오류가 발생했습니다.'); return;
        		}

        		// EL 태그를 function 안에 쓸 수 없어서 다른 방법을 연구하는 중
        		// 여기만 해결하면 진짜 끝남
     
        		let start = $("#first").val();
        		let end = $("#last").val();
        		let max = $("#MX").val();
        		
        		console.log("start = " + start + ", end = " + end + ", max = " + max);
        				
    			// '<<', '<' 처리
        		if(cpage > 1) {
        			// add &lt;&lt;
        			// add &lt;
        			pgbar += "<button onclick= '" + link + "1);'>&lt;&lt;</button> <!-- to Page1 -->"
        				+ "<button onclick= '" + link + (cpage-1) + ");'>&lt;</button> <!-- Prev -->";
        		}

        		for(let i = start; i <= Math.min(end,max); i++) {

        			if(i == cpage) {
        				// font-weight:normal 넣는 이유 : 나머지는 lighter로 해놨음
        				pgbar += "<button disabled style='font-weight: normal;' onclick= '" + link + i + ");'>"
        					+ i + "</button>";
        			}
        			else {
        				pgbar += "<button onclick= '" + link + i + ");'>" + i + "</button>";
        			}
        		}

        		if (cpage < max) {
        			// add &gt;
        			// add &gt;&gt;
        			pgbar += "<button onclick= '" + link
        					+ (cpage+1) + ");'>&gt;</button> <!-- Next -->"
        				+ "<button onclick= '" + link + max + ")';>&gt;&gt;</button> <!-- to LastPage -->";
        		}

        		$(".pagingbar").html(pgbar);
        		
        	}
        </script>
        <br><br>

        <!-- Paging Bar -->
        <!-- 영화 상세 페이지 때문에 임시 화면 남겨둔 건데 해당 화면 완성되면 이 페이징바(임시)도 같이 삭제할 예정 -->
        <div class="pagingbar" align="center">
            <!-- if i > 1 -->
            <c:if test="${ requestScope.pi.currentPage gt 1 }">
                <button onclick="location.href = 'boxoffice.mo?page=1';">&lt;&lt;</button> <!-- to Page1 -->
                <button onclick="location.href = 'boxoffice.mo?page=${p-1}';">&lt;</button> <!-- prev -->
            </c:if>
            
            <!-- if 3 ≤ i ≤ maxPage-2, for i in range (currentPage -2 ~ +2) -->
            <c:forEach var="p" begin="${requestScope.pi.startPage }" end="${requestScope.pi.endPage }" step="1">
            	<c:choose>
            		<c:when test=""> <!-- button refers to currentPage -->
            			<button class="currentPage" disabled>${p}</button>
            		</c:when>
            		<c:otherwise>
            			<button onclick="location.href = 'boxoffice.mo?page=${p}';">${p}</button>
            		</c:otherwise>
            	</c:choose>
            </c:forEach>

            <!--  if i < maxPage -->
            <c:if test="${ requestScope.pi.currentPage lt requestScope.pi.maxPage }">
                <button onclick="location.href = 'boxoffice.mo?page=${p+1}';">&gt;</button> <!-- next -->    
                <button onclick="location.href = 'boxoffice.mo?page=${requestScope.pi.maxPage}';">&gt;&gt;</button> <!-- to LastPage -->
			</c:if>
        </div>

        
    </div>

    <br><br>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>