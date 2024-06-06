package com.petpark.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.CrawlingDTO;
import com.petpark.dto.PageDTO;
import com.petpark.mapper.NewsInfoMapper;

@Service
public class NewsServiceImpl implements NewsService {

	@Autowired
	private NewsInfoMapper newsInfoMapper;
	
	@Override
	public CrawlingDTO newsView(String newsId) {
		
		CrawlingDTO newsView = new CrawlingDTO();
		
		newsView = newsInfoMapper.newsView(newsId);
		
		// 뉴스 게시글 조회수 증가
		newsInfoMapper.viewCount(newsId);
		
		return newsView;
		
	}



	// 카테고리별 뉴스 데이터의 개수를 가져온다.
	@Override
	public int newsDataSize(String category) throws Exception {
						
		int newsDataSize = newsInfoMapper.newsDataSize(category);
		
		return newsDataSize;
	}
	
	// 카테고리별 뉴스 데이터의 개수를 가져온다. ( 뉴스 리스트 검색시 )
	@Override
	public int searchNewsDataSize(String category, String searchInput) throws Exception {

		int newsDataSize = newsInfoMapper.searchNewsDataSize(category, searchInput);
		
		return newsDataSize;
	}
	
	// 뉴스 데이터와 페이징처리 후 Controller로 반환
	@Override
	public Map<String, Object> postsPerPage(String category, int currentPage, int newsSize, String searchInput) throws Exception {
		
		// 뉴스 리스트 검색을 한다면
		if(searchInput != null) {
			
			// PageDTO 생성자에 해당 뉴스 데이터 size와 현재 페이지를 넘겨주어 PageDTO에 페이지 설정을 한다.
			PageDTO page = new PageDTO(newsSize, currentPage);		
			
			// DB 에서 페이지 번호에 따라 가져올 데이터의 범위를 지정하기 위한 변수
			int startIndex = (currentPage - 1) * page.getPostPerPage();		
			int countIndex = page.getPostPerPage();
				
			// 해당 범위와 검색어에 대한 뉴스 데이터 가져옴
			ArrayList<CrawlingDTO> postsPerPage = new ArrayList<CrawlingDTO>();				
			postsPerPage = newsInfoMapper.searchPostsPerPage(category, searchInput, startIndex, countIndex);
						
			/* 
			 * AJAX 요청은 비동기적으로 데이터를 주고받기 때문에, 여러 데이터를 한 번에 받아오는 것이 효율적인데, 
			 * Map<String,Object>를 사용하면 한 번의 요청으로 필요한 모든 데이터를 받을 수 있다.
			 * 
			 * */			
			Map<String, Object> response = new HashMap<String, Object>();
			
			response.put("page", page);
			response.put("postsPerPage", postsPerPage);
			
			return response;
			
		}
		
		
		// 검색어 없을 때의 데이터
		PageDTO page = new PageDTO(newsSize, currentPage);		
		
		int startIndex = (currentPage - 1) * page.getPostPerPage();		
		int countIndex = page.getPostPerPage();
			
		ArrayList<CrawlingDTO> postsPerPage = new ArrayList<CrawlingDTO>();				
		postsPerPage = newsInfoMapper.postsPerPage(category, startIndex, countIndex);
						
		Map<String, Object> response = new HashMap<String, Object>();
		
		response.put("page", page);
		response.put("postsPerPage", postsPerPage);
		
		return response;
	}

}
