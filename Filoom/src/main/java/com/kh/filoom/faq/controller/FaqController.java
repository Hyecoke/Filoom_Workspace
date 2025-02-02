package com.kh.filoom.faq.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FaqController {

	@GetMapping("list.fa")
	public String selectList() {
		
		return "faq/FaqListView";
	}
	
}
