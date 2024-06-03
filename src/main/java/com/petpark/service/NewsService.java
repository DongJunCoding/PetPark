package com.petpark.service;

import java.util.Map;

import com.petpark.dto.CrawlingDTO;

public interface NewsService {

	public CrawlingDTO newsView(String newsId);
	
	/* 카테고리별 뉴스 데이터 개수 ( 페이징 용도에 사용 ) */
	public int newsDataSize(String category) throws Exception;
	
	/* 카테고리별 뉴스 데이터 개수 ( 페이징 용도에 사용 / 검색 데이터 ) */
	public int searchNewsDataSize(String category, String searchInput) throws Exception;
	
	/* 페이지당 보일 뉴스 데이터 */
	public Map<String, Object> postsPerPage(String category, int startIndex, int countIndex, String searchInput) throws Exception;
	
}
