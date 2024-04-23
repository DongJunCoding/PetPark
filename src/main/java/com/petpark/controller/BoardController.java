package com.petpark.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class BoardController {

	@RequestMapping("board.do")
	public ModelAndView board() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board_view");
		return mv;
	}
}
