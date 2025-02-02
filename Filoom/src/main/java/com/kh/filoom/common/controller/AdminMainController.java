package com.kh.filoom.common.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.filoom.common.model.service.AdminService;
import com.kh.filoom.common.model.vo.Chart;

@Controller
public class AdminMainController {

	@Autowired
	private AdminService adminService;
	
	@GetMapping("ad.li")
	public String AdminListView(Model model) {
		
		// 회원 나이 및 가입 날짜
		Chart ch1 
			= adminService.adminListView();
		
		// 등록된 영화 개수
		Chart ch2
			= adminService.adminMovieList();
		
		// 상영중인 영화 개수
		Chart ch3
			= adminService.adminPlayingMovieList();
		
		// 회원 수
		Chart ch4
			= adminService.adminMemberCount();
		
		// 영화 월별 이익
		Chart ch5
			= adminService.adminTotalInput();
		
		// 영화 장르
		Chart ch6 
			= adminService.adminGenreCount();
		
		// 영화 당일 이익
		Chart ch7
			= adminService.adminTodayInput();
		
		
		model.addAttribute("ch1", ch1);
		model.addAttribute("ch2", ch2);
		model.addAttribute("ch3", ch3);
		model.addAttribute("ch4", ch4);
		model.addAttribute("ch5", ch5);
		model.addAttribute("ch6", ch6);
		model.addAttribute("ch7", ch7);
		
		System.out.println(ch1);
		//System.out.println(ch2);
		//System.out.println(ch3);
		//System.out.println(ch4);
		//System.out.println(ch5);
		//System.out.println(ch6);
		
		return "admin/adminMain";
	}
	
}
