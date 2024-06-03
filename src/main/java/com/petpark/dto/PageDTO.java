package com.petpark.dto;

import lombok.Data;

@Data
public class PageDTO {

	private static final int postPerPage = 10; // 한 페이지에 보일 게시글 수
	private static final int blockPerPage = 5; // 페이지 번호 개수 보이기 ( ex : 1 2 3 4 5 )
	
	private int totalPost; // 전체 게시글
	private int totalPages; // 전체 페이지
	private int currentPage; // 현재 페이지
	private int startPage; // 시작 페이지
	private int endPage; // 끝 페이지
	
	public PageDTO(int totalPost, int currentPage) {
		this.totalPost = totalPost;
		this.currentPage = currentPage;
				
		totalPages = (totalPost - 1) / postPerPage + 1; 
		startPage = currentPage - (currentPage - 1) % blockPerPage;
		endPage = currentPage - (currentPage - 1) % blockPerPage + blockPerPage - 1;
		
		if(endPage > totalPages) {
			endPage = totalPages;
		}

		System.out.println("totalPost : " + totalPost);
		System.out.println("totalPages : " + totalPages);
		System.out.println("currentPage : " + currentPage);
		System.out.println("startPage : " + startPage);
		System.out.println("endPage : " + endPage);
	
	}
	
	public int getPostPerPage() {
		return postPerPage;
	}
	
	public int getBlockPerPage() {
		return blockPerPage;
	}
	
}
