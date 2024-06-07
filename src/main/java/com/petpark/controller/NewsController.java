package com.petpark.controller;

import java.util.HashMap;
import java.util.Map;

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
		
		String newsId = req.getParameter("news_id");
		
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
	public Map<String, Object> newsList(HttpServletRequest req) {
	
		// 뉴스별 카테고리를 눌렀을 때 초기값 1페이지로 설정 ( AJAX로 받아올 때 이미 1을 받아오기는 한다. )
		int currentPage = 1;
		
		// AJAX의 data로 보낸 값(페이지 번호)을 받아온다.
		String currentPageStr = req.getParameter("currentPage");
		
		// 검색창에 입력한 데이터를 가져온다.
		String searchInput = req.getParameter("searchInput");
		
		// 카테고리별로 뉴스 데이터가 필요하여 카테고리를 가져옴
		String category = req.getParameter("category");
		
		// 뉴스 데이터 개수
		int newsSize = 0;
				
		// 페이지를 누르지 않았을 때 초기값이 null이여서 에러가 나기때문에 if문으로 처리, String이라서 문자열로 비교를 해야할 것 같지만 request로 받아온 것이라 비교연산자로 처리
		if(currentPageStr != null) {
			
			// AJAX로 받아온 현재 페이지 번호를 int형으로 변환 ( 페이지 번호 설정을 INT로 하였음 )
			currentPage = Integer.parseInt(currentPageStr);
			
		}
							
		// 뉴스 리스트 검색을 한다면
		if(searchInput != null) {
			// 페이징 설정을 위해 해당 카테고리의 뉴스 데이터 size를 가져옴
			newsSize = newsServiceImpl.searchNewsDataSize(category, searchInput);	
		} else if (searchInput == null){
			// 페이징 설정을 위해 해당 카테고리의 뉴스 데이터 size를 가져옴
			newsSize = newsServiceImpl.newsDataSize(category);	
		}
		
		
		// 데이터들을 json형태로 받아오기 위해 Map 생성
		Map<String, Object> response = new HashMap<String, Object>();
		
		response = newsServiceImpl.postsPerPage(category, currentPage, newsSize, searchInput);
		
		return response;
	}
}
