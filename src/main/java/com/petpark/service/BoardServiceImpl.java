package com.petpark.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.petpark.dto.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {

	// 게시판 글 쓰기
	@Override
	public int boardWrite(String categories, String subject, String writer, String content) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 게시판 카테고리별 데이터 개수
	@Override
	public int boardDatraSize(String category) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 게시판 페이지당 데이터
	@Override
	public ArrayList<BoardDTO> postsPerPage(String category, int startIndex, int countIndex) {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 게시판 게시글 view 페이지
	@Override
	public BoardDTO boardView(String board_id) {
		// TODO Auto-generated method stub
		return null;
	}

	// 게시글 조회수 증가(이건 view로 들어갈거임)
	@Override
	public void viewCount(String board_id) {
		// TODO Auto-generated method stub

	}

	// 검색한 게시판 게시글 데이터 개수
	@Override
	public int searchBoardDataSize(String category, String searchInput) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 검색한 게시글 데이터
	@Override
	public ArrayList<BoardDTO> searchPostsPerPage(String category, String searchInput, int startIndex, int countIndex) {
		// TODO Auto-generated method stub
		return null;
	}

}
