package com.kh.filoom.member.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.common.template.Pagination;
import com.kh.filoom.member.model.service.MemberService;
import com.kh.filoom.member.model.vo.Coupon;
import com.kh.filoom.member.model.vo.Favorite;
import com.kh.filoom.member.model.vo.History;
import com.kh.filoom.member.model.vo.Member;
import com.kh.filoom.member.model.vo.Reserve;
import com.kh.filoom.member.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender mailSender; // 다형성 적용
	
	private Map<String, String> certNoList = Collections.synchronizedMap(new HashMap<>());
	
	/**
	 * 2024.12.10 김다훈
	 * 로그인 페이지 불러오기 컨트롤러 메소드
	 * @param mv
	 * @return
	 */
	@GetMapping("loginForm.me")
	public ModelAndView loginForm(ModelAndView mv) {
		
		mv.setViewName("member/loginForm");
		
		return mv;
	}
	
	/**
	 * 2024.12.10 김다훈
	 * 로그인 컨트롤러 메소드
	 * @param m
	 * @param mv
	 * @param session
	 * @param saveId
	 * @param response
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="login.me", produces = "text/plain; charset=UTF-8")
	public String loginMember(Member m,
								    HttpSession session,
								    String saveId,
								    HttpServletResponse response) {
		
		if(saveId != null && saveId.equals("y")) {

			// > 아이디값을 저장하는 Cookie 생성
			Cookie cookie = new Cookie("saveId", m.getUserId());
			
			cookie.setMaxAge(24 * 60 * 60 * 1); 
			// > 만료시간 1일
			
			response.addCookie(cookie);
			
		} else {
			
			// 키값이 중복되면 덮어씌워진다는 점을 이용해서 동일한 키값의 쿠키를 생성
			Cookie cookie = new Cookie("saveId", m.getUserId());
			
			// 만료시간 0초 (즉시제거)
			cookie.setMaxAge(0);
			
			response.addCookie(cookie);
		}
		
		// 암호화 작업
		Member loginUser = memberService.loginMember(m);
		
		if((loginUser != null) && 
			(bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd()))) { 
			// 로그인 성공일 경우
			
			session.setAttribute("loginUser", loginUser);
			
			return "로그인 성공";
			
		} else { // 로그인 실패일 경우
			
			return "아이디 또는 비밀번호를 잘못 입력했습니다.";
		}
	}
	
	/**
	 * 2024.12.10 김다훈
	 * 로그아웃 컨트롤러 메소드
	 * @param session
	 * @return
	 */
	@GetMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		
