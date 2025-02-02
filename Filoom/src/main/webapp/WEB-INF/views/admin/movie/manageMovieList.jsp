<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 관리 :: Filoom</title>
    <link rel="stylesheet" href="resources/css/admin.css" />
    
    <!-- jQuery 연동 구문 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- fontawesome 연동 - 검색 아이콘 넣을 용도 -->
    <!-- ※ 계정을 파야 embed code를 제공해주던데
     혹시 다른 분들 자리에서도 검색 아이콘 뜨는지 확인바람 -->
     <script src="https://kit.fontawesome.com/4c4be5559b.js" crossorigin="anonymous"></script>

    <style>
        #admin_page {
            font-family: "Poppins", sans-serif;
        }

        #admin_title_content {
            color:#493628;
            display:flex;
            justify-content: space-between;
            align-items: center;
            font-size:25px;
        }

        .middle {
            width:30%;
            /* border:1px solid red; */
        }

        .search-bar {
            width:80%;
            height:100%;
        }
        .search-bar::placeholder {
            font-style:italic;
        }
        .fa-magnifying-glass:hover {
            cursor:pointer;
        }

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
            background-color: #67503F;
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

        #button_sample {
            position:fixed;
            bottom:30px;
            right:30px;
            width:150px;
            font-size:20px;
            margin: 0px 35px;
        }

        /* === 목록 표시란 === */
        /* movie_select.html(= boxOffice.jsp)와 동일 */
        .movie-pool {
            height:100%;
            overflow:auto;
        }
        
        .movie {
            display:inline-block;
            /* 이걸로 충분함. 굳이 4x4를 고민할 필요 없음 */
            margin:10px 30px;
            /* font-size:24px; */
            text-align:left;
        }
        .movie * {
            font-size:20px;
        }
        .movie:hover {
            cursor: pointer;
        }

        .poster {
            width:240px;
            /* height:480px; */
            /*  */
            border-radius:5px;
            margin-bottom:5px;
        }

        #filmrate {
            width:50px;
        }
        .filmrate {
            width:45px;
        }
    </style>
</head>
<body>
    <div id = "admin_content">
    	<jsp:include page="../../common/adminHeader.jsp" />
        
        <div id = "admin_right">
            <div id ="admin_title">

                <!-- 여기가 관리자 상단 회원번호, 회원아이디 이런거 적는 곳
                    구상은 각자 알아서~ 
                -->
                <div id = "admin_title_content">
                    <div class="edge_left" style="padding-left:33px;">
                        <p id="fnName" style="font-weight:bold;">영화 관리</p>    
                    </div>

                    <!-- fontawesome 무료 플랜이 한 달에 페이지뷰 1만 번 제한이 있는데
                     프리뷰 창의 페이지뷰도 세는 것 같아서 임시로 다른 img 태그로 대체했음
                     i 태그는 시연할 때만 활성화할 것! -->
                    <div class="middle">
                        <input type="search" class="search-bar" placeholder="제목으로 검색..." value=${requestScope.keyword }>
                        <i class="fa-solid fa-magnifying-glass" onclick="searchMovie();"></i>
                        <!-- <img class="fa-magnifying-glass" src="resources/images/posters/searchicon_pngtree.png"
                            style="width:25px; height: 26px;" onclick="location.href = 'admin.managemovie.mo';"> -->
                    </div>

                    <div class="edge_right" style="padding-right:33px;">
                        <label for="openedOnly">상영중인 영화만 표시</label>    
                        <label class="switch">
                            <input id="openedOnly" type="checkbox"
                                onchange="toggleSwitch();">
                            <span class="slider round"></span>
                        </label>
                    </div>

                </div>

            </div>

            <div id = "admin_detail">
                
                <!-- 여기 안이 관리자 컨텐츠 영역이에요~-->
                <div id ="admin_page">
                    
                    <!--이건 버튼 이랑 text 샘플-->
                    <!-- <input type ="text" id ="text_sample"> -->
                    <input type="button" id ="button_sample" value="영화 추가"
                        onclick="location.href='newmovie.mo';">

                    <div class="movie-pool" align="center">
                        <!-- 사용자 측 박스오피스와는 달리 정렬 기준이 MOVIE_NO DESC 하나로 고정 -->

                        <!-- 페이징 처리 대신 16개 OR 20개 단위로 '더 보기↓' 처리할 계획
                        	세로는 4열 고정이고 가로를 4행할지 5행할지 고민 중
                         
                         ※ 추가로 스크롤 다 내려가면 자동으로 더 보기 하는 기능을 알아보고 있음
                         간단한 기능이라면 이 쪽으로 구현할 예정
                        -->
                        
                        <!--  현재 사용자 쪽 박스 오피스 페이지와 목록 조회 쿼리를 공유하고 있어서
                        	링크도 사용자 쪽 상세 페이지로 연결되고 있는 것이 정상이고
                        	내용물도 16개만 나오고 있는 것이 정상 -->

                        <br>
                       	<div class="movie-list">
