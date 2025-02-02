package com.kh.filoom.event.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.coupon.model.vo.Coupon;
import com.kh.filoom.event.model.dao.EventDao;
import com.kh.filoom.event.model.vo.Applicant;
import com.kh.filoom.event.model.vo.Event;
import com.kh.filoom.event.model.vo.EventAttachment;
import com.kh.filoom.event.model.vo.Reply;

/**
 * @author user1
 *
 */
@Service
public class EventServiceImpl implements EventService {


	@Autowired
	private SqlSessionTemplate sqlSession;
	

	@Autowired
	private EventDao eventDao;
	
	
	
	/**
	 * 이벤트 상태값 변경
	 */
	@Override
	@Transactional
	public void updateEventStatus() {
		eventDao.updateEventStatus(sqlSession);
		
	}
	
	/**
	 * 241218 한혜원
	 * 사용자 게시글 추천이벤트 목록조회 요청 메소드 
	 */
	@Override
	public List<Event> selectHotEventList() {
		return eventDao.selectHotEventList(sqlSession);
	}
	
	/**
	 * 241212 ~ 241213 한혜원
	 * 사용자 게시글 목록조회 요청 메소드 
	 * 페이징처리 필요없음 
	 * 전체 이벤트 조회 (종료여부 y, n 모두)
	 */
	@Override
	public ArrayList<Event> selectList() {
		return eventDao.selectList(sqlSession);
	}

	/**
	 *241212 ~ 241213 한혜원
	 * 사용자 게시글 목록조회 요청 메소드 
	 * 페이징처리 필요없음 
	 * 종료여부에 따른 필터링된 목록 조회 (종료여부 y, n)
	 */
	@Override
	public ArrayList<Event> selectFilterList(String eventStatus) {
		return eventDao.selectFilterList(sqlSession, eventStatus);
	}

	/**
	 * 241213 한혜원 
	 * 사용자 게시글 상세조회 요청 메소드
	 * 조회수 필요없음
	 */
	@Override
	public Event selectEvent(int eventNo) {
		
		return eventDao.selectEvent(sqlSession, eventNo);
	}
	
	/**
	 * 241213 한혜원 
	 * 사용자 게시글 첨부파일 상세조회 요청 메소드
	 * 조회수 필요없음
	 */
	@Override
	public ArrayList<EventAttachment> selectEventAttachment(int eventNo) {
		
		return eventDao.selectEventAttachment(sqlSession, eventNo);
	}
	

	// 댓글
	/**
	 * 241218 한혜원 
	 * 댓글 총 갯수 
	 */
	@Override
	public int seletReplyListCount(int eventNo) {
		return eventDao.selectReplyListCount(sqlSession, eventNo);
	}
	
	
	
	/**
	 * 241217 한혜원 
	 * 사용자 댓글 목록조회 요청 메소드
	 */
	@Override
	public ArrayList<Reply> selectReplyList(int eventNo, PageInfo pi) {
		return eventDao.selectReplyList(sqlSession, eventNo, pi);
	}
	
	
	/**
	 * 241222 한혜원
	 * 댓글 중복체크
	 */
	@Override
	public boolean checkReplyWriter(int refEno, String replyWriter) {
		
		return eventDao.checkReplyWriter(sqlSession, refEno, replyWriter);
	}
	
	/**
	 * 241217 한혜원 
	 * 댓글 작성용 요청 메소드 
	 */
	@Override
	@Transactional
	public int insertReply(Reply r) {
		return eventDao.insertReply(sqlSession, r);
	}

	/**
	 * 241217 한혜원
	 * 댓글 수정용 요청 메소드 
	 *
	 */
	@Override
	@Transactional
	public int updateReply(Reply r) {
		return eventDao.updateReply(sqlSession, r);
	}

	/**
	 * 241218 한혜원
	 * 댓글 삭제용 요청 메소드
	 */
	@Override
	@Transactional
	public int deleteReply(int replyNo) {
		return eventDao.deleteReply(sqlSession, replyNo);
	}
	
	// 응모 버튼 
	
	/**
	 * 241219 한혜원
	 * 응모자 중복 확인 메소드 
	 */
	@Override
	public boolean checkUserParticipated(int refEno, String userNo) {
		return eventDao.checkUserParticipated(sqlSession, refEno, userNo);
	}

	/**
	 * 241219 한혜원
	 * 응모자 추가 메소드
	 */
	@Override
	@Transactional
	public void insertParticipant(Applicant a) {
		eventDao.insertParticipant(sqlSession, a);
		
	}
	

