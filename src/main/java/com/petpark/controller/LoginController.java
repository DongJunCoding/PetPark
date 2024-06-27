package com.petpark.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

	@GetMapping("login.do")
	public ModelAndView login() {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/login");
		
		return mv;
	}
	
	@GetMapping("signup.do")
	public ModelAndView signup() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("user/signup");
		return mv;
	}
}
