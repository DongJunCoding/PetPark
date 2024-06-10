package com.petpark.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.BoardDTO;
import com.petpark.dto.PageDTO;
import com.petpark.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	// Mybatis와 연결되어있는 Mapper 의존성 주입
	@Autowired
	private BoardMapper boardMapper;

	// 게시판 글 쓰기
	@Override
	public int boardWrite(String categories, String subject, String writer, String content) {

		// Mybatis의 insert문과 연결되어있는 Mapper클래스의 메소드 호출하여 매개변수 값(글쓰기 데이터)을 넘겨주고, 반환값으로 성공 or 실패 여부 확인
		int result = boardMapper.boardWrite(categories, subject, writer, content);

		return result;
	}

	// 게시판 카테고리별 데이터 개수
	@Override
	public int boardDataSize(String category) {
		
		// 게시판 전체 category일때
		if(category.equals("all_board")) {
			
			// 데이터 전체 개수는 매개변수가 필요 없음
			int boardDataSizeAll = boardMapper.boardDataSizeAll();
			
			return boardDataSizeAll;
			
		}
				
		int boardDataSize = boardMapper.boardDataSize(category);
		
		return boardDataSize;
	}

	// 게시판 페이지당 데이터
	@Override
	public Map<String, Object> postsPerPage(String category, int currentPage, int boardSize, String searchInput) {
		// 뉴스 리스트 검색을 한다면
		if (searchInput != null) {

			// PageDTO 생성자에 해당 뉴스 데이터 size와 현재 페이지를 넘겨주어 PageDTO에 페이지 설정을 한다.
			PageDTO page = new PageDTO(boardSize, currentPage);

			// DB 에서 페이지 번호에 따라 가져올 데이터의 범위를 지정하기 위한 변수
			int startIndex = (currentPage - 1) * page.getPostPerPage();
			int countIndex = page.getPostPerPage();

			// 해당 범위와 검색어에 대한 뉴스 데이터 가져옴
			ArrayList<BoardDTO> postsPerPage = new ArrayList<BoardDTO>();
			
			// category가 전체 게시판일 때
			if(category.equals("all_board")) {
				// true면 커뮤니티 게시판 데이터 리스트 전체를 가져온다.
				postsPerPage = boardMapper.searchPostsPerPageAll(searchInput, startIndex, countIndex);
			} else {				
				postsPerPage = boardMapper.searchPostsPerPage(category, searchInput, startIndex, countIndex);
			}

			/*
			 * AJAX 요청은 비동기적으로 데이터를 주고받기 때문에, 여러 데이터를 한 번에 받아오는 것이 효율적인데,
			 * Map<String,Object>를 사용하면 한 번의 요청으로 필요한 모든 데이터를 받을 수 있다.
			 * 
			 */
			Map<String, Object> response = new HashMap<String, Object>();

			response.put("page", page);
			response.put("postsPerPage", postsPerPage);

			return response;

		}

		// 검색어 없을 때의 데이터
		PageDTO page = new PageDTO(boardSize, currentPage);

		int startIndex = (currentPage - 1) * page.getPostPerPage();
		int countIndex = page.getPostPerPage();

		ArrayList<BoardDTO> postsPerPage = new ArrayList<BoardDTO>();
		
		if(category.equals("all_board")) {
			postsPerPage = boardMapper.postsPerPageAll(startIndex, countIndex);
		} else {
			postsPerPage = boardMapper.postsPerPage(category, startIndex, countIndex);			
		}
		

		Map<String, Object> response = new HashMap<String, Object>();

		response.put("page", page);
		response.put("postsPerPage", postsPerPage);

		return response;

	}

	// 게시판 게시글 view 페이지
	@Override
	public BoardDTO boardView(String board_id) {
		
		BoardDTO boardView = new BoardDTO();
		
		boardView = boardMapper.boardView(board_id);
		
		boardMapper.viewCount(board_id);
			
		return 	boardView;
	}

	// 검색한 게시판 게시글 데이터 개수
	@Override
	public int searchBoardDataSize(String category, String searchInput) {
		
		if(category.equals("all_board")) {			
			int searchBoardDataSizeAll = boardMapper.searchBoardDataSizeAll(searchInput);
			return searchBoardDataSizeAll;			
		} else {			
			int searchBoardDataSize = boardMapper.searchBoardDataSize(category, searchInput);			
			return searchBoardDataSize;			
		}
	}

}
