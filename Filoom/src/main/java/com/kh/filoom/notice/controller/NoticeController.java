package com.kh.filoom.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.common.template.Pagination;
import com.kh.filoom.notice.model.service.NoticeService;
import com.kh.filoom.notice.model.vo.Notice;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	// 사용자 ----------------------------------
	
	/**
	 * 241221 한혜원
	 * 사용자 공지사항 게시글 목록조회 + 페이징처리
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@GetMapping("list.no")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model) {
		// 게시글 목록 조회 후 페이징 처리 
		int listCount = noticeService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Notice> list = noticeService.selectList(pi);
		
		// 응답데이터로 목록 및 페이징바 관련 객체 넘기고 게시글 목록 조회 페이지를 포워딩 
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", listCount); // 공지사항 총 게시글 수
		
		return "notice/noticeListView";
		
		
	}

	/**
	 * 공지사항 조회수 증가 + 상세조회 + 다음글, 이전글 보여지기
	 * @param nno
	 * @param mv
	 * @return
	 */
	@GetMapping("detail.no")
	public ModelAndView selectNotice(int nno, ModelAndView mv) {
		
		// System.out.println(nno);
		
		// 1. 게시글 조회수 증가 
		int result = noticeService.increaseCount(nno);
		
		if(result>0) {
			// 조회수 증가하면 게시글 상세조회 
			Notice n = noticeService.selectNotice(nno);
			
			// 이전글
			Notice prevNotice = noticeService.selectPrevNotice(nno);
			
			// 다음글
			Notice nextNotice = noticeService.selectNextNotice(nno);
			
			mv.addObject("n", n).setViewName("notice/noticeDetailView");
			mv.addObject("prevNotice", prevNotice);
			mv.addObject("nextNotice", nextNotice);
			
			// System.out.println(n);
			// System.out.println(prevNotice);
			// System.out.println(nextNotice);
		} else {
			mv.addObject("errorMsg", "공지사항 상세조회 실패!").setViewName("common/errorPage");
			
		}
		
		return mv;
	}
	
	// 관리자 ------------------------------------------------------------------
	
	/**
	 * 241221 한혜원
	 * 공지사항 작성 페이지 요청
	 * @return
	 */
	@GetMapping("enrollForm.no")
	public ModelAndView enrollForm(ModelAndView mv) {
		
		mv.setViewName("admin/notice/adminNoticeEnrollForm");
		return mv;
	}
	
	
	/**
	 * 241221 한혜원
	 * 공지사항 게시글 작성
	 * @param n
	 * @param session
	 * @param mv
	 * @return
	 */
	@PostMapping("insert.no")
	public ModelAndView insertNotice(Notice n, HttpSession session, ModelAndView mv) {
		
		int result = noticeService.insertNotice(n);
		
		if(result>0) {
			session.setAttribute("alertMsg", "공지사항 게시글 작성 성공!");
			mv.setViewName("redirect:/list.no");
		} else {
			mv.addObject("errorMsg", "공지사항 게시글 작성 실패").setViewName("common/errorPage");
		}
		return mv;
	}
	
	/**
	 * 241221 한혜원
	 * 관리자 공지사항 게시글 목록조회
	 * @param currentpage
	 * @param model
	 * @return
	 */
	@GetMapping("alist.no")
	public String adminSelectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model) {
		
		// 게시글 목록을 조회한 후 
		// > 페이징 처리용 변수 7개가 필요함! 
		int listCount = noticeService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Notice> list = noticeService.selectList(pi);
		
		// 응답데이터로 목록 및 페이징바 관련 객체 넘기고 게시글 목록 조회 페이지를 포워딩 
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "admin/notice/adminNoticeListView";
		
	}
	
	/**
	 * 241222 한혜원
	 * 관리자용 공지사항 상세조회
	 * @param nno
	 * @param mv
	 * @return
	 */
	@GetMapping("adetail.no")
	public ModelAndView adminSelectNotice(int nno, ModelAndView mv) {
		// System.out.println(nno);
		
		// 게시글 조회수 증가 
		int result = noticeService.increaseCount(nno);
		
		if(result>0) {
			Notice n = noticeService.selectNotice(nno);
			
			mv.addObject("n", n).setViewName("admin/notice/adminNoticeDetailView");
		} else {
			mv.addObject("errorMsg", "공지사항 상세조회 실패").setViewName("common/errorPage");
		}
		return mv;
	}
	
	/**
	 * 241222 한혜원
	 * 공지사항 삭제
	 * @param nno
	 * @param model
	 * @param session
	 * @return
	 */
	@PostMapping("delete.no")
	public String deleteNotice(int nno, Model model, HttpSession session) {
		// System.out.println(nno);
		
		int result = noticeService.deleteNotice(nno);
		
		if(result>0) {
			session.setAttribute("alertMsg", "게시글 삭제 성공!");
			return "redirect:/alist.no";
		} else {
			model.addAttribute("errorMsg", "게시글 삭제 실패!");
			return "common/errorPage";
		}
	}
	
	/**
	 * 241222 한혜원 
	 * 공지사항 게시글 수정 페이지 요청
	 * @param nno
	 * @param model
	 * @return
	 */
	@PostMapping("updateForm.no")
	public String updateForm(int nno, Model model) {
		// System.out.println(nno);
		
		// 게시글 수정하기 페이지에서는 기존의 게시글 제목, 내용 등이 일단 먼저 보여져야 함 
		// > 기존 게시글 상세보기 서비스 로직 재활용
		Notice n = noticeService.selectNotice(nno);
		
		model.addAttribute("n", n);
		return "admin/notice/noticeUpdateForm";
	}
	
	/**
	 * 241222 한혜원 
	 * 공지사항 수정
	 * @param n
	 * @param session
	 * @param model
	 * @return
	 */
	@PostMapping("update.no")
	public String updateNotice(Notice n, HttpSession session, Model model) {
		// System.out.println(n);
		
		int result = noticeService.updateNotice(n);
		
		if(result>0) {
			session.setAttribute("alertMsg", "게시글 수정 성공!");
			
			return "redirect:/detail.no?nno=" + n.getNoticeNo();
		} else {
			model.addAttribute("errorMsg", "게시글 수정 실패");
			return "commom/errorPage";
		}
	}
	
}