	// 관리자 --------------------------------------------------------------------------------
	/**
	 * 241211 한혜원 
	 * 관리자용 게시글 작성 메소드 
	 */
	@Override
	@Transactional
	public int insertEvent(Event e) {
		return eventDao.insertEvent(sqlSession, e); // 게시글 저장
		
	}
	

	/**
	 * 241211 한혜원 
	 * 관리자용 첨부파일 등록 메소드 
	 */
	@Override
	@Transactional
	public int insertEventAttachment(EventAttachment eventAttachment) {
		return eventDao.insertEventAttachment(sqlSession, eventAttachment); // 첨부파일저장
	}
	
	
	
	/**
	 * 241222 한혜원
	 * 관리자용 쿠폰 등록 메소드
	 */
	@Override
	@Transactional
	public int insertCoupon(Coupon coupon) {
		if(coupon.getCouponName() != null && !coupon.getCouponName().isEmpty()) {
			return eventDao.insertCoupon(sqlSession, coupon);
		}
		return 0; // 쿠폰이 없으면 저장하지 않음
	}

	/**
	 * 241218 한혜원 
	 * 관리자용 게시글 총 갯수
	 */
	@Override
	public int selectListCount() {
		return eventDao.selectListCount(sqlSession);
	}

	
	/**
	 * 241218 한혜원
	 * 관리자용 게시글 목록 리스트 조회 
	 */
	@Override
	public ArrayList<Event> adminSelectList(PageInfo pi) {
		return eventDao.adminSelectList(sqlSession, pi);
	}
	
	
	/**
	 * 241218 한혜원
	 * 관리자용 게시글 상세조회 
	 */
	@Override
	public Event adminSelectEvent(int eventNo) {
		return eventDao.adminSelectEvent(sqlSession, eventNo);
	}
	
	/**
	 * 241218 한혜원
	 * 관리자용 게시글 첨부파일 상세조회
	 */
	@Override
	public ArrayList<EventAttachment> adminSelectEventAttachment(int eventNo) {
		return eventDao.adminSelectEventAttachment(sqlSession, eventNo);
	}

	
	/**
	 * 241224 한혜원
	 * 게시글 수정
	 */
	@Override
	@Transactional
	public int updateEvent(Event e) {
		return eventDao.updateEvent(sqlSession, e);
	}

	/**
	 * 241224 한혜원
	 * 게시글 첨부파일 수정
	 */
	@Override
	@Transactional
	public int updateEventAttachment(List<Integer> fileNos, String status) {
		return eventDao.updateEventAttachment(sqlSession, fileNos, status);
	}

	/**
	 * 게시글 삭제 메소드
	 */
	@Override
	@Transactional
	public int deleteEvent(int eventNo) {
		return eventDao.deleteEvent(sqlSession, eventNo);
	}

	/**
	 * 241219 한혜원
	 * 댓글 수 
	 */
	@Override
	public int rlistCount(int eventNo) {
		return eventDao.rlistCount(sqlSession, eventNo);
	}

	/**
	 * 241219 한혜원
	 * 댓글 목록 조회
	 */
	@Override
	public List<Reply> adminSelectReplyList(Map<String, Object> params) {
		return eventDao.adminSelectReplyList(sqlSession, params);
	}

	/**
	 * 241219 한혜원
	 * 응모자수
	 */
	@Override
	public int aplistCount(int eventNo) {
		return eventDao.aplistCount(sqlSession, eventNo);
	}

	/**
	 * 241219 한혜원
	 * 응모자 목록 조회
	 */
	@Override
	public List<Applicant> adminSelectApplicantList(Map<String, Object> params) {
		return eventDao.amdinSelectApplicantList(sqlSession, params);
	}
	
	

	@Override
	public int selectCouponListCount(int eventNo) {
		return eventDao.selectCouponListCount(sqlSession, eventNo);
	}

	@Override
	public ArrayList<Coupon> selectCouponList(Map<String, Object> params) {
		return eventDao.selectCouponList(sqlSession, params);
	}


	/**
	 * 쿠폰 발송
	 */
	@Override
	@Transactional
	public int insertCouponUser(int userNo, int couponNo, int eventNo) {
		
		return eventDao.insertCouponUser(sqlSession, userNo, couponNo, eventNo);
	}

	/**
	 * 쿠폰 변경 후 상태 변경
	 */
	@Override
	@Transactional
	public int updateDrawingStatus(int userNo, int eventNo, String drawingStatus) {
		// 응모자의 drawingStatus를 "Y"로 업데이트
	    return eventDao.updateDrawingStatus(sqlSession, userNo, eventNo, drawingStatus);
		
	}
	
	

}
