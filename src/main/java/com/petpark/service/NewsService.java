package com.petpark.service;

import java.util.ArrayList;

import com.petpark.dto.CrawlingDTO;

public interface NewsService {

	public CrawlingDTO newsView(String newsId);
	
	/* 카테고리별 뉴스 데이터 개수 ( 페이징 용도에 사용 ) */
	int newsDataSize(String category) throws Exception;
	
	/* 페이지당 보일 뉴스 데이터 */
	ArrayList<CrawlingDTO> postsPerPage(String category, int startIndex, int endIndex) throws Exception;
	
}
