package com.petpark.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.dto.BoardDTO;
import com.petpark.dto.CrawlingDTO;
import com.petpark.service.CrawlingServiceImpl;
import com.petpark.service.MainPageServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MainController {
	
	@Autowired
	private CrawlingServiceImpl crawling;
	
	@Autowired
	private MainPageServiceImpl mainPageServiceImpl;
	
	@Value("${kakao-javaScript-API-KEY}")
	private String kakaoMapAPI;

	@RequestMapping("/petpark.do")
	public ModelAndView main(HttpServletRequest req) throws Exception {
		
//		crawling.newsCrawling(); // 메인페이지에 접속할 때마다 크롤링이 진행
		
		ArrayList<CrawlingDTO> news = mainPageServiceImpl.selectRecentNews(); // 뉴스 데이터 최신 10개
		ArrayList<BoardDTO> boards = mainPageServiceImpl.selectRecentBoard();
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("news", news);
		mv.addObject("boards", boards);
		mv.setViewName("main");
		return mv;
	}		
}
