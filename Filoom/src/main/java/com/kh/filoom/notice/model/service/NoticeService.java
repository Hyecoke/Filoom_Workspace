package com.kh.filoom.notice.model.service;

import java.util.ArrayList;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.notice.model.vo.Notice;

public interface NoticeService {

	// 사용자 
	// 게시판 리스트 조회 서비스 + 페이징처리
	// 게시글 총 갯수 조회 
	int selectListCount();
	
	// 게시글 목로조회 
	ArrayList<Notice> selectList(PageInfo pi);
	
	// 게시글 상세조회 서비스 
	// 게시글 조회수 증가 
	int increaseCount(int noticeNo);
	
	// 게시글 상세조회 
	Notice selectNotice(int noticeNo);
	
	// 이전글 조회
	Notice selectPrevNotice(int noticeNo);

	// 다음글 조회
	Notice selectNextNotice(int noticeNo);
	
	// 게시글 작성
	int insertNotice(Notice n);
	
	// 게시글 삭제 
	int deleteNotice(int noticeNo);
	
	// 게시글 수정 
	int updateNotice(Notice n);

	
}