//		session.setAttribute("alertMsg", "로그아웃 성공");
		
		return "redirect:/";
	}

	/**
	 * 2024.12.10 김다훈
	 * 회원가입 페이지 불러오기 컨트롤러 메소드
	 * @param mv
	 * @return
	 */
	@GetMapping("enrollForm.me")
	public ModelAndView enrollForm(ModelAndView mv) {
		
		mv.setViewName("member/enrollForm");
		
		return mv;
	}
	
	/**
	 * 2024.12.10 김다훈
	 * 회원가입 요청 컨트롤러 메소드
	 * @param m
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping("insert.me")
	public String insertMember(Member m, 
							   Model model,
							   HttpSession session) {
		
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		System.out.println("암호문 : " + encPwd);
		
		m.setUserPwd(encPwd);
		
		// GENDER 값이 빈 문자열이면 null로 설정
	    if (m.getGender() == null || m.getGender().isEmpty()) {
	        m.setGender(null);
	    }
		
		System.out.println(m); // 확인용
		
		int result = memberService.insertMember(m);
		
		if(result > 0) { // 성공
			
			session.setAttribute("alertMsg", "회원가입 성공");
			
			return "redirect:/loginForm.me";
			
		} else { // 실패
			
			model.addAttribute("errorMsg", "회원가입 실패");
			
			return "common/errorPage";
		}
		
	}
	
	/**
	 * 2024.12.11 김다훈
	 * 아이디 중복 체크 요청
	 * @param checkId
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "idCheck.me", produces = "application/json; charset=UTF-8")
	public Map<String, String> idCheck(@RequestBody Map<String, String> request) {
		
		String userId = request.get("userId").toLowerCase(); // 입력값 소문자로 변환
	    
	    Map<String, String> response = new HashMap<>();
		
		// 비속어 필터링
        List<String> restrictedWords = Arrays.asList("admin", "fuck");
        
        if (restrictedWords.stream().anyMatch(userId::contains)) {
        	
            response.put("result", "invalid");
            
            return response;
        }
		
        // 아이디 중복 확인 로직 (예시)
        boolean isDuplicate = memberService.idCheck(userId); // DB에서 중복 확인
        
        if (isDuplicate) {
        	
            response.put("result", "duplicate");
            
        } else {
        	
            response.put("result", "available");
        }
        
        return response;
	}
	
	/**
	 * 2024.12.24 김다훈
	 * 이메일 중복체크
	 * @param email
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "checkEmailAndCert.do", produces = "application/json; charset=UTF-8")
	public Map<String, String> checkEmailAndCert(@RequestParam("email") String email) {
	    Map<String, String> response = new HashMap<>();

	    // 이메일 중복 체크
	    boolean isDuplicate = memberService.checkEmail(email);

	    if (isDuplicate) {
	        response.put("status", "duplicate");
	        response.put("message", "중복된 이메일로 가입이 불가능합니다.");
	    } else {
	        // 중복되지 않은 경우 기존 cert.do 호출
	        String result = sendCertNo(email); // 기존 cert.do 메소드 호출
	        if ("인증번호 발급 완료".equals(result)) {
	            response.put("status", "success");
	            response.put("message", "인증번호가 이메일로 전송되었습니다.");
	        } else {
	            response.put("status", "error");
	            response.put("message", "인증번호 전송에 실패했습니다.");
	        }
	    }

	    return response;
	}

	
	/**
	 * 2024.12.12 김다훈
	 * 인증번호 생성 후 이메일 전송 요청 메소드
	 * @param email
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "cert.do", produces = "text/html; charset=UTF-8")
	public String sendCertNo(String email) {
	    // 인증번호 생성
	    int random = (int) (Math.random() * 900000 + 100000);
	    certNoList.put(email, String.valueOf(random)); // 인증번호 저장

	    try {
	        // 이메일 생성
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, "utf-8");

	        // HTML 내용 생성
	        String htmlContent = 
        	    "<!DOCTYPE html>" +
        	    "<html lang=\"en\">" +
        	    "<head>" +
        	        "<meta charset=\"UTF-8\">" +
        	        "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" +
        	        "<title>인증번호 이메일</title>" +
        	    "</head>" +
        	    "<body style=\"font-family: Arial, sans-serif; background-color: #f4f4f9; margin: 0; padding: 0;\">" +
        	        "<div style=\"max-width: 600px; margin: 20px auto; background-color: #ffffff; border-radius: 10px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); overflow: hidden;\">" +
        	            "<div style=\"background-color: #493628; color: #ffffff; text-align: center; padding: 20px; font-size: 24px; font-weight: bold;\">" +
        	                "Filoom 인증번호 안내" +
        	            "</div>" +
        	            "<div style=\"padding: 30px; color: #333333; line-height: 1.6;\">" +
        	                "<p>안녕하세요,</p>" +
        	                "<p>Filoom을 이용해 주셔서 감사합니다. 아래 인증번호를 입력하여 이메일 인증을 완료해 주세요:</p><br>" +
        	                "<div style=\"font-size: 24px; font-weight: bold; color: #493628; text-align: center; padding: 10px 10px 10px 25px; border: 2px solid #493628; border-radius: 5px; margin: 20px auto; width: fit-content; letter-spacing: 15px; white-space: nowrap;\">" +
        	                    random +
        	                "</div>" +
        	                "<p align=\"right\"><strong>중요: </strong>인증번호는 5분후에 만료됩니다.</p><br><br>" +
        	                "<p><strong>\"영화처럼 특별한 하루를 Filoom에서 만나보세요!\"</strong></p>" +
        	                "<p>Filoom by backlight</p>" +
        	            "</div>" +
        	            "<div style=\"text-align: center; background-color: #f4f4f9; color: #888888; padding: 20px; font-size: 14px;\">" +
        	                "&copy; 2024 Filoom. All rights reserved." +
        	            "</div>" +
        	        "</div>" +
        	    "</body>" +
        	    "</html>";

	        // 이메일 설정
	        helper.setFrom("backlightfiloom@gmail.com");
	        helper.setTo(email);
	        helper.setSubject("[Filoom] 이메일 인증 번호입니다.");
	        helper.setText(htmlContent, true); // true는 HTML 형식임을 명시

	        // 이메일 전송
	        mailSender.send(message);

	        return "인증번호 발급 완료";

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "인증번호 발급 중 오류가 발생했습니다.";
	    }
	}

	/**
	 * 2024.12.12 김다훈
	 * 인증번호 대조 요청 메소드
	 * @param email
	 * @param checkNo
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="validate.do",
				 produces="text/html; charset=UTF-8")
	public String validate(String email, String checkNo) {
		
		String result = "";
		
		if(certNoList.get(email) != null && 
				certNoList.get(email).equals(checkNo)) {
			
			result = "인증 성공";
			
		} else {
			
			result = "인증 실패";
		}
		
		certNoList.remove(email);
		
		return result;
	}
	
//	/**
//	 * 2024.12.15 김다훈
//	 * 마이페이지 접속 요청
//	 * @return
//	 */
//	@GetMapping("myPage.me")
//	public String myPage() {
//		
//		return "member/myPage";
//	}

	/**
	 * 2024.12.13 김다훈
	 * 마이페이지(내 정보 조회) 접속 요청
	 * @return
	 */
	@GetMapping("profile.me")
	public String profile() {
		
		return "member/profile";
	}
	
