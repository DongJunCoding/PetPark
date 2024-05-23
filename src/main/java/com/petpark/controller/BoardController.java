package com.petpark.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.dto.CrawlingDTO;
import com.petpark.service.MainPageServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class BoardController {

	@Autowired
	private MainPageServiceImpl mainPageServiceImpl;
	
	@GetMapping("/board.do")
	public ModelAndView board(HttpServletRequest req) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		ArrayList<CrawlingDTO> news = new ArrayList<CrawlingDTO>();
		
		news = mainPageServiceImpl.selectRecentNews();
				
		mv.addObject("news",news);
		mv.setViewName("board_view");
		return mv;
	}
}
