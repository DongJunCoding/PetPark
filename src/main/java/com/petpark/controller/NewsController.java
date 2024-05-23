package com.petpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.dto.CrawlingDTO;
import com.petpark.service.NewsServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class NewsController {

	@Autowired
	private NewsServiceImpl newsServiceImpl;
	
	@GetMapping("/newsView.do")
	public ModelAndView newsView(HttpServletRequest req) {
		
		CrawlingDTO newsView = new CrawlingDTO();
		
		String newsId = req.getParameter("newsId");
		
		newsView = newsServiceImpl.newsView(newsId);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("newsView", newsView);
		
		mv.setViewName("news_view");
		
		return mv;
	}
}
