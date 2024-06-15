package com.petpark.service;

import java.util.Map;

import com.petpark.dto.BoardDTO;

public interface BoardService {

	// 글쓰기 데이터 저장
	public int boardWrite(String categories, String subject, String writer, String content);
	
	// 게시판 글 개수
	public int boardDataSize(String category);
	
	// 게시판 리스트 ( 페이지별 보일 데이터 / 카테고리별 / 검색어 있을 때 or 없을 때)
	public Map<String, Object> postsPerPage(String category, int currentPage, int boardSize, String searchInput);	
	
	// 게시판 view 페이지 데이터
	public BoardDTO boardView(String board_id);
	
	// 검색한 게시판 데이터 개수
	public int searchBoardDataSize(String category, String searchInput);
	
	// 게시글 삭제
	public int boardDelete(String board_id);
}
