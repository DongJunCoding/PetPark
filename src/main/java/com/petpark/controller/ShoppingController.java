package com.petpark.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ShoppingController {

	@GetMapping("/shoppingWrite.do")
	public ModelAndView shoppingView(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("shopping/shopping_write");
		return mv;
	}
	
}
