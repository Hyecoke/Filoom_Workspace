package com.kh.filoom.event.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.filoom.common.model.vo.PageInfo;
import com.kh.filoom.common.template.Pagination;
import com.kh.filoom.coupon.model.vo.Coupon;
import com.kh.filoom.event.model.service.EventService;
import com.kh.filoom.event.model.vo.Applicant;
import com.kh.filoom.event.model.vo.Event;
import com.kh.filoom.event.model.vo.EventAttachment;
import com.kh.filoom.event.model.vo.Reply;

@Controller
public class EventController {
	
	@Autowired
	private EventService eventService;
	
	// 사용자

	/**
	 * 241212 ~ 241213 한혜원
	 * 사용자 게시글 목록조회 (페이징 처리 없이) 
	 * ++ 이벤트 종료 여부에 따른 필터링 처리 
	 * @param eventSataus 이벤트 종료 여부
	 * @param model
	 * @return
	 */
	@GetMapping("list.ev")
	public String selectList(@RequestParam(value="eventStatus", required=false)String eventStatus, Model model) {
		
		// 먼저 이벤트 상태를 갱신 
		eventService.updateEventStatus(); // 이벤트 상태 업데이트 호출
		
		// 페이징 처리 필요없음 
		// eventStatus 가 없으면 전체 목록, 있으면 그에 맞는 목록을 가져옴
		ArrayList<Event> list;
		String statusTitle = "전체 이벤트"; // 기본제목
		
		// 추천 이벤트 따로 가져오는 로직 추가 
		List<Event> hotList = eventService.selectHotEventList(); // 추천 이벤트 가져오기 
		
		
		// eventStatus 값이 있으면 해당하는 목록만 조회
		if("N".equals(eventStatus)) {
			list = eventService.selectFilterList(eventStatus);
			statusTitle = "진행중인 이벤트"; // 진행중인 이벤트 제목
		} else if("Y".equals(eventStatus)) {
			list = eventService.selectFilterList(eventStatus);
			statusTitle = "지난 이벤트"; // 진행중인 이벤트 제목
		} else {
			// eventStatus 가 없으면 전체 목록을 조회 (기본값) 
			list = eventService.selectList(); // 모든 이벤트를 가져오는 서비스 호출
			statusTitle = "전체 이벤트"; // 진행중인 이벤트 제목
		}
		model.addAttribute("list", list);
		model.addAttribute("statusTitle", statusTitle);  // 제목을 모델에 전달
		model.addAttribute("hotList", hotList);
		
		 // System.out.println(list);
		// System.out.println("list size : " + list.size());
		// System.out.println(statusTitle);
		// System.out.println(eventStatus);
		// System.out.println(hotList);
		
		return "event/eventListView";
	}
	
	
	/**
	 * 241213 한혜원
	 * 사용자 이벤트 게시글 상세조회 페이지 요청(쿼리스트링 이용)
	 * 조회수 처리 x
	 * @return
	 */
	@GetMapping("detail.ev")
	public ModelAndView selectEvent(int eno, ModelAndView mv) {
		
		// System.out.println(eno);
		
		// 게시글 정보, 첨부파일 정보 조회해오기 
		Event e = eventService.selectEvent(eno);
		
		// 게시글이 없는 경우 에러페이지로 포워딩
		if(e == null) {
			mv.setViewName("common/errorPage");
			mv.addObject("errorMsg", "해당 게시글을 찾을 수 없습니다.");
			return mv;
		}
		
		// 게시글 정보와 첨부파일 정보 조회 후 상세페이지 포워딩 
		ArrayList<EventAttachment> list = eventService.selectEventAttachment(eno);
		
		
		// 조회된 데이터드 담아서 응답페이지로 포워딩 
		mv.addObject("e", e);
		mv.addObject("list", list);
		mv.setViewName("event/eventDetailView");
		
		 // System.out.println(e);
		 System.out.println("상세조회 첨부파일 리스트 : " + list);
		
		
		return mv;
		
	}
	
	
	/**
	 * 241217 한혜원 
	 * 댓글 목록조회 요청 (ajax)
	 * @return
	 */
	@ResponseBody
	@GetMapping(value="rlist.ev", produces="application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int eno, @RequestParam(value="cpage", defaultValue="1") int currentpage) {
		// System.out.println(eno);
		
		// 댓글 목록의 총 개수 조회 
		int listCount = eventService.seletReplyListCount(eno);
		
		// 페이지당 댓글 수와 페이지번호 설정
		int pageLimit = 10;
		int boardLimit = 10; 
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentpage, pageLimit, boardLimit);
		
