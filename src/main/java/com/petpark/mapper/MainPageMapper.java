package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.CrawlingDTO;

@Mapper
public interface MainPageMapper {

	/* News 데이터 최신 10개 리스트 가져오기 */
	ArrayList<CrawlingDTO> selectRecentNews() throws Exception;
	
	/* 수의계 뉴스 데이터 */
	ArrayList<CrawlingDTO> selectVeterinaryField() throws Exception;
	
}
