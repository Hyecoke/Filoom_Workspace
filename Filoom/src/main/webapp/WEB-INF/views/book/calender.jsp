<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 예매</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="resources/css/aaa.css" />
    <link rel="stylesheet" href="resources/css/cinema_list.css" />
    <link rel="stylesheet" href="resources/css/caa.css" />
</head>
<body>
    <div id="calendar">
        <!-- 월 선택 -->
        <div id="month_area">
            <button onclick="previousMonth()">이전</button>
            <span id="yearAndMonth"></span>
            <button onclick="nextMonth()">다음</button>
        </div>

        <!-- 달력 -->
        <div id="calendar_area">
            <table>
                <thead>
                    <tr>
                        <th>Sun</th>
                        <th>Mon</th>
                        <th>Tue</th>
                        <th>Wed</th>
                        <th>Thu</th>
                        <th>Fri</th>
                        <th>Sat</th>
                    </tr>
                </thead>
                <tbody id="calendar_body"></tbody>
            </table>
        </div>
    </div>

    <div id="movie_info">
        <h3>선택한 날짜의 영화 정보</h3>
        <div id="movie_details"></div>
    </div>

    <script>
        const today = new Date();
        let currentYear = today.getFullYear();
        let currentMonth = today.getMonth();

        // 샘플 데이터
        const movieData = [
            { playingNo: 1, playTime: "2024-12-07 14:30:00", screenNo: 1, seatCount: 40, totalCount: 60 },
            { playingNo: 2, playTime: "2024-12-07 17:30:00", screenNo: 2, seatCount: 50, totalCount: 50 },
            { playingNo: 3, playTime: "2024-12-08 19:30:00", screenNo: 3, seatCount: 20, totalCount: 40 },
            { playingNo: 4, playTime: "2024-12-09 14:30:00", screenNo: 1, seatCount: 60, totalCount: 60 },
            { playingNo: 5, playTime: "2024-12-10 10:30:00", screenNo: 2, seatCount: 15, totalCount: 50 }
        ];

        // 캘린더 표시
        function showCalendar(year, month) {
            const firstDay = new Date(year, month, 1).getDay();
            const totalDays = new Date(year, month + 1, 0).getDate();
            const calendarBody = $("#calendar_body");
            calendarBody.empty();

            const yearMonthText = ${year}-${String(month + 1).padStart(2, "0")}`;
            $("#yearAndMonth").text(yearMonthText);
            
            let date = 1;
            for (let i = 0; i < 6; i++) {
                const row = $("<tr></tr>");
                for (let j = 0; j < 7; j++) {
                    const cell = $("<td></td>");
                    if (i === 0 && j < firstDay || date > totalDays) {
                        row.append(cell);
                    } else {
                        const fullDate = `${year}-${String(month + 1).padStart(2, "0")}-${String(date).padStart(2, "0")}`;
                        cell.text(date);
                        cell.addClass(movieData.some(movie => movie.playTime.includes(fullDate)) ? "has_movie" : "no_movie");
                        cell.on("click", () => showMovieInfo(fullDate));
                        row.append(cell);
                        date++;
                    }
                }
                calendarBody.append(row);
                if (date > totalDays) break;
            }
        }

        // 영화 정보 표시
        function showMovieInfo(date) {
            const movies = movieData.filter(movie => movie.playTime.includes(date));
            const detailsDiv = $("#movie_details").empty();
            if (movies.length === 0) {
                detailsDiv.text("상영 정보가 없습니다.");
            } else {
                movies.forEach(movie => {
                    const info = `
                        <p>상영 번호: ${movie.playingNo}</p>
                        <p>상영 시간: ${movie.playTime}</p>
                        <p>상영관: ${movie.screenNo}</p>
                        <p>좌석: ${movie.seatCount} / ${movie.totalCount}</p>
                        <hr>
                    `;
                    detailsDiv.append(info);
                });
            }
        }

        // 이전 달로 이동
        function previousMonth() {
            if (currentMonth === 0) {
                currentYear--;
                currentMonth = 11;
            } else {
                currentMonth--;
            }
            showCalendar(currentYear, currentMonth);
        }

        // 다음 달로 이동
        function nextMonth() {
            if (currentMonth === 11) {
                currentYear++;
                currentMonth = 0;
            } else {
                currentMonth++;
            }
            showCalendar(currentYear, currentMonth);
        }

        // 초기 캘린더 표시
        $(document).ready(() => {
            showCalendar(currentYear, currentMonth);
        });
    </script>
</body>
</html>
