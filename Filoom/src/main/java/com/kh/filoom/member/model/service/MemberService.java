package com.kh.filoom.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.member.model.vo.Coupon;
import com.kh.filoom.member.model.vo.Favorite;
import com.kh.filoom.member.model.vo.History;
import com.kh.filoom.member.model.vo.Member;
import com.kh.filoom.member.model.vo.Reserve;
import com.kh.filoom.member.model.vo.Review;

public interface MemberService {
	
	// 로그인 서비스 (select)
	Member loginMember(Member m);
	
	// 회원가입 서비스 (insert)
	int insertMember(Member m);

	// 아이디 중복체크 서비스 (select)
	boolean idCheck(String userId);

	// 비밀번호 변경 서비스 (update)
	int changePwd(Member loginUser);

	// 이름 변경 서비스 (update)
	int changeName(Member loginUser);

	// 성별 변경 서비스 (update)
	int changeGender(Member loginUser);

	// 생년월일 변경 서비스 (update)
	int changeBirth(Member loginUser);

	// 마케팅 동의 여부 변경 서비스 (update)
	int changeMarketing(Member loginUser);

	// 회원탈퇴용 서비스 (update)
	int withdrawMember(String userId);

	// 예매 내역 조회용 서비스 (select)
	List<Reserve> reserveList(int userNo);

	// 취소된 예매 내역 조회용 서비스 (select)
	List<Reserve> cancelList(int userNo);

	// 쿠폰으로 예매 했는데 그게 무슨 쿠폰이냐? 조회용 서비스 (select)
	List<Reserve> useCouponList(int userNo);

	// 내가 본 영화 목록 조회용 서비스 (select)
	List<History> historyList(int userNo);
	
	// 연도별 영화 목록 조회용 서비스
	List<History> historyListByYear(int userNo, String year);

	// 아이디 찾기 서비스 (select)
	String findUserId(Map<String, Object> paramMap);

	// 비밀번호 찾기(변경) 서비스 (update)
	String findUserPwd(Map<String, Object> paramMap);

	// 비밀번호 찾기-> 비밀번호 변경 서비스 (update)
	int updateUserPwd(Map<String, String> paramMap);

	// 보고싶은 영화 목록 조회 서비스 (select)
	List<Favorite> favoriteList(int userNo, String sort);

	// 보고싶은 영화 목록 삭제 서비스 (delete)
	int deleteFavorite(Map<String, Object> paramMap);

	// 내가 본 영화 목록 삭제 서비스 (delete)
	int deleteHistorySeat(Map<String, Object> paramMap);
	int deleteHistory(Map<String, Object> paramMap);

	boolean checkEmail(String email);

	List<Coupon> couponList(int userNo);
	
	List<Review> reviewList(int userNo);
	
	
	
	
	// 관리자
	int selectListCount();

	ArrayList<Member> memberList(PageInfo pi);
	
	int selectSearchListCount(String keyword);
	
	ArrayList<Member> searchMemberList(PageInfo pi, String keyword);
	
	int selectStatusListCount(String status);
	
	ArrayList<Member> selectStatusMemberList(PageInfo pi, String status);

	int updateMemberStatus(int userNo, String status);

	

	

	



	
	
	
}
