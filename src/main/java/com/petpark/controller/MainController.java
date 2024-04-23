package com.petpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.service.CrawlingServiceImpl;

@RestController
public class MainController {
	
	@Autowired
	private CrawlingServiceImpl crawling;
	
	@GetMapping("petpark.do")
	public ModelAndView main() throws Exception {
		crawling.industryList();
		ModelAndView mv = new ModelAndView(); 
		mv.setViewName("main");
		return mv;
	}
}
