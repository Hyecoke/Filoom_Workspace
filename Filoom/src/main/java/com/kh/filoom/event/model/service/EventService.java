package com.kh.filoom.event.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.coupon.model.vo.Coupon;
import com.kh.filoom.event.model.vo.Applicant;
import com.kh.filoom.event.model.vo.Event;
import com.kh.filoom.event.model.vo.EventAttachment;
import com.kh.filoom.event.model.vo.Reply;

public interface EventService {

	// 사용자 
	
	// 이벤트 종료여부 상태 변경
	void updateEventStatus();
	
	// 추천 이벤트 조회 (startDate 또는 endDate가 null 인 이벤트들) 
	List<Event> selectHotEventList();
	
	// 전체 이벤트 게시글 목록 조회 
	ArrayList<Event> selectList();
	
	// 이벤트 종료 여부에 따른 목록 조회 
	ArrayList<Event> selectFilterList(String eventStatus);
	
	// 이벤트 게시글 상세조회 서비스 
	Event selectEvent(int EventNo);
	
	// 이벤트 게시글 첨부파일 상세조회 서비스 
	ArrayList<EventAttachment> selectEventAttachment(int eventNo); 
	
	// 댓글 총갯수
	int seletReplyListCount(int eventNo);
	
	// 댓글 리스트 조회 서비스 (Ajax) 
	ArrayList<Reply> selectReplyList(int eventNo, PageInfo pi);
	
	// 댓글 중복체크
	boolean checkReplyWriter(int refEno, String replyWriter);
	
	// 댓글 작성 서비스 (Ajax)
	int insertReply(Reply r);
	
	// 댓글 수정 서비스 (Ajax) 
	int updateReply(Reply r);
	
	// 댓글 삭제 서비스 (Ajax) 
	int deleteReply(int replyNo);
	
	// 응모 버튼 
	// 응모자 중복 확인(Ajax)
	boolean checkUserParticipated(int refEno, String userNo);

	// 응모자 추가(Ajax) 
	void insertParticipant(Applicant a);

	
	
	// ----------------------------------------------------------------관리자
	// 게시글 작성하기 서비스
	int insertEvent(Event e);
	
	// 이미지 등록하기 서비스 
	int insertEventAttachment(EventAttachment eventAttachment);
	
	// 쿠폰 등록하기 서비스 
	int insertCoupon(Coupon coupon);
	
	// 게시글 수정하기 서비스 
	int updateEvent(Event e);

	// 게시글 첨부파일 수정하기 서비스
	int updateEventAttachment(List<Integer> fileNos, String status);
	
	// 게시글 삭제 서비스 
	int deleteEvent(int eventNO);
	
	// 게시글 총 갯수 조회 
	int selectListCount();

	// 관리자용 목록조회 서비스 
	ArrayList<Event> adminSelectList(PageInfo pi);

	// 관리자용 게시글 상세조회 서비스
	Event adminSelectEvent(int eventNo);
	
	// 관리자용 게시글 첨부파일 상세조회 서비스 
	ArrayList<EventAttachment> adminSelectEventAttachment(int eventNo);
 
	// 댓글 목록 수 
	int rlistCount(int eventNo);
	
	// 댓글 작성자 목록조회 서비스
	List<Reply> adminSelectReplyList(Map<String, Object> params);
	
	// 버튼 응모자 수
	int aplistCount(int eventNo);
	
	// 버튼 응모자 목록조회 서비스 
	List<Applicant> adminSelectApplicantList(Map<String, Object> params);
	
	

	// 쿠폰목록수
	int selectCouponListCount(int eventNo);

	// 쿠폰목록조회
	ArrayList<Coupon> selectCouponList(Map<String, Object>params);


	// 쿠폰 발급하는거
	int insertCouponUser(int userNo, int couponNo, int eventNo);

	// 쿠폰 발급 후 상태 변경
	int updateDrawingStatus(int userNo, int eventNo, String drawingStatus);








	
	
	
	
	
}
