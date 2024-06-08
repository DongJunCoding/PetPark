package com.petpark.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.service.BoardServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class BoardController {
	
	@Autowired
	private BoardServiceImpl boardServiceImpl;
	
	// 게시판 글쓰기 페이지
	@GetMapping("/boardWrite.do")
	public ModelAndView boardWritePage(HttpServletRequest req) throws Exception {
		
		ModelAndView mv = new ModelAndView();

		mv.setViewName("board_write");
		
		return mv;
	}
	
	// 게시판 글작성 완료시 데이터 넘어온 후 처리
	@PostMapping("boardWriteOk.do")
	public int boardWrite(HttpServletRequest req) throws Exception {
		
		String category = req.getParameter("category");
		String subject = req.getParameter("writer");
		String writer = req.getParameter("nickname");
		String content = req.getParameter("content");
		
		int result = boardServiceImpl.boardWrite(category, subject, writer, content);
		
		System.out.println("category : " + category);
		System.out.println("subject : " + subject);
		System.out.println("nickname : " + writer);
		System.out.println("content : " + content);
		
		return 0;		
	}
	
	// 게시판 view 페이지
	@GetMapping("/boardView.do")
	public ModelAndView boardView() throws Exception {
				
		ModelAndView mv = new ModelAndView();
				
		mv.setViewName("board_view");
		return mv;
	}
}
