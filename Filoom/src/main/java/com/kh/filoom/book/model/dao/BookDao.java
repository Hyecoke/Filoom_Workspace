package com.kh.filoom.book.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.filoom.book.model.vo.Booking;
import com.kh.filoom.book.model.vo.BookingSeat;
import com.kh.filoom.book.model.vo.Playing;
import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.coupon.model.vo.CouponUser;
import com.kh.filoom.member.model.vo.Member;
import com.kh.filoom.movie.model.vo.Movie;
import com.kh.filoom.movie.model.vo.MovieWithPoster;


@Repository
public class BookDao {

	public ArrayList<Movie> selectList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.selectList");
	}

	public ArrayList<Movie> selectFirstMovie(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.selectFirstMovie");
	}
	
	public ArrayList<Movie> selectMovie(SqlSessionTemplate sqlSession, int movieNo) {
		return (ArrayList)sqlSession.selectList("movieMapper.selectMovie", movieNo);
	}

	public ArrayList<Playing> selectMovieDate(SqlSessionTemplate sqlSession, int movieNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("bookMapper.selectMovieDate", movieNo);
	}


	public ArrayList<BookingSeat> selectMovieSeat(SqlSessionTemplate sqlSession, int playingNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("bookMapper.selectMovieSeat", playingNo);
	}

	public int insertBookingSeat(SqlSessionTemplate sqlSession, BookingSeat bk) {
		// TODO Auto-generated method stub
		return sqlSession.insert("bookMapper.insertBookingSeat", bk);
	}

	public int deleteBookingSeat(SqlSessionTemplate sqlSession, BookingSeat bk) {
		// TODO Auto-generated method stub
		return sqlSession.delete("bookMapper.deleteBookingSeat", bk);
	}

	public int deleteBookingListList(SqlSessionTemplate sqlSession, ArrayList<BookingSeat> abk) {
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("list", abk);
		
		// System.out.println("paramMap :" + paramMap);
		
		return sqlSession.delete("bookMapper.deleteBookingListList", paramMap);
	}

	
	public ArrayList<Movie> movieSearch(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.movieSearch", map);
	}

	public ArrayList<Movie> selectSearchFirstMovie(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.selectSearchFirstMovie", map);
	}
	
	
	public int isSeatAlreadyBooked(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("bookMapper.isSeatAlreadyBooked", map);
	}
	
	
	public ArrayList<Movie> selectListKid(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.selectListKid");
	}
	
	public ArrayList<Movie> selectFirstMovieKid(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.selectFirstMovieKid");
	}
	
	public ArrayList<Movie> movieSearchKid(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.movieSearchKid", map);
	}

	public ArrayList<Movie> selectSearchFirstMovieKid(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("movieMapper.selectSearchFirstMovieKid", map);
	}
	
	
	
	
	
	
	//결제===========================================================================
	

	
	//유효성 검사 + 좌석일렬번호 검사
	public ArrayList<BookingSeat> checkAndGetBookingSeatNoList(SqlSessionTemplate sqlSession,
															   ArrayList<String> seatNos, 
															   int playingNo,
															   ArrayList<String> bookingSeatNos) {
		HashMap<String,Object> map = new HashMap<>();
		map.put("seatNos", seatNos);
		map.put("playingNo", playingNo);
		map.put("bookingSeatNos", bookingSeatNos);
		return (ArrayList)sqlSession.selectList("bookMapper.checkAndGetBookingSeatNoList",map); 							
	}


	//회원정보조회
	public Member selectMember(SqlSessionTemplate sqlSession, int userNo) {
		
		return sqlSession.selectOne("memberMapper.selectMember",userNo);
	}

	//영화,상영정보
	public Movie selectMovieForPlayingNo(SqlSessionTemplate sqlSession, int playingNo) {
		return sqlSession.selectOne("movieMapper.selectMovieForPlayingNo",playingNo);
	}


	//쿠폰조회
	public ArrayList<CouponUser> selectListCouponUser(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("couponMapper.selectListCouponUser",userNo);
	}


	//쿠폰 검사
	public int selectCheckCoupon(SqlSessionTemplate sqlSession, List<Integer> couponNos,int userNo) {
		
		Map<String,Object> map = new HashMap();
		map.put("couponNos", couponNos);
		map.put("userNo", userNo);
		
		return sqlSession.selectOne("couponMapper.selectCheckCoupon",map);
	}


	public int deleteBookNo(SqlSessionTemplate sqlSession, int bookNo, int userNo) {
		Map<String,Object> map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("userNo", userNo);
		return sqlSession.delete("bookMapper.deleteBookNo",map);
	}

	public int insertBookingSeats(SqlSessionTemplate sqlSession, int playingNo, ArrayList<String> seatNos) {
		Map<String,Object>map=new HashMap();
		map.put("playingNo", playingNo);
		int insertResult =1;
		for(String seatNo : seatNos) {
			map.put("seatNo", seatNo);
			insertResult *= sqlSession.insert("bookMapper.insertBookingSeats",map);
		}

		return insertResult; 
		
	}
	
	
	


	//예매된 좌석 업데이트
	public int updateBookingSeatDone(SqlSessionTemplate sqlSession, ArrayList<BookingSeat> bookingSeatNoList,int bookNo) {
		Map<String,Object> map = new HashMap();
		map.put("bookingSeatNoList", bookingSeatNoList);
		map.put("bookNo", bookNo);
		return sqlSession.update("bookMapper.updateBookingSeatDone",map);
	}

	public int updateCouponUserDone(SqlSessionTemplate sqlSession, ArrayList<Integer> couponNos, int bookNo,int userNo) {
		Map<String,Object> map = new HashMap();
		map.put("couponNos", couponNos);
		map.put("bookNo", bookNo);
		map.put("userNo", userNo);
		return sqlSession.update("couponMapper.updateCouponUserDone",map);
	}

	
	

	public int deleteBookingSeats(SqlSessionTemplate sqlSession, ArrayList<String> bookingSeatNos) {
		
		return sqlSession.delete("bookMapper.deleteBookingSeats",bookingSeatNos);
	}

	public int deleteBooking(SqlSessionTemplate sqlSession, int bookNo,int userNo) {
		Map<String,Integer> map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("userNo", userNo);
		return sqlSession.delete("bookMapper.deleteBooking",map);
	}

	public ArrayList<CouponUser> selectListCouponUserList(SqlSessionTemplate sqlSession, int bookNo) {
		return (ArrayList)sqlSession.selectList("couponMapper.selectListCouponUserList",bookNo);
	}

	

	public int cancelUpdateBooking(SqlSessionTemplate sqlSession, int bookNo, int userNo) {
		Map<String,Integer> map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("userNo", userNo);
		return sqlSession.update("bookMapper.cancelUpdateBooking",map);
	}

	public int checkCancelBooking(SqlSessionTemplate sqlSession, int bookNo, int userNo) {
		Map<String,Integer> map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("userNo", userNo);
		return sqlSession.selectOne("bookMapper.checkCancelBooking",map);
	}

	public int cancelUpdateCouponUser(SqlSessionTemplate sqlSession, int bookNo, int userNo) {
		Map<String,Integer> map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("userNo", userNo);
		return sqlSession.update("couponMapper.cancelUpdateCouponUser",map);
	}

	public int cancelupdateBookingSeat(SqlSessionTemplate sqlSession, int bookNo) {
		return sqlSession.delete("bookMapper.cancelupdateBookingSeat",bookNo);
	}

	
	
	/////////////////////////////////////////////
	//관리자 예매관리
	
	
	public int selectBookingCount(SqlSessionTemplate sqlSession, String bookNo, String userId) {
		Map<String,Object> map = new HashMap();
		map.put("bookNo", bookNo);
		map.put("userId", userId);
		
		return sqlSession.selectOne("bookMapper.selectBookingCount",map);
	}

	public ArrayList<Booking> selectBookingListAdmin(SqlSessionTemplate sqlSession, 
													 PageInfo pi, 
													 String sorting,
													 String bookNo, 
													 String userId) {
		
		//인젝션 어택 방지
		sorting = sorting.equals("desc") ? "desc" : "asc";
		
		Map<String,Object> map = new HashMap();
		map.put("startNum", pi.getStartNum());
		map.put("endNum", pi.getEndNum());
		map.put("sorting",sorting);
		map.put("userId", userId);
		map.put("bookNo", bookNo);
		
		
		System.out.println(userId);
		System.out.println(bookNo);
		
		return (ArrayList)sqlSession.selectList("bookMapper.selectBookingListAdmin",map);
	}

	
	
	//영화 예매 처리
		public int insertSelectBooking(SqlSessionTemplate sqlSession, Booking booking) {
			return sqlSession.insert("bookMapper.insertSelectBooking",booking);
		}
		
		
	//예매번호로 예매내역조회
	public Booking selectBooking(SqlSessionTemplate sqlSession, int bookNo) {
		return (Booking)sqlSession.selectOne("bookMapper.selectBooking",bookNo);
	}

	public ArrayList<BookingSeat> selectBookingSeatList(SqlSessionTemplate sqlSession,
			ArrayList<String> bookingSeatNos) {
		return (ArrayList)sqlSession.selectList("bookMapper.selectBookingSeatList",bookingSeatNos);
	}



}
