package com.kh.filoom.event.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.coupon.model.vo.Coupon;
import com.kh.filoom.event.model.vo.Applicant;
import com.kh.filoom.event.model.vo.Event;
import com.kh.filoom.event.model.vo.EventAttachment;
import com.kh.filoom.event.model.vo.Reply;

@Repository
public class EventDao {	
	
	
	// 사용자
	
	/**
	 * 이벤트 상태값 변경
	 */
	public void updateEventStatus(SqlSessionTemplate sqlSession) {
		sqlSession.update("eventMapper.updateEventStatus");
	}
	
	/**
	 * 241218 한혜원 
	 * 게시글 추천이벤트 목록조회
	 * @param sqlSession
	 * @return
	 */
	public List<Event> selectHotEventList(SqlSessionTemplate sqlSession) {
		return (List)sqlSession.selectList("eventMapper.selectHotEventList");
	}
	
	/**
	 * 241212 한혜원
	 * 게시글 목록 요청 메소드 -- 페이징처리 안해도 됨
	 * 이벤트 종료여부 상관없이 전체 목록 조회
	 * @param sqlSession
	 * @return
	 */
	public ArrayList<Event> selectList(SqlSessionTemplate sqlSession) {
		// select문 여러행 : selectList 메소드 
		return (ArrayList)sqlSession.selectList("eventMapper.selectList");
	}
	
	/**
	 * 241213 한혜원 
	 * 게시글 목록 요청 메소드 - 페이징 처리  x
	 * 이벤트 종료 여부에 따른 목록조회
	 * @param sqlSession
	 * @param eventStatus 이벤트 종료여부 상태값
	 * @return
	 */
	public ArrayList<Event> selectFilterList(SqlSessionTemplate sqlSession, String eventStatus) {
		
		return (ArrayList)sqlSession.selectList("eventMapper.selectFilterlist", eventStatus);
	}
	
	
	/**
	 * 241213 한혜원
	 * 게시글 상세조회 요청 메소드
	 * @param sqlSession
	 * @param eventNo 게시글 번호 
	 * @return
	 */
	public Event selectEvent(SqlSessionTemplate sqlSession, int eventNo) {
		// 단일행 select문 : selectOne
		
		return sqlSession.selectOne("eventMapper.selectEvent", eventNo);
	}

	
	/**
	 * 241213 한혜원
	 * 게시글 첨부파일 상세조회 요청 메소드
	 * @param sqlSession
	 * @param eventNo 게시글 번호
	 * @return
	 */
	public ArrayList<EventAttachment> selectEventAttachment(SqlSessionTemplate sqlSession, int eventNo) {
		// 여러행 select문 : selectList
		
		return (ArrayList)sqlSession.selectList("eventMapper.selectEventAttachment", eventNo);
	}
	
	// 댓글
	/**
	 * 241218 한혜원
	 * 댓글 갯수
	 * @param eventNo
	 * @return
	 */
	public int selectReplyListCount(SqlSessionTemplate sqlSession, int eventNo) {
		return sqlSession.selectOne("eventMapper.selectReplyListCount", eventNo);
	}
	
