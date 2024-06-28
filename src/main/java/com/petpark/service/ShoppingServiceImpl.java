package com.petpark.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.ShoppingDTO;
import com.petpark.mapper.ShoppingMapper;

@Service
public class ShoppingServiceImpl implements ShoppingService {

	@Autowired
	private ShoppingMapper shoppingMapper;
	
	@Override
	public int insertProduct(String productImage, String productName, String productKind, int productPrice,
			int productCount, boolean productStatus, String productContent) {
		
		int result = shoppingMapper.insertProduct(productImage, productName, productKind, productPrice, productCount, productStatus, productContent);
		
		return result;
	}

	@Override
	public ArrayList<ShoppingDTO> selectProductKind() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<ShoppingDTO> selectProductAll() {

		ArrayList<ShoppingDTO> ShoppingList = new ArrayList<ShoppingDTO>();
		
		ShoppingList = shoppingMapper.selectProductAll();
		
		return ShoppingList;
	}

	@Override
	public ShoppingDTO selectProduct(String productId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteProduct(String productId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
