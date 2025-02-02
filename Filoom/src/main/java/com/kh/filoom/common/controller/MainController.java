package com.kh.filoom.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.filoom.common.model.service.AdminService;
import com.kh.filoom.movie.model.vo.Movie;

@Controller
public class MainController {

	@Autowired
	private AdminService adminService;
	
	@PostMapping("main.do")
	@ResponseBody
	public Map<String, Object> mainView(Model model) {
		
		// 영화의 영상 첫번쨰 메인
		ArrayList<Movie> list1 = adminService.selectMovieMainMovieList();
		
		// 메인페이지 두번째 영화 리뷰(텍스트) 보기
		//ArrayList<Movie> list2 = adminService.seletMovieReview();
		
		// 메인페이지 두번째 영화 리뷰(파일) 보기
		//ArrayList<Poster> list4 = adminService.selectMovieReviewPoster();
		
		// 메인페이지 하단 영화의 리스트 
		ArrayList<Movie> list3 = adminService.selectMovieMainList();
		
		Map<String, Object> result = new HashMap<>();
	    result.put("list1", list1);
	    result.put("list3", list3);
		
		 System.out.println(list1);
		// System.out.println(list3);
		
		return result;
	}
	
	 @GetMapping("/main")
    public String mainPage(Model model) {
        // 예시 데이터 생성
       
		// 영화의 영상 첫번쨰 메인
		ArrayList<Movie> list1 = adminService.selectMovieMainMovieList();
		
		// 메인페이지 두번째 영화 리뷰(텍스트) 보기
		//ArrayList<Movie> list2 = adminService.seletMovieReview();
		
		// 메인페이지 두번째 영화 리뷰(파일) 보기
		//ArrayList<Poster> list4 = adminService.selectMovieReviewPoster();
		
		// 메인페이지 하단 영화의 리스트 
		ArrayList<Movie> list3 = adminService.selectMovieMainList();
		
		//Map<String, Object> result = new HashMap<>();
	    //result.put("list1", list1);
	    //result.put("list3", list3);
		 
        // 데이터를 Model에 담아 JSP로 전달
        model.addAttribute("list1", list1);
        model.addAttribute("list3", list3);
        return "main"; // main.jsp로 이동
    }
	
	
}
