package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.CrawlingDTO;

@Mapper
public interface NewsInfoMapper {

	/* 접속한 뉴스 게시글 데이터 */
	public CrawlingDTO newsView(String newsId);
	
	/* 조회수 증가 */
	public void viewCount(String newsId);
	
	/* 수의계 뉴스 데이터 개수 */
	public int newsDataSize(String category);
	
	/* 검색한 수의계 뉴스 데이터 개수 */
	public int searchNewsDataSize(String category, String searchInput);
		
	/* 페이지당 보일 뉴스 데이터 */
	public ArrayList<CrawlingDTO> postsPerPage(String category, int startIndex, int countIndex);
	
	/* 검색한 페이지당 보일 뉴스 데이터 */
	public ArrayList<CrawlingDTO> searchPostsPerPage(String category, String searchInput, int startIndex, int countIndex);
	
	
}
