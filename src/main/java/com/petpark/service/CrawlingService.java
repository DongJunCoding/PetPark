package com.petpark.service;

public interface CrawlingService {

	/* 크롤링 데이터 DB에 넣기 */
	void newsCrawling() throws Exception; // 산업, 정책, 사회, 문화, 동물복지, 수의계에 대한 뉴스 데이터 크롤링
	
}
