package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.ShoppingDTO;

@Mapper
public interface ShoppingMapper {
	
	// 쇼핑 상품목록 넣기
	public int insertProduct(String product_image, String product_name, String product_kind, 
			int product_price, int product_count, boolean product_status, String product_content);
	
	// 쇼핑 데이터 보기
	public ShoppingDTO shoppingView(String shoppingId);
	
	// 게시판 조회수 증가
	public void viewCount(String shopping_id);
	
	// 전체 데이터 개수
	public int shoppingDataSizeAll();
	
	// 상품 종류별 각 데이터의 총 개수
	public int shoppingDataSize(String productKind);

	// 페이지별 데이터 List ( 검색어가 없고, 각 선택한 카테고리별 전체 )
	public ArrayList<ShoppingDTO> postsPerPage(String productKind, int startIndex, int countIndex);
	
	// 쇼핑 전체 카테고리 데이터 List (검색어 없음)
	public ArrayList<ShoppingDTO> postsPerPageAll(int startIndex, int countIndex);
	
	// 검색한 데이터 개수
	public int searchShoppingDataSize(String productKind, String searchInput);
	
	// 검색한 데이터 list
	public ArrayList<ShoppingDTO> searchPostsPerPage(String productKind, String searchInput, int startIndex, int countIndex);
	
	// 검색한 데이터 전체 카테고리 개수
	public int searchShoppingDataSizeAll(String searchInput);
	
	// 쇼핑 전체 카테고리에서 검색한 데이터
	public ArrayList<ShoppingDTO> searchPostsPerPageAll(String searchInput, int startIndex, int countIndex);
}
