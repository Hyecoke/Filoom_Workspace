package com.kh.filoom.movie.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.filoom.movie.model.vo.Movie;
import com.kh.filoom.movie.model.vo.Poster;
import com.kh.filoom.movie.model.vo.Review;

public interface MovieService {
	// 작품 수 체크 - 전체
	int checkVideoCount();
	
	// 작품 수 체크 - 개봉
	int checkOpenedVideoCount();
	
	// 작품 수 체크 - 미개봉
	int checkNotOpenVideoCount();
	
	// === 영화 목록 조회 관련 메소드들 ===
	/*
	 * === 현재 listbyCritics() 빼고 전부 완료 ===
	 * - listbyCritics()도 쿼리와 함수까지 전부 만들어 놓긴 했으나, 
	 * 	REVIEW 테이블과의 JOIN이 필요한 관계로 REVIEW 더미데이터 넣은 후 추가예정
	 * 
	 * movieSelectTop() V
	 * 	└ selectNow4() V
	 * 	└ selectPre4() V
	 * viewBoxOffice(pi) - selectBoxOffice(pi) V
	 * viewOpenedOnly(pi) - selectNowPlaying(pi) V
	 * 		listbyOpenedOrder(pi) V
	 * 		listbyCritics(pi)
	 * 		listbyName(pi) V
	 * 		listbyNamePlaying(pi) V
	 * viewNotOpened(pi) 
	 * 		listbyOpenOrder(pi) - 기본, V
	 * 		listbyNamePre(pi) V
	 * searchMovie() V
	 */
	
	// 영화 탭 HOME
	ArrayList<Movie> selectNow4(); // 박스오피스 TOP 4 (임시로 MOVIE_NO 빠른 순)
	ArrayList<Movie> selectPre4(); // 개봉 예정일순 TOP 4
	
	// 초기 정렬
	ArrayList<Movie> selectBoxOffice(int cpage); // 개봉순
	ArrayList<Movie> selectNowPlaying(int cpage); // 개봉작만
	
	// 정렬 기준
	// 박스 오피스
	ArrayList<Movie> listbyOpenedOrder(int cpage); // 개봉순 (개봉작만)
	ArrayList<Movie> listbyCritics(int cpage); // 평점순(개봉작만)
	ArrayList<Movie> listbyName(int cpage); // 가나다순(전체)
	ArrayList<Movie> listbyNamePlaying(int cpage); // 가나다순(개봉작만)
	
	// 개봉 예정작
	ArrayList<Movie> listbyOpenOrder(int cpage); // 개봉예정 빠른 순 ← 기본 정렬 기준
	ArrayList<Movie> listbyNamePre(int cpage); // 가나다순
	
	// 영화 검색 - status = 0은 전체, 1은 개봉작만, 2는 미개봉작만 
	ArrayList<Movie> searchMovie(HashMap<String, Object> map);
	
	// =======================
	
	// === 영화 상세 페이지 ===
	Movie showDetail(int movieNo); // 상세 정보 조회
	Poster showThumbnail(int movieNo); // 영화 포스터 호호
	ArrayList<Poster> selectImageList(int movieNo); // 스틸컷 목록 조회

	// └ 좋아요 관련
	int checkFavCount(int moiveNo); // 좋아요 수 체크
	int checkTaste(HashMap<String, Integer> map); // 해당 회원이 좋아요를 눌렀는지 확인
	int likeThis(HashMap<String, Integer> map); // 좋아요
	int notLikeThis(HashMap<String, Integer> map); // 안 좋아요
	
	// === 사용자 리뷰 관련 기능 ===
	// 리뷰 목록 조회
	int checkReviewCount(int movieNo);
	ArrayList<Review> selectReview(HashMap<String, Integer> map); // 리뷰 목록 조회 (사용자)
	double checkAverage(int movieNo);
	double checkEvalNo(int movieNo, int k);
	
	int checkUserReview(int userNo);
	int writeReview(Review r);
	int checkRid(int userNo, int movieNo);
	int updateReview(Review r);
	int deleteReview(HashMap<String, Integer> map);
	
	// 이미지 추가 - 영화 추가/수정 공통
	int addPoster(Poster p); // 이미지 추가
	int changePoster(Poster p); // 이미지 변경
	// int deletePoster(int imageId); // 이미지 삭제 - 영화 수정/삭제시 써먹을 의도
	
	// === 관리자 전용 ===
	ArrayList<Movie> adminMovieList(int isOpen);
	
	// === 관리자 영화 추가 페이지 ===
	int addMovie(Movie m);
	int undoAddMovie(int movieNo); // 영화 추가 후 포스터 추가 실패시 써먹을 의도
	
	// === 관리자 영화 수정 페이지 ===
	Movie selectMovietoModify(int movieNo); // 관리자 상세 페이지에서도 활용
	int updateMovie(Movie m);
	
	// === 관리자 영화 삭제 페이지 ===
	int deletePoster(int movieNo); // 포스터 먼저
	int deleteMovie(int movieNo);
	
	// === 관리자 영화 상세 페이지 ===
	// 상세 조회는 selectMovietoModify(movieNo)를 사용
	// premiere : 스위치 눌러서 바뀐 값 기준.
	int togglePremiere(int movieNo, HashMap<String, Integer> map);
	
	// 상영 정보
	ArrayList<Movie> showRunInfo(int movieNo); // 조회
	int checkRunCount(int movieNo); // RunInfo 수 조회
	
	int checkScreen(int screenNo); // 상영관 확인
	int newRunInfo(Movie m); // 추가
	
	int removeRunInfo(int playingNo); // 삭제
	
	
	// === 관리자 리뷰 관련 기능 ===
	Movie checkMovieTitle(int movieNo);
	//ArrayList<Review> adminSelectReview(HashMap<String, Integer> map);
	int adminDeleteReview(int reviewId);
}