	/**
	 * 241217 한혜원
	 * 댓글 목록 조회용 
	 * @param sqlSession
	 * @param eventNo 게시글 번호
	 * @return
	 */
	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int eventNo, PageInfo pi) {
		// select문(여러행) : selectList 메소드 
		// 페이지 계산 
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("eventNo", eventNo);
		paraMap.put("pi", pi);
		
		return (ArrayList)sqlSession.selectList("eventMapper.selectReplyList", paraMap, rowBounds);
	}
	
	
	/**
	 * 241222 한혜원
	 * 댓글 중복체크
	 * @param sqlSession
	 * @param refEno
	 * @param replyWriter
	 * @return
	 */
	public boolean checkReplyWriter(SqlSessionTemplate sqlSession, int refEno, String replyWriter) {
		Integer result = sqlSession.selectOne("eventMapper.checkReplyWriter", 
										   	new HashMap<String, Object>() {{
												   put("refEno", refEno);
												   put("replyWriter", replyWriter);																	   
											  }});
		return result != null && result>0; // 이미 댓글 작성했으면 true;
	}
	
	/**
	 * 241217 한혜원
	 * 댓글 작성용 
	 * @param sqlSession
	 * @param r 댓글 객체 
	 * @return
	 */
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		// insert문 : insert 메소드 
		return sqlSession.insert("eventMapper.insertReply", r);
	}

	
	/**
	 * 241217 한혜원
	 * 댓글 수정용
	 * @param sqlSession
	 * @param r
	 * @return
	 */
	public int updateReply(SqlSessionTemplate sqlSession, Reply r) {
		// update문 : update 메소드 
		return sqlSession.update("eventMapper.updateReply", r);
	}
	
	/**
	 * 241218 한혜원
	 * 댓글 삭제용
	 * @param sqlSession
	 * @param replyNo
	 * @return
	 */
	public int deleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		// update문 : update 메소드 
		return sqlSession.update("eventMapper.deleteReply", replyNo);
	}
	
	// 응모버튼 
	
	/**
	 * 241219 한혜원
	 * 응모자 중복확인
	 * @param sqlSession
	 * @param refEno
	 * @param userNo
	 * @return
	 */
	public boolean checkUserParticipated(SqlSessionTemplate sqlSession, int refEno, String userNo) {
		Integer result = sqlSession.selectOne("eventMapper.checkUserParticipated", 
										   new HashMap<String, Object>() {{
											   put("refEno", refEno);
											   put("userNo", userNo);																	   
										  }});
		return result != null && result>0; // 응모자가 있으면 true;
	}

	/**
	 * 241219 한혜원
	 * 응모 추가
	 * @param a
	 */
	public void insertParticipant(SqlSessionTemplate sqlSession, Applicant a) {
		sqlSession.insert("eventMapper.insertParticipant", a);
		
	}

	



	
	// 관리자용 ---------------------------------------------------------------------------
	
	/**
	 * 241211 한혜원 
	 * 관리자용 이벤트 게시글 작성용 처리 메소드 
	 * @param sqlSession
	 * @param e => event 객체 
	 * @return
	 */
	public int insertEvent(SqlSessionTemplate sqlSession, Event e) {
		
		return sqlSession.insert("eventMapper.insertEvent", e); // 게시글 저장 
	}

	
	/**
	 * 241211 한혜원 
	 * 관리자용 이벤트 게시글 첨부파일 등록 메소드 
	 * @param sqlSession
	 * @param eventAttachment
	 * @return
	 */
	public int insertEventAttachment(SqlSessionTemplate sqlSession, EventAttachment eventAttachment) {
		return sqlSession.insert("eventMapper.insertEventAttachment", eventAttachment); // 첨부파일 저장
	}
	
	/**
	 * 241222 한혜원
	 * 관리자용 쿠폰 등록 메소드 
	 * @param sqlSession
	 * @param coupon
	 * @return
	 */
	public int insertCoupon(SqlSessionTemplate sqlSession, Coupon coupon) {
		return sqlSession.insert("eventMapper.insertCoupon", coupon);
	}

	/**
	 * 241218 한혜원
	 * 관리자용 게시글 총 갯수
	 * @param sqlSession
	 * @return
	 */
	public int selectListCount(SqlSessionTemplate sqlSession) {
		// 단일행 select문 
		return sqlSession.selectOne("eventMapper.selectListCount");
	}

	/**
	 * 241218 한혜원
	 * 관리자용 게시글 목록조회
	 * @param sqlSession
	 * @param pi
	 * @return
	 */
	public ArrayList<Event> adminSelectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		// 여러행 select문 
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("eventMapper.adminSelectList", null, rowBounds);
	}

	/**
	 * 241218 한혜원
	 * 관리자용 게시글 상세조회
	 * @param sqlSession
	 * @param eno
	 * @return
	 */
	public Event adminSelectEvent(SqlSessionTemplate sqlSession, int eventNo) {
		// select문 단행 
		return sqlSession.selectOne("eventMapper.adminSelectEvent", eventNo);
	}

	/**
	 * 241218 한혜원
	 * 관리자 게시글 첨부파일 상세조회
	 * @param sqlSession
	 * @param eventNo
	 * @return
	 */
	public ArrayList<EventAttachment> adminSelectEventAttachment(SqlSessionTemplate sqlSession, int eventNo) {
		// 여러행 select문 
		return (ArrayList)sqlSession.selectList("eventMapper.adminSelectEventAttachment", eventNo);
	}
	
	/**
	 * 241224 한혜원
	 * 관리자 게시글 수정
	 * @param sqlSession
	 * @param e
	 * @return
	 */
	public int updateEvent(SqlSessionTemplate sqlSession, Event e) {
		return sqlSession.update("eventMapper.updateEvent", e);
	}

	/**
	 * 241224 한혜원
	 * 관리자 게시글 첨부파일 수정
	 * @param sqlSession
	 * @param fileNos
	 * @param status
	 * @return
	 */
	public int updateEventAttachment(SqlSessionTemplate sqlSession, List<Integer> fileNos, String status) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("fileNos", fileNos);
		params.put("status", status);
		
		return sqlSession.update("eventMapper.updateEventAttachment", params);
	}
	
	/**
	 * 241222 한혜원
	 * 게시글 삭제
	 * @param sqlSession
	 * @param eventNo
	 * @return
	 */
	public int deleteEvent(SqlSessionTemplate sqlSession, int eventNo) {
		return sqlSession.update("eventMapper.deleteEvent", eventNo);
	}


	/**
	 * 241219 한혜원
	 * 댓글 목록 수 
	 * @param sqlSession
	 * @param eventNo
	 * @return
	 */
	public int rlistCount(SqlSessionTemplate sqlSession, int eventNo) {
		return sqlSession.selectOne("eventMapper.rlistCount", eventNo);
	}

	/**
	 * 241219 한혜원
	 * 관리자 댓글 목록조회
	 * @param sqlSession
	 * @param params
	 * @return
	 */
	public List<Reply> adminSelectReplyList(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		
		// PageInfo 를 통해 페이징 정보도 포함시키기 위해 RowBounds 사용 
		PageInfo pi = (PageInfo) params.get("pi");
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
	    int limit = pi.getBoardLimit();
	    
	    RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (List)sqlSession.selectList("eventMapper.adminSelectReplyList", params, rowBounds);
	}

	/**
	 * 241219 한혜원
	 * 응모자 수 
	 * @param sqlSession
	 * @param eventNo
	 * @return
	 */
	public int aplistCount(SqlSessionTemplate sqlSession, int eventNo) {
		return sqlSession.selectOne("eventMapper.aplistCount", eventNo);
	}

	/**
	 * 241219 한혜원
	 * 응모자 목록조회
	 * @param sqlSession
	 * @param params
	 * @return
	 */
	public List<Applicant> amdinSelectApplicantList(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		
		// PageInfo 를 통해 페이징 정보도 포함시키기 위해 RowBounds 사용 
		PageInfo pi = (PageInfo) params.get("pi");
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
	    int limit = pi.getBoardLimit();
	    
	    RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (List)sqlSession.selectList("eventMapper.adminSelectApplicantList", params, rowBounds);
	}
	
	/**
	 * 쿠폰 수
	 * @param sqlSession
	 * @param eventNo
	 * @return
	 */
	public int selectCouponListCount(SqlSessionTemplate sqlSession, int eventNo) {
		return sqlSession.selectOne("eventMapper.selectCouponListCount", eventNo);
	}

	/**
	 * 쿠폰목록조회
	 * @param sqlSession
	 * @param params
	 * @return
	 */
	public ArrayList<Coupon> selectCouponList(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		PageInfo pi = (PageInfo)params.get("pi");
		int offset = (pi.getCurrentPage()-1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (ArrayList)sqlSession.selectList("eventMapper.selectCouponList", params, rowBounds);
	}

	/**
	 * 241219 한혜원
	 * 당첨자 정보 저장
	 * @param sqlSession
	 * @param params
	 * @return
	 */
	public int insertWinners(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		return sqlSession.insert("eventMapper.insertWinners", params);
	}

	public int couponInsertEx(SqlSessionTemplate sqlSession, Map<String, Object> params) {
		return sqlSession.insert("couponMapper.couponInsertEx", params);
	}

	/**
	 * 쿠폰 발송하는거 
	 * @param sqlSession
	 * @param userNo
	 * @param couponNo
	 * @return
	 */
	public int insertCouponUser(SqlSessionTemplate sqlSession, int userNo, int couponNo, int eventNo) {
		Map<String, Object> params = new HashMap<>();
        params.put("userNo", userNo);
        params.put("couponNo", couponNo);
        params.put("eventNo", eventNo);

        return sqlSession.insert("couponMapper.insertCouponUser", params);
	}

	public int updateDrawingStatus(SqlSessionTemplate sqlSession, int userNo, int eventNo, String drawingStatus) {
		// SQL을 실행하여 응모자의 상태를 "Y"로 업데이트
	    Map<String, Object> params = new HashMap<>();
	    params.put("userNo", userNo);
	    params.put("eventNo", eventNo);
	    params.put("drawingStatus", drawingStatus);

	    return sqlSession.update("eventMapper.updateDrawingStatus", params); // 매퍼의 이름과 메소드 호출
		
	}







	
}
