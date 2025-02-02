package com.kh.filoom.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.notice.model.dao.NoticeDao;
import com.kh.filoom.notice.model.vo.Notice;

@Service
public class NoticeServiceImple implements NoticeService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao  noticeDao;

	// 사용자----------------------------------------------------
	
	/**
	 * 241221 한혜원
	 * 공지사항 게시글 수
	 */
	@Override
	public int selectListCount() {
		return noticeDao.selectListCount(sqlSession);
	}

	/**
	 * 241221 한혜원
	 * 공지사항 게시글 목록조회
 	 */
	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		return noticeDao.selectList(sqlSession, pi);
	}

	/**
	 * 241221 한혜원
	 * 공지사항 게시글 조회수 증가
	 */
	@Override
	public int increaseCount(int noticeNo) {
		return noticeDao.increaseCount(sqlSession, noticeNo);
	}
	
	/**
	 * 241221한혜원
	 * 공지사항 게시글 상세조회
	 */
	@Override
	public Notice selectNotice(int noticeNo) {
		return noticeDao.selectNotice(sqlSession, noticeNo);
	}
	
	
	/**
	 * 241221 한혜원
	 * 공지사항 이전글 조회
	 */
	@Override
	public Notice selectPrevNotice(int noticeNo) {
		return noticeDao.selectPrevNotice(sqlSession, noticeNo);
	}

	/**
	 * 241221 한혜원
	 * 공지시항 다음글 조회
	 */
	@Override
	public Notice selectNextNotice(int noticeNo) {
		return noticeDao.selectNextNotice(sqlSession, noticeNo);
	}


	/**
	 * 241221 한혜원
	 * 게시글 등록
	 */
	@Override
	@Transactional
	public int insertNotice(Notice n) {
		return noticeDao.insertNotice(sqlSession, n);
	}

	/**
	 * 241222 한혜원
	 * 게시글 삭제
	 */
	@Override
	@Transactional
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(sqlSession, noticeNo);
	}

	/**
	 * 241222 한혜원
	 * 게시글 수정
	 */
	@Override
	@Transactional
	public int updateNotice(Notice n) {
		return noticeDao.updateNotice(sqlSession, n);
	}

	
}
