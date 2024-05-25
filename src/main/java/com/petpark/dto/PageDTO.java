package com.petpark.dto;

import lombok.Data;

@Data
public class PageDTO {

	private static final int postPerPage = 20; // 한 페이지에 보일 게시글 수
	
	private int totalPost; // 전체 게시글
	private int totalPages; // 전체 페이지
	private int currentPage; // 현재 페이지
	private int startPage; // 시작 페이지
	private int endPage; // 끝 페이지
	
	public PageDTO(int totalPost, int currentPage) {
		this.totalPost = totalPost;
		this.currentPage = currentPage;
				
		totalPages = (totalPost - 1) / postPerPage + 1; 
		startPage = currentPage - (currentPage - 1) % postPerPage;
		endPage = currentPage - (currentPage - 1) % postPerPage + postPerPage + 1;
		
	}
}
