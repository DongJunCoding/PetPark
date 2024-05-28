package com.petpark.service;

import java.util.ArrayList;

import com.petpark.dto.CrawlingDTO;

public interface NewsService {

	public CrawlingDTO newsView(String newsId);
	
	/* 수의계 뉴스 데이터 */
	ArrayList<CrawlingDTO> selectVeterinaryField() throws Exception;
	
}
