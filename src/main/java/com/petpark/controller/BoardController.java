package com.petpark.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petpark.dto.BoardDTO;
import com.petpark.service.BoardServiceImpl;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class BoardController {

	@Autowired
	private BoardServiceImpl boardServiceImpl;

	// 게시판 글쓰기 페이지
	@GetMapping("/boardWrite.do")
	public ModelAndView boardWritePage(HttpServletRequest req) {

		ModelAndView mv = new ModelAndView();

		mv.setViewName("board_write");

		return mv;
	}

	// 게시판 글작성 완료시 데이터 넘어온 후 처리
	@PostMapping("/boardWriteOk.do")
	public ModelAndView boardWrite(HttpServletRequest req) {

		String category = req.getParameter("category");
		String subject = req.getParameter("subject");
		String writer = req.getParameter("nickname");
		String content = req.getParameter("content");
		
		int result = boardServiceImpl.boardWrite(category, subject, writer, content);
	
		ModelAndView mv = new ModelAndView();

		mv.addObject("result", result);
		mv.setViewName("board_write_ok");
		return mv;
	}
	
	// 게시판 게시글 List
	@ResponseBody
	@GetMapping("/boardList.do")
	public Map<String, Object> boardList(HttpServletRequest req) {
	
		// 뉴스별 카테고리를 눌렀을 때 초기값 1페이지로 설정 ( AJAX로 받아올 때 이미 1을 받아오기는 한다. )
		int currentPage = 1;
		
		// AJAX의 data로 보낸 값(페이지 번호)을 받아온다.
		String currentPageStr = req.getParameter("currentPage");
		
		// 검색창에 입력한 데이터를 가져온다.
		String searchInput = req.getParameter("searchInput");
		
		// 카테고리별로 뉴스 데이터가 필요하여 카테고리를 가져옴
		String category = req.getParameter("category");
		
		
		// 뉴스 데이터 개수
		int boardSize = 0;
				
		// 페이지를 누르지 않았을 때 초기값이 null이여서 에러가 나기때문에 if문으로 처리, String이라서 문자열로 비교를 해야할 것 같지만 request로 받아온 것이라 비교연산자로 처리
		if(currentPageStr != null) {
			
			// AJAX로 받아온 현재 페이지 번호를 int형으로 변환 ( 페이지 번호 설정을 INT로 하였음 )
			currentPage = Integer.parseInt(currentPageStr);
			
		}
							
		System.out.println();
		System.out.println("currentPage : " + currentPage);
		System.out.println("searchInput : " + searchInput);
		System.out.println("category : " + category);
		
	
		// 뉴스 리스트 검색을 한다면
		if(searchInput != null) {			
			// 페이징 설정을 위해 해당 카테고리의 뉴스 데이터 size를 가져옴
			boardSize = boardServiceImpl.searchBoardDataSize(category, searchInput);				
		} else if (searchInput == null){		
			// 페이징 설정을 위해 해당 카테고리의 뉴스 데이터 size를 가져옴
			boardSize = boardServiceImpl.boardDataSize(category);	
		}
		
		System.out.println("boardSize : " + boardSize);
		System.out.println();
				
		// 데이터들을 json형태로 받아오기 위해 Map 생성
		Map<String, Object> response = new HashMap<String, Object>();
		
		response = boardServiceImpl.postsPerPage(category, currentPage, boardSize, searchInput);
		
		return response;
	}
	

	// 게시판 view 페이지
	@GetMapping("/boardView.do")
	public ModelAndView boardView(HttpServletRequest req) {
		
		BoardDTO boardView = new BoardDTO();
		
		String boardId = req.getParameter("board_id");
		
		boardView = boardServiceImpl.boardView(boardId);
		
//		String boardContent = boardView.getContent();
//		
//		int boardLength = boardContent.length();
//		
//		System.out.println("boardLength : " + boardLength);
//		System.out.println("DataSize : " + boardLength * 2);
		
		
		ModelAndView mv = new ModelAndView();

		mv.addObject("boardView", boardView);
		mv.setViewName("board_view");
		
		return mv;
	}
	
	// 게시글 삭제
	@GetMapping("/boardDelete.do")
	public String boardDelete(HttpServletRequest req) {
		
		String boardId = req.getParameter("board_id");
		
		System.out.println("board_id : " + boardId);
		
		int result = boardServiceImpl.boardDelete(boardId);
		
		System.out.println("result : " + result);
//
//		ModelAndView mv = new ModelAndView();
//		
//		mv.addObject("result", result);
//		mv.setViewName("board_delete_ok");
		
		return "/petpark.do";
	}
}