		// 페이징된 댓글 목록 조회
		ArrayList<Reply> list = eventService.selectReplyList(eno, pi);
		
		// 응답 데이터 JSON 형식으로 반환할 객체 
		Map<String, Object> response = new HashMap<>();
		response.put("list", list);
		response.put("pi", pi);
		
		// System.out.println(list);
		// System.out.println(pi);
		return new Gson().toJson(response);
		
	}
	
	/**
	 * 241217 댓글 작성용 요청
	 * @param r
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="rinsert.ev", produces="application/json; charset=UTF-8")
	public Map<String, Object> ajaxInsertReply(@RequestBody Reply r, HttpSession session) {
		System.out.println(r);
		
		Map<String, Object> response = new HashMap<>();
		
		// 중복체크 
		boolean checkWriter = eventService.checkReplyWriter(r.getRefEno(), r.getReplyWriter());
		
		if(checkWriter) {
			response.put("success", false);
			response.put("message", "이미 댓글을 작성하셧습니다.");
		} else {
			// 댓글 작성
			int result = eventService.insertReply(r);
			
			if(result>0) {
				response.put("success", true);
				response.put("message", "댓글 작성이 완료되었습니다!");
			} else {
				response.put("success", false);
				response.put("message", "댓글 작성에 실패했습니다.");
			}
			
		}

		return response;
	}

	
	/**
	 * 241217~18 댓글 수정용 요청
	 * @param r (replyNo, replyContent, replyWriter)
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="rupdate.ev")
	public Map<String, String> ajaxUpdateReply(@RequestBody Reply r) {
		System.out.println("수정 요청 데이터 : " + r);
		
		// 댓글 수정 결과로 반환하기 
		int result = eventService.updateReply(r);
		
		// 결과를 JSON 형식으로 반환 
		Map<String, String> response = new HashMap<>();
		if(result>0) {
			response.put("status", "success");
			response.put("message", "댓글이 수정되었습니다.");
		} else {
			response.put("status", "fail");
			response.put("message", "댓글 수정에 실패했습니다.");
		}
		
		return response;
	}
	
	
	
	/**
	 * 241218 한혜원 댓글 삭제요청
	 * @param replyNo
	 * @return
	 */
	@RequestMapping(value="rdelete.ev", method=RequestMethod.POST)
	@ResponseBody
	public String ajaxDeleteReply(@RequestParam("replyNo") int replyNo) {
		int result = eventService.deleteReply(replyNo);
		
		if (result>0) {
            return "success"; // 삭제 성공
        } else {
            return "failure"; // 삭제 실패
        }
	}
	
	// 응모버튼 
	/**
	 * 241219 한혜원
	 * 응모 버튼 중복 체크 및 응모하기 
	 * @param a
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="apply.ev", produces="application/json; charset=UTF-8")
	public Map<String, Object> ajaxParticipateInButton(@RequestBody Applicant a) {
		// System.out.println("요청 보낼 데이터 : " + a);
		
		Map<String, Object> response = new HashMap<>();
		if(eventService.checkUserParticipated(a.getRefEno(), a.getUserNo())) {
			response.put("success", false);
			response.put("message", "이미 이 이벤트를 응모하셨습니다!");
		} else {
			eventService.insertParticipant(a); // 응모 처리
			response.put("success", true);
			response.put("message", "응모가 완료되었습니다!");
		}
		
		return response;
		
	}
	
	// ------------------------------------------------------------------------------------------------- 관리자용 
	/**
	 * 241211 한혜원 
	 * 게시글 작성페이지 요청 
	 * @return
	 */
	@GetMapping("enrollForm.ev")
	public String enrollForm() {
		
		return "admin/event/adminEventEnrollForm";
	}
	

	/**
	 * 241222 한혜원
	 * 쿠폰 등록 페이지 요청
	 * @return
	 */
	@GetMapping("couponForm.ev")
	public String couponForm(@RequestParam("eventNo") int eventNo, Model model) {
		model.addAttribute("eventNo", eventNo); // 쿠폰 등록에서 사용할 이벤트 번호 전달
		return "admin/event/couponEnrollForm"; // 쿠폰 등록 폼 html 반환
	}
	
	
	/**
	 * 241211 ~ 241212 한혜원 
	 * 게시글 작성 요청
	 * @param eventType
	 * @param e
	 * @param upfiles
	 * @param session
	 * @param mv
	 * @return
	 */
	@PostMapping("insert.ev")
	public ModelAndView insertEvent(@RequestParam("eventType") int eventType, Event e, 
	                                @RequestParam("upfiles") MultipartFile[] upfiles, HttpSession session, ModelAndView mv) {
	    // 첨부파일 리스트 생성
	    List<EventAttachment> eventAttachmentList = new ArrayList<>();

	    // Event 객체에 eventType 설정
	    e.setEventType(eventType); // 이벤트 타입 설정
	    // System.out.println(eventType);

	    int fileLevel = 1; // 대표이미지 1, 일반파일 2

	    // 첨부파일 처리 로직
	    for (MultipartFile upfile : upfiles) {
	        if (!upfile.getOriginalFilename().equals("")) {
	            String changeName = saveFile(upfile, session); // 파일 저장 및 이름 변경
	            EventAttachment eventAttachment = new EventAttachment();
	            eventAttachment.setOriginName(upfile.getOriginalFilename());
	            eventAttachment.setChangeName("/resources/eventUploadFiles/" + changeName);
	            eventAttachment.setFilePath(changeName);

	            // 첫 번째 파일은 대표 이미지로 설정, 이후는 일반 파일로 설정
	            eventAttachment.setFileLevel(fileLevel);
	            if (fileLevel == 1) {
	                fileLevel = 2;
	            }

	            eventAttachmentList.add(eventAttachment); // 리스트에 추가
	        }
	    }

	    // 게시글 저장 서비스 호출
	    int result = eventService.insertEvent(e);

	    if (result > 0) {
	    	int eventNo = e.getEventNo();  // 새로 삽입된 이벤트 번호 가져오기
	        // System.out.println("Inserted eventNo: " + eventNo); // 추가된 이벤트 번호 확인
	    	
	        // 게시글 저장 성공 시, 첨부파일 저장 로직 실행
	        for (EventAttachment eventAttachment : eventAttachmentList) {
	            eventAttachment.setRefEno(eventNo); // 저장된 게시글 번호를 참조번호로 설정
	            eventService.insertEventAttachment(eventAttachment); // 첨부파일 저장
	        }
	        

	        Coupon coupon = new Coupon();

		     // 쿠폰 객체 추가 정보 설정
		     coupon.setRefEno(eventNo);
		     coupon.setCouponName(e.getEventTitle());
		     coupon.setCouponLevel(e.getEventType());
	
		      // System.out.println("Event Start Date: " + e.getStartDate());
		      // System.out.println("couponLevel : " + eventType);
	
		     // DateTimeFormatter 사용하여 문자열을 LocalDate로 변환
		     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		     LocalDate date = LocalDate.parse(e.getStartDate(), formatter);
	
		     // 6개월 더하기
		     LocalDate newDate = date.plusMonths(6);
	
		     // 결과 출력
		     // System.out.println("Start Date: " + e.getStartDate());
		     // System.out.println("New Date (6 months later): " + newDate);
	
		     // LocalDate를 java.util.Date로 변환
		     Date finalDate = java.util.Date.from(newDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
	
		     // finalDate를 set
		     coupon.setCouponExpDate(finalDate);
	
		     // finalDate를 'yyyy-MM-dd' 형식으로 포맷팅하여 문자열로 출력 (디버깅)
		     SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		     String formattedDate = sdf.format(finalDate);  // "yyyy-MM-dd" 형식으로 변환
	
		     // System.out.println("Formatted Coupon Expiry Date: " + formattedDate);
		      // System.out.println("Coupon Info: " + coupon);
	
		     // 쿠폰 등록 서비스 호출
		     int couponResult = eventService.insertCoupon(coupon);
	
		     // 결과 확인
		     if (couponResult > 0) {
		         // 등록 성공 처리
		          session.setAttribute("alertMsg", "이벤트 및 쿠폰 등록 성공");
		          mv.setViewName("redirect:/list.ev");
		     } else {
		         // 실패 시 처리
		          session.setAttribute("alertMsg", "이벤트 등록 성공, 하지만 쿠폰 등록 실패!");
		          mv.setViewName("redirect:/list.ev");
		     }
		     
		    

	    } else {
	        // 실패 시 에러 페이지로 이동
	        mv.addObject("errorMsg", "이벤트 게시글 작성 실패").setViewName("common/errorPage");
	    }

	    // 디버깅용 로그 출력
	    // System.out.println("Event: " + e);
	     // System.out.println("Attachments: " + eventAttachmentList);
	    return mv;
	         
	
	}
	
	
	/**
	 * 241218 한혜원
	 * 관리자용 이벤트게시글 목록조회 요청 
	 * @param currentpage
	 * @param model
	 * @return
	 */
	@GetMapping("alist.ev")
	public String adminSelectList(@RequestParam(value="cpage", defaultValue="1")int currentpage, Model model) {
		// 게시글 목록조회 후 페이징 처리 변수 필요 
		int listCount = eventService.selectListCount();
		
		int pageLimit = 10;
		int boardLimint = 5;
		PageInfo pi = Pagination.getPageInfo(listCount, currentpage, pageLimit, boardLimint);
		
		ArrayList<Event> list = eventService.adminSelectList(pi);
		
		// 응답데이터로 목록 및 페이징 관련 객체 넘기로 페이지 포워딩
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		// System.out.println(list);
		
		return "admin/event/adminEventListView";
	}
	
	/**
	 * 241218 한혜원
	 * 관리자 이벤트 게시글 상세조회 페이지 (쿼리스트링) 
	 * @param eno
	 * @param mv
	 * @return
	 */
	@GetMapping("adetail.ev")
	public ModelAndView adminSelectEvent(int eno, ModelAndView mv) {
		// System.out.println(eno);
		
		// 게시글정보, 첨부파일 정보 조회 
		Event e = eventService.adminSelectEvent(eno);
		
		// 게시글이 없는 경우 에러페이지로 포워딩 
		if(e == null) {
			mv.setViewName("common/errorPage");
			mv.addObject("errorMsg", "해당 게시글을 찾을 수 없습니다.");
			return mv;
		}
		
		// 게시글 정보와 첨부파일 정보 조회 후 상세페이지 포워딩 
		ArrayList<EventAttachment> list = eventService.selectEventAttachment(eno);
		
		// 조회된 데이터드 담아서 응답페이지로 포워딩 
		mv.addObject("e", e);
		mv.addObject("list", list);
		mv.setViewName("admin/event/adminEventDetailView");
		
		//System.out.println("상세조회 : " + e);
		//System.out.println("상세조회 : " + list);
				
				
		return mv;
	}
	
	
	/**
	 * 241222 한혜원
	 * 게시글 수정하기 페이지 요청
	 * @param eventNo
	 * @param model
	 * @return
	 */
	@GetMapping("updateForm.ev")
	public String updateForm(int eno, Model mv) {
		// System.out.println(eno);
		
		Event e = eventService.selectEvent(eno);
		ArrayList<EventAttachment> list = eventService.selectEventAttachment(eno);
		
		// 조회된 이벤트 정보와 첨부파일 목록 모델에 추가하여 수정페이지로 전달 
		// System.out.println("List: " + (list != null ? list : "null") + " | Size: " + (list != null ? list.size() : "0"));
		mv.addAttribute("e", e);
		mv.addAttribute("list", list);
		
	    // System.out.println(e);
		// System.out.println(list);
		// System.out.println(e.getEventStatus());
		// System.out.println(mv);
		 
		 
		// 수정 페이지로 이동
		//mv.setViewName("admin/event/eventUpdateForm");
		return "admin/event/eventUpdateForm";
		
	}
	
	
	/**
	 * 241224 한혜원
	 * 게시글 수정
	 */
	@PostMapping("update.ev")
	public ModelAndView updateEvent(Event e,
	                                @RequestParam(value = "currentImage1", required = false) MultipartFile[] currentImage1,
	                                @RequestParam(value = "currentImage2", required = false) MultipartFile[] currentImage2,
	                                @RequestParam(value = "currentImage3", required = false) MultipartFile[] currentImage3,
	                                @RequestParam(value = "currentImage4", required = false) MultipartFile[] currentImage4,
	                                @RequestParam(value = "newUpFiles", required = false) MultipartFile[] newUpFiles,
	                                HttpSession session, ModelAndView mv) {

		
		System.out.println(currentImage1);
		System.out.println("2" + currentImage2);
		System.out.println("3" + currentImage3);
		System.out.println("4" + currentImage4);
		
		  // currentImage1 (MultipartFile 배열)을 순회하여 출력
	    if (currentImage1 != null) {
	        for (MultipartFile file : currentImage1) {
	            // 파일의 이름, 콘텐츠 타입, 크기 출력
	            System.out.println("File name: " + file.getOriginalFilename());
	            System.out.println("File content type: " + file.getContentType());
	            System.out.println("File size: " + file.getSize());
	        }
	    }
	    
	    // 수정된 Event 정보 출력
	    System.out.println("e: " + e);
	    
	    // currentImage1 배열 (MultipartFile[])에 대해 출력
	    if (currentImage1 != null) {
	        System.out.println("files: ");
	        for (MultipartFile file : currentImage1) {
	            System.out.println(file.getOriginalFilename());
	        }
	    }
	    
	    return mv;
	}

	// 파일 저장 메서드 예시
	private String storeFile(MultipartFile file) {
	    // 파일 저장 처리 (예시)
	    String fileName = file.getOriginalFilename();
	    Path path = Paths.get("upload-dir", fileName); // 저장할 경로와 파일명 설정
	    try {
	        Files.write(path, file.getBytes());
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return fileName; // 저장된 파일명 리턴
	}
	
	/**
	 * 게시글 삭제
	 * @param eno
	 * @param filePaths
	 * @param session
	 * @param model
	 * @return
	 */
	@PostMapping("delete.ev")
	public String deleteEvent(@RequestParam("eno") int eno, 
	                          @RequestParam(value = "filePaths", required = false) List<String> filePaths,
	                          HttpSession session, 
	                          Model model) {
	    System.out.println("삭제 요청 게시글 번호: " + eno);

	    // 게시글 삭제 서비스 호출 (상태값 변경)
	    int result = eventService.deleteEvent(eno);

	    if (result > 0) {
	        // 첨부파일 서버에서 삭제
	        if (filePaths != null && !filePaths.isEmpty()) {
	            for (String filePath : filePaths) {
	                if (filePath != null && !filePath.equals("")) {
	                    String realPath = session.getServletContext().getRealPath(filePath);
	                    File file = new File(realPath);
	                    if (file.exists() && file.isFile()) {
	                        boolean deleted = file.delete();
	                        // System.out.println("파일 삭제 성공 여부: " + deleted + " / 경로: " + filePath);
	                    }
	                }
	            }
	        }
	        session.setAttribute("alertMsg", "게시글 삭제 성공!");
	        return "redirect:/list.ev";
	    } else {
	        model.addAttribute("errorMsg", "게시글 삭제 실패!");
	        return "common/errorPage";
	    }
	}

	
	/**

	 * 241223 한혜원
	 * 쿠폰목록조회
	 * @param eventNo
	 * @param currentPage
	 * @param model
	 * @return
	 */
	@GetMapping("clist.ev")
	public String selectCouponList(@RequestParam(value="eventNo", required=false)int eventNo,
								   @RequestParam(value="cpage", defaultValue="1")int currentPage, 
								   Model model) {
		
		// System.out.println(eventNo);
		
		if(eventNo == 0) {
			return "errorPage";
		}
		
		// 쿠폰 목록 조회 후 페이징 처리 변수 필요
		int listCount = eventService.selectCouponListCount(eventNo);
		
		int pageLimit = 10;
		int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		// 페이징처리된 쿠폰목록조회 
		Map<String, Object> params = new HashMap<>();
		params.put("eventNo", eventNo);
		params.put("pi", pi);
		
		ArrayList<Coupon> list = eventService.selectCouponList(params);
		
		// 응답데이터로 목록 및 페이징 관련 객체 넘기기
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("eventNo", eventNo);
		System.out.println(params);
		
		// System.out.println(listCount);
		// System.out.println(list);
		
		return "admin/event/adminCouponListView";

	}
	
	
	
	// 응모자 확인 (댓글+버튼) + 버튼 응모자들에게 쿠폰 발급하기 
	/**
	 * 241219 한혜원
	 * 응모자 확인 버튼 클릭시, 해당 타입에 맞는 응모자 목록조회 페이지 요청 
	 * 1이면 댓글 목록
	 * 2이면 버튼 응모 목록
	 * 페이징처리
	 * @param eventNo
	 * @param eventType
	 * @param model
	 * @return
	 */
	@RequestMapping("aplist.ev")
	public String selectApplicantList(@RequestParam("eventNo")int eventNo, 
									  @RequestParam("eventType")int eventType,
									  @RequestParam(value="cpage", defaultValue="1")int currentpage,
									  Model model) {
		
		// System.out.println(eventNo);
		// System.out.println(eventType);
		
		// 페이지 정보를 계산하기 위한 코드 
		int listCount = 0; 
		int pageLimit = 10;
		int boardLimit = 10;
		PageInfo pi = null;
		List<Reply> rlist = null; // 댓글 목록
	    List<Applicant> alist = null; // 응모자 목록

		
		
		// eventNo, eventType 만 사용하여 특정 기능 실행 
		if(eventType == 1) {
			// 댓글 목록일 경우
			listCount = eventService.rlistCount(eventNo); // 댓글 개수 조회 
			pi = Pagination.getPageInfo(listCount, currentpage, pageLimit, boardLimit);
			// System.out.println("댓글 페이지 정보 (pi): " + pi);
			
			// 페이징 적용하여 댓글 목록 조회 
			Map<String, Object> params = new HashMap<>();
			params.put("eventNo", eventNo);
			params.put("pi", pi);
			
			rlist = eventService.adminSelectReplyList(params);
			model.addAttribute("rlist", rlist);
			model.addAttribute("pi", pi); // 페이징 정보 넘기기
			
			return "admin/event/adminReplyListView"; // 댓글 목록 페이지
			
		} else if(eventType == 2) {
			// 버튼 응모자 목록조회 
			listCount = eventService.aplistCount(eventNo); // 응모자 수 조회 
			pi = Pagination.getPageInfo(listCount, currentpage, pageLimit, boardLimit);
			// System.out.println("응모자 페이지 정보 (pi): " + pi);
			
			// 페이징 적용하여 응모자 목록 조회 
			Map<String, Object> params = new HashMap<>();
			params.put("eventNo", eventNo);
			params.put("pi", pi);
			
			
			alist = eventService.adminSelectApplicantList(params);
			
			System.out.println("alist 는 " +alist);
			
			model.addAttribute("alist", alist);
			model.addAttribute("pi", pi); // 페이징 정보 넘기기

			return "admin/event/applicantListView"; // 버튼 응모자 목록 페이지
		} else {
			model.addAttribute("errorMsg", "해당 이벤트는 오프라인 타입입니다.");
			return "admin/event/adminEventListView"; // 에러 페이지로 이동
		}
				
	}
	
	
	/**
	 * 쿠폰 발송
	 * @param params
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="sendCoupon.ev", produces="application/json; charset=UTF-8")
	public Map<String, Object> sendCoupon(@RequestParam Map<String, String> params) {
	    Map<String, Object> response = new HashMap<>();
	    
	    try {
	        // params에서 userNo, couponNo, eventNo 추출
	        int userNo = Integer.parseInt(params.get("userNo"));
	        int couponNo = Integer.parseInt(params.get("couponNo"));
	        int eventNo = Integer.parseInt(params.get("eventNo")); // 기본값 0으로 설정
	        System.out.println(userNo);
	        System.out.println(couponNo);
	        System.out.println(eventNo);

	        // 기존 쿠폰을 응모자에게 할당
	        int result = eventService.insertCouponUser(userNo, couponNo, eventNo);
	        
	        
	        if (result > 0) {
	        	// 쿠폰 발급이 성공한 후 상태를 "Y"로 업데이트
	            eventService.updateDrawingStatus(userNo, eventNo, "Y"); // 상태값 "Y"로 업데이트
	        	
	            response.put("success", true);
	            response.put("couponNo", couponNo);
	        } else {
	            response.put("success", false);
	            response.put("message", "쿠폰 할당 실패");
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생했습니다: " + e.getMessage());
	    }

	    return response;
	}
		
	
	/**
	 * 241220 한혜원
	 * 당첨자 목록 저장
	 * @param winnerData
	 * @return
	 
	@ResponseBody
	@PostMapping(value="insertWin.ev", produces="application/json; charset=UTF-8")
	public String insertWinners(@RequestParam("eventNo") int eventNo, 
	                            @RequestParam("eventType") int eventType, 
	                            @RequestParam("winners") List<Integer> winners) {
		
		System.out.println(winners);
	    // WINNER_TYPE은 eventType과 동일
	    int winnerType = eventType; 
	    
	    // 서비스에 필요한 데이터 전달
	    Map<String, Object> params = new HashMap<>();
	    params.put("eventNo", eventNo);
	    params.put("winnerType", winnerType);
	    params.put("winners", winners);

	    int result = eventService.insertWinners(params);

	    if (result > 0) {
	        return "redirect:/aplist.ev?eventNo=" + eventNo + "&eventType=" + eventType;
	    } else {
	        // 에러 페이지 처리
	        return "error/adminEventErrorPage";
	    }
	} */
	
	
	// ------------------------------------------ 파일 저장 메소드
	public String saveFile(MultipartFile upfile, HttpSession session) {
	    // 1. 원본파일명 얻어오기
	    String originName = upfile.getOriginalFilename();

	    // 2. 현재 시간을 기반으로 변경 파일명 생성
	    String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	    int ranNum = (int) (Math.random() * 90000 + 10000); // 5자리 랜덤수 생성
	    String ext = originName.substring(originName.lastIndexOf(".")); // 확장자 추출
	    String changeName = currentTime + ranNum + ext; // 변경된 파일명

	    // 3. 저장 경로 설정
	    String savePath = session.getServletContext().getRealPath("/resources/eventUploadFiles/");
	    
	    // System.out.println("파일이름 : file.getOriginName");
	    // System.out.println("파일경로 : filePath");

	    // 4. 파일 저장
	    try {
	        File targetFile = new File(savePath + changeName);
	        upfile.transferTo(targetFile); // 파일 저장
	        // System.out.println("File saved: " + targetFile.getAbsolutePath()); // 저장 경로 로그
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    

	    return changeName; // 변경된 파일명 반환
	}
	
	// 첨부파일 처리 Helper 메서드
	public List<EventAttachment> processNewFiles(MultipartFile[] newUpFiles, HttpSession session) {
	    List<EventAttachment> attachments = new ArrayList<>();
	    int fileLevel = 1; // 대표이미지: 1, 일반 파일: 2

	    for (MultipartFile newUpFile : newUpFiles) {
	        if (!newUpFile.isEmpty()) {
	            String changeName = saveFile(newUpFile, session); // 파일 저장 및 이름 변경
	            EventAttachment attachment = new EventAttachment();
	            attachment.setOriginName(newUpFile.getOriginalFilename());
	            attachment.setChangeName("/resources/eventUploadFiles/" + changeName);
	            attachment.setFilePath(changeName);
	            attachment.setFileLevel(fileLevel); // 대표이미지(1) 이후는 일반파일(2)
	            fileLevel = 2; // 이후로는 모두 일반 파일로 설정
	            attachments.add(attachment);
	        }
	    }
	    return attachments;
	}

	
	
	
}
