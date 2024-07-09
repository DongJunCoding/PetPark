package com.petpark.service;

import java.util.Map;

import com.petpark.dto.ShoppingDTO;

public interface ShoppingService {
	
	// 쇼핑 상품목록 넣기
	public int insertProduct(String productImage, String productName, String productKind, 
			int productPrice, int productCount, boolean productStatus, String productContent);
	
	// 쇼핑 데이터 보기
	public ShoppingDTO shoppingView(String shoppingId);
		
	// 상품 종류별 각 데이터의 총 개수
	public int shoppingDataSize(String productKind);

	// 페이지별 데이터 List ( 검색어가 없고, 각 선택한 카테고리별 전체 )
	public Map<String, Object> postsPerPage(String productKind, int currentPage, int shoppingSize, String searchInput);
		
	// 검색한 데이터 개수
	public int searchShoppingDataSize(String productKind, String searchInput);
	
	// 수량변동시 가격변동에 필요한 price 데이터 가져오기 
	public Map<String, Object> selectPrice(String shopping_id, String count);
}