<%--                         <c:forEach var="p" begin="1" end="16*cpage"> --%>
<!--                         	<div class="movie"> -->
<!-- 	                            <img src="resources/images/posters/moana.jpg" class="poster"> -->
<!-- 	                            <table class="movie-info"> -->
<!-- 	                                <tr> -->
<!-- 	                                    <td id="filmrate"><img src="resources/images/posters/3.svg" class="filmrate"></td> -->
<!-- 	                                    <td><b>모아나 2</b><br></td> -->
<!-- 	                                </tr> -->
<!-- 	                                <tr> -->
<!-- 	                                    <td colspan="2">2024.11.27 개봉예정</td> -->
<!-- 	                                </tr> -->
<!-- 	                            </table> -->
<!-- 	                        </div> -->
<%--                         </c:forEach> --%>
                       	</div>
            
                    </div>

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

    /* '상영중인 영화만 표시' 스위치를 누를 시, AJAX를 이용하여
     조회 쿼리에 WHERE PREMIERE = 'Y'의 포함 여부를 변경하여
     다시 조회한 것으로 결과 바꾸기
     최초 설정은 OFF
    */
    $(function() {
    	adminList(0);
    })
    
    function toggleSwitch() {
    	let isOpen = $("#openedOnly").prop("checked") ? 1 : 0;
    	adminList(isOpen);
// 		if(!$("#openedOnly").prop("checked")) {
// 			viewAll();
// 		} else {
// 			openedOnly();
// 		}
    }
    
    /*
    // same function as adminList(0)
    function viewAll() {
		$.ajax({
			url: "viewall.mo",
			type: "get",
			dataType:"html",
			
			success: function(result) {
				$(".movie-list").empty();
				$(".movie-list").append(result);
			},
			error: function() {
				alert("Mission Failure");
			}
		});	
	}
	
    // same function as adminList(1)
	function openedOnly() {
		$.ajax({
			url: "viewopened.mo",
			type: "get",
			dataType:"html",
			
			success: function(result) {    					
				$(".movie-list").empty();
				$(".movie-list").append(result);
			},
			error: function() {
				alert("Mission Failure");
			}
		});
	}
	*/
	
	function adminList(isOpen) {
		$.ajax({
			url: "admin.viewlist.mo",
			type: "get",
			data: {"isOpen" : isOpen},
			dataType: "html",
			
			success:function(result) {
				// console.log(result);
				$(".movie-list").empty();
				$(".movie-list").append(result);
			},
			error: function() {
				alert("박스오피스 조회에 실패하였습니다.");
			}
		})
	}
	
	function searchMovie() {
		let keyword = $("input[name=keyword]").val();
		console.log(keyword);
		// status = '상영중인 영화만 표시' 스위치 체크 여부
		let status = $("#openedOnly").prop("checked") ? 1 : 0;
		if(keyword != "") {
			$.ajax({
    			url: "admin.searchMovie.mo",
    			type: "get",
    			data: {"keyword" : keyword, "status" : status},
    			dataType:"html",
    			
    			success: function(result) {
					$(".movie-list").empty();
					$(".movie-list").append(result);
					//$(".pagingbar").empty();
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
    </script>
    
</body>
</html>