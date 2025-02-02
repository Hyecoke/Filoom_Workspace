package com.kh.filoom.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.notice.model.vo.Notice;

@Repository
public class NoticeDao {

	// 사용자 ----------------------------------------------------------
	
	/**
	 * 241221 한혜원
	 * 공지사항 게시글 수
	 * @param sqlSession
	 * @return
	 */
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.selectListCount", sqlSession);
	}

	/**
	 * 241221 한혜원
	 * 공지사항 게시글 목록조회
	 * @param sqlSession
	 * @param pi
	 * @return
	 */
	public ArrayList<Notice> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("noticeMapper.selectList", null, rowBounds);
	}
	
	/**
	 * 241221 한혜원
	 * 공지사항 조회수 증가 
	 * @param sqlSession
	 * @param noticeNo
	 * @return
	 */
	public int increaseCount(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.increaseCount", noticeNo);
	}

	/**
	 * 241221 한혜원
	 * 공지사항 게시글 상세조회
	 * @param sqlSession
	 * @param noticeNo
	 * @return
	 */
	public Notice selectNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectNotice", noticeNo);
	}
	
	/**
	 * 241221 한혜원
	 * 공지사항 게시글 이전글 조회
	 * @param sqlSession
	 * @param noticeNo
	 * @return
	 */
	public Notice selectPrevNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectPrevNotice", noticeNo);
	}

	 /**
	 * 공지사항 게시글 다음글 조회
	 * @param sqlSession
	 * @param noticeNo
	 * @return
	 */
	public Notice selectNextNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectNextNotice", noticeNo);
	}
	
	
	// 관리자 ---------------------------------------------------------- 
	/**
	 * 241221 한혜원
	 * 게시글 등록
	 * @param sqlSession
	 * @param n
	 * @return
	 */
	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice", n);
	}

	/**
	 * 241222 한혜원
	 * 게시글 삭제
	 * @param sqlSession
	 * @param noticeNo
	 * @return
	 */
	public int deleteNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.deleteNotice", noticeNo);
	}

	/**
	 * 241222 한혜원
	 * 게시글 수정
	 * @param sqlSession
	 * @param n
	 * @return
	 */
	public int updateNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.update("noticeMapper.updateNotice", n);
	}



}
