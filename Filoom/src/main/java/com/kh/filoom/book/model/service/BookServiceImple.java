package com.kh.filoom.book.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.filoom.book.model.dao.BookDao;
import com.kh.filoom.book.model.vo.Booking;
import com.kh.filoom.book.model.vo.BookingSeat;
import com.kh.filoom.book.model.vo.Playing;
import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.coupon.model.vo.CouponUser;
import com.kh.filoom.member.model.vo.Member;
import com.kh.filoom.movie.model.vo.Movie;


@Service
public class BookServiceImple implements BookService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BookDao bookDao;

	@Override
	public ArrayList<Movie> selectList() {
		// TODO Auto-generated method stub
		return bookDao.selectList(sqlSession);
	}
	
	@Override
	public ArrayList<Movie> selectFirstMovie() {
		
		return bookDao.selectFirstMovie(sqlSession);
		
	}

	@Override
	public ArrayList<Movie> selectMovie(int movieNo) {
		return bookDao.selectMovie(sqlSession, movieNo);
	}

	@Override
	public ArrayList<Playing> selectMovieDate(int movieNo) {
		// TODO Auto-generated method stub
		return bookDao.selectMovieDate(sqlSession, movieNo);
	}

	@Override
	public ArrayList<BookingSeat> selectMovieSeat(int playingNo) {
		// TODO Auto-generated method stub
		return bookDao.selectMovieSeat(sqlSession, playingNo);
	}

	@Override
	@Transactional
	public int insertBookingSeat(BookingSeat bk) {
		// TODO Auto-generated method stub
		return bookDao.insertBookingSeat(sqlSession, bk);
	}

	
	@Override
	@Transactional
	public int deleteBookingSeat(BookingSeat bk) {
		// TODO Auto-generated method stub
		return bookDao.deleteBookingSeat(sqlSession, bk);
	}

	@Override
	@Transactional
	public int deleteBookingListList(ArrayList<BookingSeat> abk) {
		// TODO Auto-generated method stub
		return bookDao.deleteBookingListList(sqlSession, abk);
	}

	@Override
	public ArrayList<Movie> movieSearch(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bookDao.movieSearch(sqlSession, map);
	}
	
	
	@Override
	public ArrayList<Movie> selectSearchFirstMovie(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bookDao.selectSearchFirstMovie(sqlSession, map);
	}
	
	@Override
	@Transactional
	public int isSeatAlreadyBooked(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bookDao.isSeatAlreadyBooked(sqlSession, map);
	}
	
	@Override
	public ArrayList<Movie> selectListKid() {
		// TODO Auto-generated method stub
		return bookDao.selectListKid(sqlSession);
	}

	@Override
	public ArrayList<Movie> selectFirstMovieKid() {
		// TODO Auto-generated method stub
		return bookDao.selectFirstMovieKid(sqlSession);
	}
	
	
	@Override
	public ArrayList<Movie> movieSearchKid(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bookDao.movieSearchKid(sqlSession, map);
	}

	@Override
	public ArrayList<Movie> selectSearchFirstMovieKid(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return bookDao.selectSearchFirstMovieKid(sqlSession, map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//결제===========================================================================


	//좌석등록하기 
	@Override
	@Transactional
	public int insertBookingSeats(int playingNo, ArrayList<String> seatNos) {
		return bookDao.insertBookingSeats(sqlSession,playingNo,seatNos);
		
	}	
	
	
	//1. 좌석 유효성 검사 + 상영좌석일렬번호 반환 oo
	@Override
	public ArrayList<BookingSeat> checkAndGetBookingSeatNoList(ArrayList<String> seatNos,int playingNo,ArrayList<String> bookingSeatNos) {
		
		ArrayList<BookingSeat> bookingSeatNoList = bookDao.checkAndGetBookingSeatNoList(sqlSession,seatNos,playingNo,bookingSeatNos);
		return bookingSeatNoList;
	}


	//5. 사용가능한 쿠폰리스트조회
	@Override
	public ArrayList<CouponUser> selectListCouponUser(int userNo) {
		
		return bookDao.selectListCouponUser(sqlSession,userNo);
	}

	//6. 회원정보조회
	@Override
	public Member selectMember(int userNo) {
		return bookDao.selectMember(sqlSession,userNo);
	}

	//7. 상영번호로 영화정보 조회
	@Override
	public Movie selectMovieForPlayingNo(int playingNo) {
		return bookDao.selectMovieForPlayingNo(sqlSession,playingNo);
	}

	//결제전 쿠폰 유효성 검사
	@Override
	public int selectCheckCoupon(List<Integer> couponNos,int userNo) { 
		return bookDao.selectCheckCoupon(sqlSession,couponNos,userNo);
	}

	//유효성 테스트 통과x, bookNo 지우기
	@Override
	public int deleteBookNo(int bookNo, int userNo) {
		return bookDao.deleteBookNo(sqlSession,bookNo,userNo);
	}




	//예매된 좌석 처리
	@Override
	public int updateBookingSeatDone(ArrayList<BookingSeat> bookingSeatNoList,int bookNo) {
		return bookDao.updateBookingSeatDone(sqlSession,bookingSeatNoList,bookNo);
	}

	//사용된 쿠폰 처리
	@Override
	public int updateCouponUserDone(ArrayList<Integer> couponNos, int bookNo,int userNo) {
		return bookDao.updateCouponUserDone(sqlSession,couponNos,bookNo,userNo);
	}

	//좌석 삭제처리
	//
	@Override
	public int deleteBookingSeats(ArrayList<String> bookingSeatNos) {
		return bookDao.deleteBookingSeats(sqlSession,bookingSeatNos);
	}

	//결제 실패시 예매내역삭제
	@Override
	public int deleteBooking(int bookNo,int userNo) {
		return bookDao.deleteBooking(sqlSession,bookNo,userNo);
	}

	//쿠폰 사용시, 사용한 쿠폰 데이터 조회
	@Override
	public ArrayList<CouponUser> selectListCouponUserList(int bookNo) {
		
		return bookDao.selectListCouponUserList(sqlSession,bookNo);
	}



	//결제 취소 요청 (BOOKING, BOOKING_SEAT, COUPON_USER)
	@Transactional
	@Override
	public int cancelUpdateBooking(int bookNo, int userNo) {
		int result =1;
		//BOOKING 취소처리
		result *= bookDao.cancelUpdateBooking(sqlSession,bookNo,userNo);
		//쿠폰 취소처리
		result *= bookDao.cancelUpdateCouponUser(sqlSession,bookNo,userNo);
		//좌석취소처리
		result *= bookDao.cancelupdateBookingSeat(sqlSession,bookNo);
		return result;
	}

	//결제 취소 유효성 검사
	@Override
	public int checkCancelBooking(int bookNo, int userNo) {
		return bookDao.checkCancelBooking(sqlSession,bookNo,userNo);
	}


	//영화 예매 booking insert
	@Override
	public int insertSelectBooking(Booking booking) {
		return bookDao.insertSelectBooking(sqlSession,booking); 
	}
	
	//예매정보 조회 
	@Override 
	public Booking selectBooking(int bookNo) {
		
		return bookDao.selectBooking(sqlSession, bookNo);
	}

	//조건 없는 북킹시트 조회용
	@Override
	public ArrayList<BookingSeat> selectBookingSeatList(ArrayList<String> bookingSeatNos) {
		
		return bookDao.selectBookingSeatList(sqlSession,bookingSeatNos);
	}
	
	
	
	//관리자 
	
	
	
	@Override
	public int selectBookingCount(String bookNo, String userId) {
		return bookDao.selectBookingCount(sqlSession,bookNo,userId);
	}
	
	@Override
	public ArrayList<Booking> selectBookingListAdmin(PageInfo pi, String sorting, String bookNo, String userId) {
		return bookDao.selectBookingListAdmin(sqlSession,pi,sorting,bookNo,userId);
	}









}
