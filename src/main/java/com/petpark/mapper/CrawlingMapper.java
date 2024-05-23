package com.petpark.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.CrawlingDTO;

@Mapper
public interface CrawlingMapper {
	
	/* Crawling 데이터 넣기 */
	int newsCrawling(CrawlingDTO crawlingDTO) throws Exception; // 산업 뉴스 정보	
	
	/* subject의 카운트 유무로 중복데이터 처리 = 카운트가 있을시 DB에 저장 안되게 하기위함 */
	int newsCount(String subject) throws Exception;
}
