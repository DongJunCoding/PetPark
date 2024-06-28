package com.petpark.service;

import java.util.ArrayList;

import com.petpark.dto.ShoppingDTO;

public interface ShoppingService {
	
	// 쇼핑 상품목록 넣기
	public int insertProduct(String productImage, String productName, String productKind, 
			int productPrice, int productCount, boolean productStatus, String productContent);
	
	// 쇼핑 상품 정보 전체 가져오기
	public ArrayList<ShoppingDTO> selectProductAll();
	
	// 카테고리별 쇼핑 상품 리스트
	public ArrayList<ShoppingDTO> selectProductKind();
	
	// 클릭한 상품 보기
	public ShoppingDTO selectProduct(String productId);
	
	// 상품 삭제
	public int deleteProduct(String productId);

}
