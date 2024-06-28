package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.ShoppingDTO;

@Mapper
public interface ShoppingMapper {
	
	// 쇼핑 상품목록 넣기
	public int insertProduct(String product_image, String product_name, String product_kind, 
			int product_price, int product_count, boolean product_status, String product_content);
	
	// 쇼핑 상품 리스트
	public ArrayList<ShoppingDTO> selectProductAll();
}