//	/**
//	 * 2024.12.13 김다훈
//	 * 마이페이지(내 쿠폰 조회) 접속 요청
//	 * @return
//	 */
//	@GetMapping("coupon.me")
//	public String coupon() {
//		
//		return "member/coupon";
//	}
	
//	/**
//	 * 2024.12.13 김다훈
//	 * 마이페이지(예매 내역 조회) 접속 요청
//	 * @return
//	 */
//	@GetMapping("reserve.me")
//	public String reserve() {
//		
//		return "member/reserve";
//	}
	
//	/**
//	 * 2024.12.13 김다훈
//	 * 마이페이지(내가 본 영화 조회) 접속 요청
//	 * @return
//	 */
//	@GetMapping("history.me")
//	public String history() {
//		
//		return "member/history";
//	}
	
//	/**
//	 * 2024.12.13 김다훈
//	 * 마이페이지(보고싶은 영화 조회) 접속 요청
//	 * @return
//	 */
//	@GetMapping("favorite.me")
//	public String favorite() {
//		
//		return "member/favorite";
//	}
	
//	/**
//	 * 2024.12.13 김다훈
//	 * 마이페이지(내가 쓴 리뷰 조회) 접속 요청
//	 * @return
//	 */
//	@GetMapping("review.me")
//	public String review() {
//		
//		return "member/review";
//	}
	
	/**
	 * 2024.12.13 김다훈
	 * 마이페이지(회원탈퇴) 접속 요청
	 * @return
	 */
	@GetMapping("withdrawal.me")
	public String withdrawal() {
		
		return "member/withdrawal";
	}
	
	/**
	 * 2024.12.14 김다훈
	 * 12.17 비밀변호 변경 성공 시 로그아웃 후 로그인폼으로 이동 로직 추가
	 * 비밀번호 변경 요청
	 * @param currentPwd
	 * @param newPwd
	 * @param session
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "changePwd.me", produces="text/plain; charset=UTF-8")
	public String changePwd(@RequestParam("currentPwd") String currentPwd,
	                        @RequestParam("newPwd") String newPwd,
	                        HttpSession session, Model model) {
		
	    // 현재 로그인된 사용자 정보 가져오기
		Member loginUser = (Member) session.getAttribute("loginUser");

	    // 기존 비밀번호 확인
	    if (!bcryptPasswordEncoder.matches(currentPwd, loginUser.getUserPwd())) {
	    	
	        return "현재 비밀번호가 일치하지 않습니다.";
	    }

	    // 새 비밀번호 암호화
	    String encNewPwd = bcryptPasswordEncoder.encode(newPwd);
	    
	    loginUser.setUserPwd(encNewPwd);

	    // 서비스 호출하여 DB 업데이트
	    int result = memberService.changePwd(loginUser);

	    if (result > 0) {
	    	
	    	session.removeAttribute("loginUser");
	    	
	        return "비밀번호가 성공적으로 변경되었습니다. 로그인 페이지로 이동합니다.";
	        
	    } else {
	    	
			return "비밀번호 변경에 실패하였습니다.";
	    }
	}

	/**
	 * 2024.12.14 김다훈
	 * 아이디 찾기 페이지 접속 요청
	 * @return
	 */
	@GetMapping("findIdForm.me")
	public String findIdForm() {
		
		return "member/findIdForm";
	}
	
	/**
	 * 2024.12.14 김다훈
	 * 비밀번호 찾기 페이지 접속 요청
	 * @return
	 */
	@GetMapping("findPwdForm.me")
	public String findPwdForm() {
		
		return "member/findPwdForm";
	}

	/**
	 * 2024.12.15 김다훈
	 * 이름 변경 요청
	 * @param newName
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "changeName.me", produces = "text/plain; charset=UTF-8")
	public String changeName(@RequestParam("newName") String newName, HttpSession session) {
		
	    // 현재 로그인된 사용자 정보 가져오기
	    Member loginUser = (Member) session.getAttribute("loginUser");

	    // 사용자 이름 업데이트
	    loginUser.setUserName(newName);
	    
	    int result = memberService.changeName(loginUser);

	    if (result > 0) {
	        // 세션 정보 업데이트
	        session.setAttribute("loginUser", loginUser);
	        
	        return "이름이 성공적으로 변경되었습니다.";
	        
	    } else {
	    	
	        return "이름 변경에 실패하였습니다. 다시 시도해주세요.";
	    }
	}
	
	/**
	 * 2024.12.15 김다훈
	 * 성별 변경 요청
	 * @param gender
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "changeGender.me", produces = "text/plain; charset=UTF-8")
	public String changeGender(@RequestParam("gender") String gender, HttpSession session) {
	    
	    // 현재 로그인된 사용자 정보 가져오기
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    // "선택 안함"일 경우 gender 값을 null로 설정
	    if (gender.isEmpty()) {
	        loginUser.setGender(null); // DB에 null 삽입
	    } else {
	        loginUser.setGender(gender); // 'M' 또는 'F'
	    }
	    
	    // 업데이트 서비스 호출
	    int result = memberService.changeGender(loginUser);

	    if (result > 0) {
	        // 세션 정보 업데이트
	        session.setAttribute("loginUser", loginUser);
	        return "성별이 성공적으로 변경되었습니다.";
	    } else {
	        return "성별 변경에 실패하였습니다. 다시 시도해주세요.";
	    }
	}
	
	/**
	 * 2024.12.15 김다훈
	 * 생년월일 변경 요청
	 * @param birthDate
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "changeBirth.me", produces = "text/plain; charset=UTF-8")
	public String changeBirth(@RequestParam("birthDate") String birthDate, HttpSession session) {
	    // 현재 로그인된 사용자 정보 가져오기
	    Member loginUser = (Member) session.getAttribute("loginUser");

	    // 생년월일 업데이트
	    loginUser.setBirth(birthDate);

	    int result = memberService.changeBirth(loginUser);

	    if (result > 0) {
	        // 세션 정보 업데이트
	        session.setAttribute("loginUser", loginUser);
	        return "생년월일이 성공적으로 변경되었습니다.";
	    } else {
	        return "생년월일 변경에 실패하였습니다. 다시 시도해주세요.";
	    }
	}
	
	/**
	 * 2024.12.15 김다훈
	 * 마케팅 활용 동의 변경 요청
	 * @param marketing
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "changeMarketing.me", produces = "text/plain; charset=UTF-8")
	public String changeMarketing(@RequestParam("marketing") String marketing, HttpSession session) {
	    // 현재 로그인된 사용자 정보 가져오기
	    Member loginUser = (Member) session.getAttribute("loginUser");

	    // 사용자 마케팅 정보 업데이트
	    loginUser.setMarketing(marketing);
	    
	    int result = memberService.changeMarketing(loginUser);

	    if (result > 0) {
	        // 세션 정보 업데이트
	        session.setAttribute("loginUser", loginUser);
	        return "성공적으로 업데이트되었습니다.";
	    } else {
	        return "업데이트 실패. 다시 시도해주세요.";
	    }
	}

	/**
	 * 2024.12.17 김다훈
	 * 회원탈퇴 비밀번호 확인용 컨트롤러
	 * @param currentPwd
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "checkPwd.me", produces = "text/plain; charset=UTF-8")
	public String checkPwd(@RequestParam("currentPwd") String currentPwd, HttpSession session) {
		
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    if (bcryptPasswordEncoder.matches(currentPwd, loginUser.getUserPwd())) {
	    	
	        return "비밀번호 일치";
	    }
	    
	    return "비밀번호 불일치";
	}
	
	/**
	 * 2024.12.17 김다훈
	 * 회원 탈퇴 처리 컨트롤러
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "withdraw.me", produces = "text/plain; charset=UTF-8")
	public String withdrawMember(HttpSession session) {
		
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    int result = memberService.withdrawMember(loginUser.getUserId());
	    
	    if (result > 0) {
	    	
	        session.invalidate();
	        
	        return "탈퇴 성공";
	    }
	    
	    return "탈퇴 실패";
	}

	/**
	 * 2024.12.17~19 김다훈
	 * 예매 내역, 예매 취소 내역 조회 컨트롤러
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("reserve.me")
    public String reserveList(HttpSession session, Model model) {
		
        // 로그인된 사용자 세션에서 가져오기
        Member loginUser = (Member) session.getAttribute("loginUser");
        
        // 예매 내역 조회
        List<Reserve> reserveList = memberService.reserveList(loginUser.getUserNo());
        // 예매 시 사용한 쿠폰 목록 조회
        List<Reserve> useCouponList = memberService.useCouponList(loginUser.getUserNo());
        // 예매 취소 내역 조회
        List<Reserve> cancelList = memberService.cancelList(loginUser.getUserNo());
        
//        System.out.println("reserveList = " + reserveList);
//        System.out.println("useCouponList = " + useCouponList);
//        System.out.println("cancelList = " + cancelList);

        // 모델에 예매 내역 데이터 담기
        model.addAttribute("reserveList", reserveList);
        model.addAttribute("useCouponList", useCouponList);
        model.addAttribute("cancelList", cancelList);
        
        return "member/reserve"; // 예매 내역 화면으로 이동
    }
	
	/**
	 * 2024.12.20 김다훈
	 * 내가 본 영화 조회 요청 컨트롤러
	 * @param session
	 * @param model
	 * @return
	 */
	@GetMapping("history.me")
	public String historyList(
	        @RequestParam(value = "year", required = false, defaultValue = "all") String year,
	        HttpSession session, 
	        Model model) {
	    
	    // 로그인된 사용자 정보 가져오기
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    int userNo = loginUser.getUserNo();
	    
	    // 연도별 영화 기록 조회
	    List<History> historyList = year.equals("all") 
	        ? memberService.historyList(userNo) 
	        : memberService.historyListByYear(userNo, year);
	    
	    model.addAttribute("historyList", historyList);
	    model.addAttribute("selectedYear", year);
	    
	    return "member/history";
	}

	/**
	 * 2024.12.22 김다훈
	 * 아이디 찾기 요청 컨트롤러
	 * @param userName
	 * @param birth
	 * @param email
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "findId.me", produces = "text/html; charset=UTF-8")
	public String findId(@RequestParam("userName") String userName,
	                     @RequestParam("birth") String birth,
	                     @RequestParam("email") String email) {

		// Map에 파라미터를 묶기
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("userName", userName);
	    paramMap.put("birth", birth);
	    paramMap.put("email", email);
		
	    // DB에서 아이디 조회
	    String userId = memberService.findUserId(paramMap);

	    if (userId != null) {
	        // 조회 결과가 있으면 아이디 반환
	        return userId;
	    } else {
	        // 조회 결과가 없으면 에러 메시지 반환
	        return "NOT_FOUND";
	    }
	}
	
	/**
	 * 2024.12.22 김다훈
	 * 아이디 찾기 결과 페이지 요청 컨트롤러
	 * @return
	 */
	@PostMapping("findIdResult.me")
	public String findIdResult(@RequestParam("userId") String userId, @RequestParam("userName") String userName, Model model) {
		
	    model.addAttribute("userId", userId); // userId를 모델에 추가
	    model.addAttribute("userName", userName); // userName을 모델에 추가
	    
	    return "member/findIdResult";
	}
	
	/**
	 * 2024.12.23 김다훈
	 * 비밀번호 찾기 컨트롤러
	 * @param userName
	 * @param userId
	 * @param birth
	 * @param email
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "findPwd.me", produces = "text/html; charset=UTF-8")
	public String findPwd(@RequestParam("userName") String userName,
	                      @RequestParam("userId") String userId,
	                      @RequestParam("birth") String birth,
	                      @RequestParam("email") String email) {

	    // DB에서 사용자 정보 확인
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("userName", userName);
	    paramMap.put("userId", userId);
	    paramMap.put("birth", birth);
	    paramMap.put("email", email);

	    String encodedPassword = memberService.findUserPwd(paramMap);

	    if (encodedPassword != null) {
	        // 비밀번호를 암호화된 상태로 반환
	        return encodedPassword;
	    } else {
	        // 사용자 정보가 틀림
	        return "NOT_FOUND";
	    }
	}

	/**
	 * 2024.12.23 김다훈
	 * 비밀번호 변경 페이지 이동 컨트롤러
	 * @param userId
	 * @param model
	 * @return
	 */
	@PostMapping("updatePwdForm.me")
	public String changePwdForm(@RequestParam("userId") String userId, Model model) {
		
	    model.addAttribute("userId", userId); // JSP에 userId 전달
	    
	    return "member/updatePwdForm"; // JSP 경로
	}
	
	/** 2024.12.23 김다훈
	 * 비밀번호 변경 요청 컨트롤러
	 * @param userId
	 * @param newPwd
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "updatePwd.me", produces = "text/plain; charset=UTF-8")
	public String updatePwd(@RequestParam("userId") String userId,
	                        @RequestParam("newPwd") String newPwd) {
	    
	    // 비밀번호 암호화
	    String encryptedPwd = bcryptPasswordEncoder.encode(newPwd);
	    
	    // Map 객체에 파라미터 묶기
	    Map<String, String> paramMap = new HashMap<>();
	    paramMap.put("userId", userId);
	    paramMap.put("encryptedPwd", encryptedPwd);

	    // 서비스 계층 호출
	    int result = memberService.updateUserPwd(paramMap);

	    // 결과 반환
	    if (result > 0) {
	        return "SUCCESS";
	    } else {
	        return "FAIL";
	    }
	}
	
	/**
     * 2024.12.23 김다훈
     * 12.26 정렬기능 추가
     * 좋아요(보고싶은 영화) 목록 조회 메소드
     * @param session
     * @param model
     * @return
     */
	@GetMapping("favorite.me")
	public String favoriteList(@RequestParam(value = "sort", defaultValue = "asc") String sort,
	        				   HttpSession session, 
	        				   Model model) {
	    
	    // 로그인된 사용자 정보를 가져오기
	    Member loginUser = (Member) session.getAttribute("loginUser");

	    // 좋아요 영화 목록 조회
	    List<Favorite> favoriteList = memberService.favoriteList(loginUser.getUserNo(), sort);

	    // 모델에 데이터 추가
	    model.addAttribute("favoriteList", favoriteList);
	    model.addAttribute("sort", sort); // 현재 정렬 옵션 유지

	    return "member/favorite"; // 좋아요 목록 JSP로 이동
	}
	
    /**
     * 2024.12.23 김다훈
     * 좋아요(보고싶은 영화) 목록 삭제 메소드
     * @param movieNo
     * @param session
     * @return
     */
    @ResponseBody
    @PostMapping(value = "deleteFavorite.me", produces = "text/plain; charset=UTF-8")
    public String deleteFavorite(@RequestParam("userNo") int userNo,
                                 @RequestParam("movieNo") int movieNo) {

        // 파라미터를 Map으로 묶기
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userNo", userNo);
        paramMap.put("movieNo", movieNo);

        // 서비스 호출
        int result = memberService.deleteFavorite(paramMap);

        if (result > 0) {
            return "보고싶은 영화에서 삭제되었습니다.";
        } else {
            return "삭제 실패";
        }
    }

    /**
     * 2024.12.24 김다훈
     * 내가 본 영화 기록 삭제 메소드
     * @param movieNo
     * @param session
     * @return
     */
    @ResponseBody
    @PostMapping(value = "deleteHistory.me", produces = "text/plain; charset=UTF-8")
    public String deleteHistory(@RequestParam("userNo") int userNo,
                                 @RequestParam("bookNo") int bookNo) {

        // 파라미터를 Map으로 묶기
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userNo", userNo);
        paramMap.put("bookNo", bookNo);

        // 서비스 호출
        int resultSeat = memberService.deleteHistorySeat(paramMap);
        int resultHistory = memberService.deleteHistory(paramMap);

        if (resultHistory > 0 && resultSeat > 0) {
            return "내가 본 영화 기록에서 삭제되었습니다.";
        } else {
            return "삭제 실패";
        }
    }
    
    @GetMapping("coupon.me")
    public String coupon(HttpSession session, Model model) {
        // 로그인된 사용자 정보 가져오기
        Member loginUser = (Member) session.getAttribute("loginUser");
        int userNo = loginUser.getUserNo();

        // 쿠폰 목록 조회
        List<Coupon> couponList = memberService.couponList(userNo);

        // 모델에 쿠폰 리스트 추가
        model.addAttribute("couponList", couponList);

        return "member/coupon"; // JSP 파일로 포워딩
    }
    
    @GetMapping("review.me")
    public String review(HttpSession session, Model model) {
        // 로그인된 사용자 정보 가져오기
        Member loginUser = (Member) session.getAttribute("loginUser");
        int userNo = loginUser.getUserNo();
        
        List<Review> reviewList = memberService.reviewList(userNo);
        
        model.addAttribute("reviewList", reviewList);

        return "member/review";
    }
    
    
    
    
    
    
    
    
    
    // 관리자
    
    @GetMapping("memberList_ad.me")
    public String memberList(
            @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

    	System.out.println("Received status: " + status);
        // 상태 및 검색어에 따라 회원 수 조회
        int listCount;
        if (status != null && !status.trim().isEmpty()) {
            listCount = memberService.selectStatusListCount(status);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            listCount = memberService.selectSearchListCount(keyword);
        } else {
            listCount = memberService.selectListCount();
        }

        int pageLimit = 5;
        int boardLimit = 8;
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

        // 상태 및 검색어에 따라 회원 목록 조회
        ArrayList<Member> memberList;
        if (status != null && !status.trim().isEmpty()) {
            memberList = memberService.selectStatusMemberList(pi, status);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            memberList = memberService.searchMemberList(pi, keyword);
        } else {
            memberList = memberService.memberList(pi);
        }

        model.addAttribute("memberList", memberList);
        model.addAttribute("pi", pi);
        model.addAttribute("status", status); // 현재 상태 필터 전달
        model.addAttribute("keyword", keyword); // 검색어 유지

        return "admin/member/memberListView";
    }

    @PostMapping("updateStatus.me")
    @ResponseBody
    public String updateStatus(@RequestParam("userNo") int userNo, @RequestParam("status") String status) {
        int result = memberService.updateMemberStatus(userNo, status);
        if (result > 0) {
            return "success";
        } else {
            return "fail";
        }
    }




}
























