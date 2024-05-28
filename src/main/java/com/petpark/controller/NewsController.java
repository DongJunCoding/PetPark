package com.petpark.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.dto.CrawlingDTO;
import com.petpark.dto.PageDTO;
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
	
	/* 
	 * AJAX를 사용하여 페이징 처리와 페이지에 따른 데이터를 보여주기 위해 JSON형태로 값을 반환 
	 * json으로 데이터를 컨트롤하기 위해 Map 사용
	 * 
	 * */
	@GetMapping("/newsList.do")
	public Map<String, Object> newsList(HttpServletRequest req) throws Exception {
		
		ArrayList<CrawlingDTO> veterinaryFields = newsServiceImpl.selectVeterinaryField(); // 수의계 뉴스 데이터
		
		int currentPage = 1;
		
		// ajax의 data로 보낸 값(페이지 번호)을 받아온다.
		String currentPageStr = req.getParameter("currentPage");
		
		// 페이지를 누르지 않았을 때 초기값이 null이여서 에러가 나기때문에 if문으로 처리, String이라서 문자열로 비교를 해야할 것 같지만 request로 받아온 것이라 비교연산자로 처리
		if(currentPageStr != null) {
			currentPage = Integer.parseInt(currentPageStr);
		}
		
		System.out.println("currentPage : " + currentPage);
		
		PageDTO page = new PageDTO(veterinaryFields.size(), currentPage);		
		
		Map<String, Object> response = new HashMap<>();
		
		response.put("page", page);
		response.put("veterinaryFields", veterinaryFields);
		
		return response;
	}
}
