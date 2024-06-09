package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	
	// 글쓰기 데이터 저장
	public int boardWrite(String categories, String subject, String writer, String content);
	
	// 게시판 글 개수
	public int boardDataSize(String category);
	
	// 게시판 리스트 ( 페이지별 보일 데이터 / 카테고리별 / 검색어 없을 때)
	public ArrayList<BoardDTO> postsPerPage(String category, int startIndex, int countIndex);	
	
	// 게시판 view 페이지 데이터
	public BoardDTO boardView(String board_id);
	
	// 게시판 조회수 증가
	public void viewCount(String board_id);
	
	// 검색한 게시판 데이터 개수
	public int searchBoardDataSize(String category, String searchInput);
	
	// 검색한 게시판 데이터 리스트
	public ArrayList<BoardDTO> searchPostsPerPage(String category, String searchInput, int startIndex, int countIndex);
	
	
}
