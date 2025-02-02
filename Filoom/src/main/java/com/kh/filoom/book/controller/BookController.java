package com.kh.filoom.book.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;

import java.net.URLEncoder;
import java.net.http.HttpRequest;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kh.filoom.book.model.service.BookService;
import com.kh.filoom.book.model.vo.Booking;
import com.kh.filoom.book.model.vo.BookingSeat;
import com.kh.filoom.book.model.vo.Playing;
import com.kh.filoom.book.payment.DataEncrypt;
import com.kh.filoom.book.payment.nicePayment;
import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.common.template.Pagination;
import com.kh.filoom.coupon.model.vo.CouponUser;
import com.kh.filoom.member.model.vo.Member;
import com.kh.filoom.movie.model.vo.Movie;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BookController {

			
	// 상점키
	private String merchantKey 		= "EYzu8jGGMfqaDEp76gSckuvnaHHu+bC4opsSN6lHv3b2lurNYkVXrZ7Z1AoqQnXI3eLuaUFyoRNC6FkrzVjceg==";
	
	// 상점아이디
	private String merchantID 		= "nicepay00m";
	
	//영화 가격
	static final int PRICE = 100;
	
	@Autowired
	private BookService bookService;

	// 나이스페이 메소드 클래스
	@Autowired
	private nicePayment npay;

	@Autowired
	private DataEncrypt sha256Enc;

	
	
	@GetMapping("book.do")
	public String selectList(Model model, HttpSession session) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		if (loginUser != null) {
		    String birthDate = loginUser.getBirth();
		    System.out.println("사용자 생년월일: " + birthDate);
		}
		
		// 비로그인 상태 예외 처리
	    if (loginUser == null) {
	        return "redirect:/loginForm.me"; 
	        
	    }
	    
	    String birth = loginUser.getBirth(); 
	    int birthYear = Integer.parseInt(birth.substring(0, 4));
	    int currentYear = LocalDate.now().getYear();
	    int age = currentYear - birthYear;
	    
	    /*
		
		ArrayList<Movie> list = bookService.selectList();
		
		ArrayList<Movie> firstMovie = bookService.selectFirstMovie(); 
		
		model.addAttribute("list", list);
		
		model.addAttribute("firstMovie", firstMovie);
		
		//System.out.println(list);
		*/
	    
	    // 나이에 따라 적절한 메서드 호출
	    ArrayList<Movie> list;
	    ArrayList<Movie> firstMovie;

	    if (age >= 19) {
	        // 성인용 영화 리스트
	        list = bookService.selectList();
	        firstMovie = bookService.selectFirstMovie();
	    } else {
	        // 어린이용 영화 리스트
	        list = bookService.selectListKid();
	        firstMovie = bookService.selectFirstMovieKid();
	    }

	    // Model에 추가
	    model.addAttribute("list", list);
	    model.addAttribute("firstMovie", firstMovie);
	    
		return "book/book";
		
	}
	
	
	@ResponseBody
	@GetMapping(value = "movie.de", produces="application/json; charset=UTF-8")
	public ArrayList<Movie> getMovieDetail(@RequestParam("movieNo") int movieNo, Model model) {
		
		//System.out.println(movieNo);
		
		ArrayList<Movie> movie = bookService.selectMovie(movieNo);
		
		model.addAttribute("movie", movie);
		
		// System.out.println(movie);
		
		return movie;
	}
	
	@ResponseBody
	@GetMapping(value="book.ca", produces="application/json; charset=UTF-8")
	public String selectMovieDate(int movieNum) {
		
		// System.out.println(movieNum);
		
		ArrayList<Playing> list = bookService.selectMovieDate(movieNum);
		
		// System.out.println(list);
		
		return new Gson().toJson(list);
		
	}
	
	@ResponseBody
	@GetMapping(value="book.se", produces="application/json; charset=UTF-8")
	public String selectMovieSeat(int playingNo) {
		
		ArrayList<BookingSeat> list = bookService.selectMovieSeat(playingNo);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		
		System.out.println(list);
		
		return new Gson().toJson(list);
		
	}
	
	@ResponseBody
	@GetMapping(value = "book.fb", produces = "application/json; charset=UTF-8")
	public String insertBookingSeat(String seatId, int playingNo, HttpSession session, Model model) {

		Date currentDate = new Date();
		
		System.out.println("book.fb 실행");
		
		System.out.println(seatId);
		System.out.println(playingNo);

		Calendar calendar = Calendar.getInstance();
	    calendar.setTime(currentDate);
	    calendar.add(Calendar.MINUTE, 10000);

	    Date updatedTime = calendar.getTime();
	    // System.out.println("10분 후 시간: " + updatedTime);
	    java.sql.Timestamp sqlUpdatedTime = new java.sql.Timestamp(updatedTime.getTime());
	    
	    BookingSeat bk = new BookingSeat();
	    
	    bk.setSeatId(seatId);
	    bk.setPlayingNo(playingNo);
	    bk.setTimeLimit(sqlUpdatedTime);
	    System.out.println("입력받은 bk :" + bk);
	 
	    int result = bookService.insertBookingSeat(bk);
	    //System.out.println("Insert 결과: " + result);

	    return new Gson().toJson(bk);
	}

	
	
	@ResponseBody
	@GetMapping("book.err")
	public String checkBooking(@RequestParam("seatId") String seatId, @RequestParam("playingNo") int playingNo) {
	    // 중복 확인 로직

	    HashMap<String, Object> map = new HashMap<>();
		
		map.put("seatId", seatId);
		map.put("playingNo", playingNo);
		
		//System.out.println(seatId);
		//System.out.println(playingNo);
		//System.out.println("map :" + map);
		
		int isExist = bookService.isSeatAlreadyBooked(map);
	    
	    if (isExist == 1) {
	        return "이미 값이 존재합니다! 다른 좌석을 선택해주세요!";
	    } else {
	        return "SUCCESS";
	    }
	}
	
	@ResponseBody
	@GetMapping(value = "book.fd", produces = "application/json; charset=UTF-8")
	public String deleteBookingSeat(String seatId, int playingNo, BookingSeat bk, HttpSession session, Model model) {

	    Date currentDate = new Date();

	    ///System.out.println(seatId);
	    // System.out.println(playingNo);

	    Calendar calendar = Calendar.getInstance();
	    calendar.setTime(currentDate);
	    calendar.add(Calendar.MINUTE, 10);

	    // 10분 후의 시간을 구하고 java.sql.Date로 변환
	    Date updatedTime = calendar.getTime();
	    java.sql.Timestamp sqlUpdatedTime = new java.sql.Timestamp(updatedTime.getTime());
	    
	    BookingSeat bkk = new BookingSeat();
	    bkk.setSeatNo(seatId);
	    bkk.setPlayingNo(playingNo);
	    bkk.setTimeLimit(sqlUpdatedTime); // java.sql.Date를 설정

	    // System.out.println("BookingSeat 객체: " + bkk);
	    int result = bookService.deleteBookingSeat(bkk);

	    return new Gson().toJson(bkk);
	}
	
	
	@ResponseBody
	@PostMapping(value="book.re", produces="application/json; charset=UTF-8")
	public String pay(int playingNo, String seatId) {
	
		// System.out.println(playingNo);
		// System.out.println(seatId);
		
		String[] seatArray = seatId.split(",\\s*"); // 쉼표와 공백 기준으로 분리
	    ArrayList<BookingSeat> abk = new ArrayList<>();

	    // 변환된 배열 확인
	    for (String seat : seatArray) {
	        System.out.println("좌석 ID: " + seat);

	        // 필요한 경우 BookingSeat 객체 생성 및 리스트에 추가
	        BookingSeat bookingSeat = new BookingSeat();
	        bookingSeat.setSeatNo(seat.trim());
	        bookingSeat.setPlayingNo(playingNo);
	        abk.add(bookingSeat);
	    }

		// System.out.println(abk);
	    
		
	    int result = bookService.deleteBookingListList(abk);
		
		return new Gson().toJson(abk);
	}
	
	
	@GetMapping("movie.sea")
	public String movieSearch(HttpSession session, String searchMovieKeyword, Model model) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		ArrayList<Movie> firstMovie;
	    ArrayList<Movie> list;

	    if (loginUser != null) {
	        String birth = loginUser.getBirth(); // 생년월일 가져오기
	        int birthYear = Integer.parseInt(birth.substring(0, 4));
	        int currentYear = LocalDate.now().getYear();
	        int age = currentYear - birthYear;

	        map.put("searchMovieKeyword", searchMovieKeyword);

	        // 나이에 따라 적절한 메서드 호출
	        if (age >= 19) {
	            // 성인용 영화 검색
	            firstMovie = bookService.selectSearchFirstMovie(map);
	            list = bookService.movieSearch(map);
	        } else {
	            // 어린이용 영화 검색
	            firstMovie = bookService.selectSearchFirstMovieKid(map);
	            list = bookService.movieSearchKid(map);
	        }
	    } else {
	    	
	        return "redirect:/loginForm.me";
	        
	    }
	    
	    
		model.addAttribute("list", list);
		model.addAttribute("firstMovie", firstMovie);
		
		//System.out.println(moive);
		
		return "book/book";
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//형문/////////////////////////////////////////////////////////////////////////
	
	
	
	//ajax 좌석 삭제 요청 핸들러 메소드
	@ResponseBody
	@PostMapping("deleteSB.pm")
	public String deleteSeats(@RequestBody ArrayList<String> bookingSeatNos) {
		log.debug("==ajax 좌석 삭제 요청 핸들러 메소드 실행 ");
		log.debug("넘어온 값 ArrayList<String> bookingSetatNos : "+bookingSeatNos.toString());
		
		//삭제 메소드
		String deleteResult = deleteBookingSeats(bookingSeatNos);	
		
		return "deleteResult";
	}
	
	
	//좌석삭제 메소드
	public String deleteBookingSeats(ArrayList<String> bookingSeatNos) {
		
		log.debug("====좌석삭제 메소드 실행");
		int result = bookService.deleteBookingSeats(bookingSeatNos);  
		String deleteResult = (result>0 ? "success":"fail");
		log.debug("====좌석삭제 메소드 실행결과 : " +deleteResult);
		return deleteResult;
	}
	
	
	
	
	@PostMapping("paymentForm.pm")
	public ModelAndView paymentFormRequest(ModelAndView mv,HttpSession session,
											int playingNo,  
											@RequestParam("seatNos")ArrayList<String> seatNos
											) {
		log.debug("==결제폼 요청==");
		
		//예매내역 정보 세션 삭제
		session.removeAttribute("resultData");
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		log.debug("매개변수 데이터 : 좌석번호 Array<String> seatNos : "+seatNos +", 상영번호 : "+playingNo + ", 회원정보: " +loginUser );
		
		//상영번호 -> 상영좌석, 상영관정보 조회		
		ArrayList<BookingSeat> bookingSeatList = bookService.checkAndGetBookingSeatNoList(seatNos,playingNo,null);
		log.debug("좌석정보, 상영관정보 : bookingSeatList : " + bookingSeatList);
		
	
		
		if(bookingSeatList.size()==0) { //실패
		
			log.debug("좌석 조회 실패 ");
			session.setAttribute("alertMsg", "다시 시도해주시기 바랍니다");
			mv.setViewName("redirect:book.do");
			
		
		}else { //성공
			

			Movie movie = bookService.selectMovieForPlayingNo(playingNo);
			log.debug("2. 보낼정보 영화정보(+포스터),상영정보,상영관 정보 movie : " + movie.toString());
			
			mv.addObject("movie",movie);
			mv.addObject("bookingSeatList",bookingSeatList);
			mv.addObject("PRICE",PRICE);

			
			mv.setViewName("book/paymentForm");

		}
		
		return mv;
	}

	
	
	//ajax 쿠폰 조회
	@ResponseBody
	@PostMapping(value="couponList.co",produces="application/json; charset=UTF-8")
	public String selectCouponList(int userNo){
		
		//*회원번호 -> 쿠폰리스트
		ArrayList<CouponUser> couponUserList = bookService.selectListCouponUser(userNo);
		log.debug("ajax==사용가능한 쿠폰 조회 couponUserList : "+couponUserList.toString());
		return new Gson().toJson(couponUserList);

	}
	
	
	

	@ResponseBody
	@PostMapping(value="beforePay.pm",produces="application/json; charset=UTF-8")
	public String beforePay(@RequestBody Map<String,Object>data,HttpSession session) {
		
		
		log.debug("=====결제전 ajax 실행======");
		
		ArrayList<String> bookingSeatNos = (ArrayList<String>)data.get("bookingSeatNos");
		//어떻게 변환해야하는거야
		String playingNoStr = (String) data.get("playingNo");
		int playingNo = Integer.parseInt(playingNoStr);
		
		ArrayList<BookingSeat> bookingSeatList = bookService.checkAndGetBookingSeatNoList(null,playingNo,bookingSeatNos);
		String result = "";
		if(bookingSeatList.isEmpty() || bookingSeatList==null) {
			result = "fail";
		}
		
		//결제할 가격
		int price = (int)(double)data.get("price");
		log.debug("결제할 가격 : "+ price );

		//String merchantKey 	 	상점키
		//String merchantID 		상점아이디
		
		String ediDate 			= npay.getyyyyMMddHHmmss();
		log.debug("전문생성일시 : "+ediDate);

		String hashString 		= sha256Enc.encrypt(ediDate + merchantID + price + merchantKey);
		log.debug("hashString : "+hashString );

		Map<String,Object> payInfo = new HashMap();
		payInfo.put("result", result);
		payInfo.put("merchantKey",merchantKey);
		payInfo.put("merchantId", merchantID);
		payInfo.put("ediDate", ediDate);
		payInfo.put("hashString", hashString);
		
		//상점키, 상점아이디, 전문생성일시, 해쉬값
		return new Gson().toJson(payInfo); 	
	}


	
	//결제 처리 컨트롤러 -> 결제 창 컨트롤러 호출
 	@PostMapping(value="payResult.pm")
	public ModelAndView PaymentResult(ModelAndView mv,
								@RequestParam Map<String, String> request,
								@RequestParam(value="couponNos", required=false)ArrayList<Integer> couponNos,
								@RequestParam("bookingSeatNos")ArrayList<String> bookingSeatNos,
								HttpSession session
								) throws Exception {
 		
 		log.debug("=========================");
		log.debug("==결제후 결제 처리 메소드 실행==");
		log.debug("=========================");
		
				
		int userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
		int playingNo = Integer.parseInt(request.get("playingNo"));
		
		log.debug("넘어온 값들 : ArrayList<String>bookingSeatNos = "+bookingSeatNos+", playingNo : "+ playingNo);

		boolean seatTest = false;
		int couponTest = 0;	//쿠폰 없는경우 0, 있는경우 1, 실패 2

		
		//1. 좌석 유효성 검사
		//		넘어온 좌석번호로 유효성 검사			
		ArrayList<BookingSeat> bookingSeatList= bookService.checkAndGetBookingSeatNoList(null,playingNo,bookingSeatNos);
		
		
		log.debug("유효성 검사 통과한 좌석 정보 : "+bookingSeatList);
		if(bookingSeatList.size() ==bookingSeatNos.size()) { 
			seatTest = true;
			log.debug("좌석 유효성 검사 통과 "+seatTest);
		}else {
			seatTest = false;
			log.debug("좌석 유효성 검사 실패 "+seatTest);	
		}
		
		log.debug(" 좌석유효성 검사 결과 : "+seatTest + "상영좌석일렬번호 리스트"+ bookingSeatList);
		
		
		//2. 쿠폰 유효성 검사
		//		
		if(couponNos!=null) { //쿠폰 있는 경우		
			int couponResult = bookService.selectCheckCoupon(couponNos,userNo);						
			if(couponResult == couponNos.size()) {// 유효성테스트 통과
				couponTest = 1;
			}else { //유효성 테스트 실패
				couponTest = 2;
			}
		}
		log.debug(" 쿠폰 유효성 테스트 0(쿠폰x) 1(통과) 2(실패) 결과 : "+couponTest);
		
		
		//3. 결제 테스트 
		boolean payTest = npay.payment(request,seatTest,couponTest);
		log.debug(" 결제 결과 payTest" + payTest);
		
		
		//4. 데이터 업데이트 (좌석, 쿠폰, 예매)
		
		if(payTest) { //결제성공
			
			//예매(결제정보,
			Booking bookingData = new Booking();
			//bookingData.setBookNo(bookNo);
			bookingData.setUserNo(userNo);
			bookingData.setBookTotalCost(Integer.parseInt(request.get("totalCost")));
			bookingData.setBookCost(Integer.parseInt(request.get("Amt")));
			bookingData.setCostProcess(request.get("PayMethod"));
			if(request.get("TxTid")!=null) {
				bookingData.setCostTid(request.get("TxTid"));
			}else{
				bookingData.setCostTid(null);
			}
			
			log.debug("인서트할 북킹 정보 : " +bookingData.toString());
			
			//예매 처리된 북킹 정보 
			int insertResult = bookService.insertSelectBooking(bookingData);
			log.debug("예매 처리 인서트 행의 갯수 : " + insertResult + " (0실패/1성공)");
			
			int bookNo = bookingData.getBookNo();
			log.debug("북넘버 : "+bookNo);
			
			
			//좌석 예약 처리
			int bookingSeatResult = bookService.updateBookingSeatDone(bookingSeatList,bookNo);
			log.debug("예매된 좌석 처리 수 : "+bookingSeatList);
			
			//쿠폰 (사용유무,예매번호)
			if(couponTest==1) {	
				int couponResult = bookService.updateCouponUserDone(couponNos,bookNo,userNo);
				log.debug("사용 처리된 쿠폰 수 : "+couponResult);
			}
			
			
			
			//보낼 정보 //조회하기
			
			//예매정보 조회
			//Booking booking = bookService.selectBooking(bookNo);
			//log.debug("예매처리된 북킹 정보 booking: "+booking);
			 
			//*상영번호 -> 영화정보,이미지,상영정보, 상영관정보 조회
			//Movie movie = bookService.selectMovieForPlayingNo(playingNo);
			//log.debug("보낼 정보 영화정보(+포스터),상영정보,상영관 정보 movie : " + movie.toString());
			
			//*상영좌석, 상영관정보 조회 (상영좌석번호로)
			log.debug("좌석정보, 상영관정보 : bookingSeatList : " + bookingSeatList.toString() );
			
			//쿠폰정보 (북넘버)
			//ArrayList<CouponUser> couponUserList = bookService.selectListCouponUserList(bookNo);
			//log.debug("보낼정보 사용한 쿠폰 정보들(예매번호) couponUserList: "+couponUserList.toString() );
						
			Map<String,Object> resultData = new HashMap();
			resultData.put("bookNo", bookNo);
			resultData.put("bookingSeatNos", bookingSeatNos);
			resultData.put("playingNo", playingNo);
			
			
			session.setAttribute("resultData", resultData);
									
			mv.setViewName("redirect:/payResult2.pm");
			
		}else {
			
			
			//좌석 삭제
			int bookingSeatDeleteResult = bookService.deleteBookingSeats(bookingSeatNos);
			log.debug("좌석삭제 처리된 행의 갯수 : "+ bookingSeatDeleteResult);
			//쿠폰그대로
			session.setAttribute("alertMsg","죄송합니다. 다시 시도해 주시기 바랍니다. ");
			mv.setViewName("redirect:/book.do");
		}
		
		
		return mv;
	}
 	
 	@GetMapping(value="payResult2.pm")
 	public ModelAndView payResult2 (HttpSession session,
 									ModelAndView mv){
 			
 		log.debug("PRG 방식 GET 방식 핸들러 메소드 호출 " );
 		
 		//넘겨받은 값들
 		Map<String,Object> resultData = (Map)session.getAttribute("resultData");
 		
 		int bookNo = (int)resultData.get("bookNo");
 		ArrayList<String> bookingSeatNos = (ArrayList)resultData.get("bookingSeatNos");
 		int playingNo = (int)resultData.get("playingNo");
 		
 		log.debug("넘어온 값들  bookNo : " + bookNo + "bookingSeatNos : "+ bookingSeatNos + "playingNo : " + playingNo);
 		
 		//넘길 데이터 조회
 		Booking booking = bookService.selectBooking(bookNo);
 		Movie movie = bookService.selectMovieForPlayingNo(playingNo);
 		ArrayList<BookingSeat> bookingSeatList= bookService.selectBookingSeatList(bookingSeatNos);
 		ArrayList<CouponUser> couponUserList = bookService.selectListCouponUserList(bookNo);
 		
 		
 		//model로 보내기
 		mv.addObject("booking",booking);
		mv.addObject("movie",movie);
		mv.addObject("bookingSeatList",bookingSeatList); //상영좌석 정보 리스트
		mv.addObject("couponUserList",couponUserList);
		//session테스트 

 		
 		mv.setViewName("book/paymentResult");
		return mv;
 		
 		
 	}
 		



	//결제최소 요청 메소드
 	//
 	@PostMapping(value="cancelRequest.pm")
 	@ResponseBody
 	public String paymentCancelRequest(int bookNo,
 									   HttpSession session,
 									   @RequestParam(value="userNo",required=false,defaultValue="0")int userNo) throws Exception {
 		String result= "false";
 		//boolean cancelPayment(Booking booking)
 		log.debug("====================================");
 		log.debug("====결제취소요청 : bookNo : "+bookNo);
 		log.debug("====================================");
 		
 		
 		if(userNo==0) {
 			userNo = ((Member)session.getAttribute("loginUser")).getUserNo();
 		}
 		
 		Booking booking = bookService.selectBooking(bookNo);
 		
 		//취소 가능한지 유효성 검사(지금시간, 상영시간 비교
 		
 		//0 실패, 1이상 성공
 		int bookingCheckResult =bookService.checkCancelBooking(bookNo,userNo);
 		log.debug("결제취소 유효성 검사 : "+bookingCheckResult+" (0실패/1성공");
 		
 		
 		// 유효성 검사 통과 && 결제금액 있는 경우 
 		boolean cancelPaymentResult = false;
 		
 		if(bookingCheckResult>0) { //검사통과	
 			
 			int bookCost = booking.getBookCost();
 			
 			if(bookCost>0) {//결제금액 있는경우
 				cancelPaymentResult = npay.cancelPayment(booking);
 			}else {//결제 금액 없는경우
 				cancelPaymentResult = true;	
 			}
 			
 			log.debug("결제 금액있는경우/없는경우 결제 취소 처리 : "+cancelPaymentResult+" (true통과/false실패)");
 		}
 		
 		//db 결제 취소 처리
 		if(bookingCheckResult>0 && cancelPaymentResult) { //둘다 성공인 경우 		
 			
 			//취소처리 (BOOKING, BOOKING_SEAT, COUPON_USER)
 			int cancelResult = bookService.cancelUpdateBooking(bookNo,userNo);
 			 			
 			log.debug("DB 결제 취소 성공-처리 : "+cancelResult + " (0실패/1이상 성공");
 			result = "success";
 		}
 		//아닌경우는 false

		return result;
 	}
 	
 	
	
 	
 	
	
		

	
	
	
	//예매 관리 관리자 계정
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	@GetMapping("adminBooking.ad")
	public ModelAndView amdminBookingList(ModelAndView mv,
										  @RequestParam(value="sorting", required=false,defaultValue="desc") String sorting,
										  @RequestParam(value="bookNo", required=false,defaultValue="")String bookNo,
										  @RequestParam(value="userId", required=false,defaultValue="")String userId,
										  @RequestParam(value="currentPage", required=false, defaultValue="1")Integer currentPage
										  ) {
		
		
		
		log.debug("==관리자(예매내역관리) 핸들러 메소드 실행 ");
		log.debug("넘어온 값들");
		log.debug("-String sorting:" +sorting);
		log.debug("-Integer bookNo :" +bookNo);
		log.debug("-String userId:" +userId);
		log.debug("-currentPage : "+ currentPage);
		
		//페이징 처리
		int listCount = bookService.selectBookingCount(bookNo,userId);
		log.debug("listCount : " + listCount);
		int boardLimit = 10;
		int pageLimit = 5;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		//데이터 조회
		ArrayList<Booking> bookingList = bookService.selectBookingListAdmin(pi,sorting,bookNo,userId);
		
		
		log.debug("조횐된 bookingList : " + bookingList.toString());
		log.debug("pi : " + pi);

		 
		
		//검색결과에 따른 페이징 처리 유지
		String url = "?sorting="+sorting;
		if(!bookNo.equals("")) {url+= "&bookNo="+bookNo;}
		if(!userId.equals("")) {url+= "&userId="+userId;}
		url += "&currentPage=";
		
		
		mv.addObject("bookingList",bookingList);
		mv.addObject("pi",pi);
		mv.addObject("url",url);
		mv.addObject("sorting",sorting);
		mv.addObject("bookNo",bookNo);
		mv.addObject("userId",userId);
		
		
		mv.setViewName("admin/book/adminBook");
		
		return mv;
	}
	
	
	
	
}
