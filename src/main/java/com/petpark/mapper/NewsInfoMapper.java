package com.petpark.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.CrawlingDTO;

@Mapper
public interface NewsInfoMapper {

	// 접속한 뉴스 게시글 데이터
	CrawlingDTO newsView(String newsId);
}
