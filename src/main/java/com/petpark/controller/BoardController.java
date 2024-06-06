package com.petpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.service.MainPageServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class BoardController {

	@Autowired
	private MainPageServiceImpl mainPageServiceImpl;
	
	@GetMapping("/boardWrite.do")
	public ModelAndView board(HttpServletRequest req) throws Exception {
		
		ModelAndView mv = new ModelAndView();

		mv.setViewName("board_write");
		return mv;
	}
}
