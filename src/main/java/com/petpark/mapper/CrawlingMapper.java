package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.CrawlingDTO;

@Mapper
public interface CrawlingMapper {
	
	/* Crawling 데이터 넣기 */
	int industryList(CrawlingDTO crawlingDTO) throws Exception; // 산업 뉴스 정보	
	ArrayList<CrawlingDTO> policyList () throws Exception; // 정책 뉴스 정보	
	ArrayList<CrawlingDTO> societyList () throws Exception; // 사회 뉴스 정보	
	ArrayList<CrawlingDTO> cultureList () throws Exception; // 문화 뉴스 정보	
	ArrayList<CrawlingDTO> welfareList () throws Exception; // 동물복지 뉴스 정보	
	ArrayList<CrawlingDTO> veterinary_fieldList () throws Exception; // 수의계 뉴스 정보
	
	/* 크롤링 데이터 DB에서 가져오기 */
	ArrayList<CrawlingDTO> selectNews() throws Exception; // 전체 리스트 가져오기
	
}
