package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.CrawlingDTO;

@Mapper
public interface NewsInfoMapper {

	// 접속한 뉴스 게시글 데이터
	CrawlingDTO newsView(String newsId);
	
	/* 수의계 뉴스 데이터 */
	ArrayList<CrawlingDTO> selectVeterinaryField() throws Exception;
}
