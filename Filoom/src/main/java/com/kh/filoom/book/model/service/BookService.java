package com.kh.filoom.book.model.service;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.kh.filoom.book.model.vo.Booking;
import com.kh.filoom.book.model.vo.BookingSeat;
import com.kh.filoom.book.model.vo.Playing;
import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.coupon.model.vo.CouponUser;
import com.kh.filoom.member.model.vo.Member;
import com.kh.filoom.movie.model.vo.Movie;
import com.kh.filoom.movie.model.vo.MovieWithPoster;

public interface BookService {
	
	// 첫페이지) 영화 리스트 조회
	ArrayList<Movie> selectList();

	// 첫페이지 대표 영화 조회
	ArrayList<Movie> selectFirstMovie();
	
	// 첫페이지) AJAX 영화 조회후 선택시 영화 상세설명 조회
	ArrayList<Movie> selectMovie(int movieNo);
	
	// 첫페이지 > 두번쨰페이지) Ajax사용) 
	// 영화 선택 클릭시 영화의 날짜 조회
	ArrayList<Playing> selectMovieDate(int movieNo);
	// playing db의 모든 데이터를 가져오기
	
	// 두번째 > 세번째 해당 날짜 선택 클릭시 해당 날짜의 좌석 조회
	ArrayList<BookingSeat> selectMovieSeat(int playingNo);
	// Seat DB 값 가져오기
	
	// 좌석 클릭시 ajax로 실시간 잠그기
	int insertBookingSeat(BookingSeat bk);

	// 좌석 클릭시 유효한 좌석인지 확인하기
	int isSeatAlreadyBooked(HashMap<String, Object> map);

	// 좌석 클릭시 ajax 실시간 해제
	int deleteBookingSeat(BookingSeat bk);

	// 뒤로가기 및 이전 시 값 삭제
	int deleteBookingListList(ArrayList<BookingSeat> abk);

	// 영화 검색 기능
	ArrayList<Movie> movieSearch(HashMap<String, Object> map);
	
	// 영화 검색 후 첫번째 영화
	ArrayList<Movie> selectSearchFirstMovie(HashMap<String, Object> map);
	
	// 아래 2개는 사용자가 미성년자일 경우
	ArrayList<Movie> selectListKid();
	
	ArrayList<Movie> selectFirstMovieKid();

	ArrayList<Movie> movieSearchKid(HashMap<String, Object> map);

	ArrayList<Movie> selectSearchFirstMovieKid(HashMap<String, Object> map);
	
	
	
	
	
	//결제============================================================

	//좌석등록하기
	int insertBookingSeats(int playingNo, ArrayList<String> seatNos);

	//상영좌석 번호 구하기+유효성검사
	ArrayList<BookingSeat> checkAndGetBookingSeatNoList(ArrayList<String> seatNoList, int playingNo,ArrayList<String> bookingSeatNos);
	
	//사용 가능한 쿠폰 조회하기
	ArrayList<CouponUser> selectListCouponUser(int userNo);

	//회원정보조회
	Member selectMember(int userNo);

	//상영번호로 영화정보 조회
	Movie selectMovieForPlayingNo(int playingNo);

	//결제전 쿠폰 유효성 검사
	int selectCheckCoupon(List<Integer> couponNos, int userNo);

	//유효성 테스트 통과x, bookNo 지우기
	int deleteBookNo(int bookNo, int userNo);

	//결제성공시 예매된 좌석 처리
	int updateBookingSeatDone(ArrayList<BookingSeat> bookingSeatNoList, int bookNo);

	//결제성공시 사용된 쿠폰 처리
	int updateCouponUserDone(ArrayList<Integer> couponNos, int bookNo,int userNo);

	//결제 실패시 좌석 삭제 처리
	int deleteBookingSeats(ArrayList<String> bookingSeatNos);

	//결제실패시 예매내역삭제
	int deleteBooking(int bookNo, int userNo);

	//쿠폰사용시 사용한 쿠폰정보 조회
	ArrayList<CouponUser> selectListCouponUserList(int bookNo);

	//결제 취소 요청
	int cancelUpdateBooking(int bookNo, int userNo);

	//결제 취소 유효성 검사
	int checkCancelBooking(int bookNo, int userNo);


	//결제성공시 영화 예매 처리/예매번호 조회
	int insertSelectBooking(Booking booking);
	
	//
	Booking selectBooking(int bookNo);

	ArrayList<BookingSeat> selectBookingSeatList(ArrayList<String> bookingSeatNos);
	
	////////////////////////////////////////////////
	//관리자 페이지 - 예매관리
	
	//전체 예매내역 조회
	int selectBookingCount(String bookNo, String userId);

	//booking 리스트 조회 - 관리자
	ArrayList<Booking> selectBookingListAdmin(PageInfo pi, String sorting,String bookNo, String userId);
	

	
	
	
}
