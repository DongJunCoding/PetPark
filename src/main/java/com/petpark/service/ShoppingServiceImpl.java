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
	public ShoppingDTO shoppingView(String shoppingId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int shoppingDataSizeAll() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int shoppingDataSize(String productKind) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<ShoppingDTO> postsPerPage(String productKind, int startIndex, int countInedex) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<ShoppingDTO> postsPerPageAll(int startIndex, int countIndex) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int searchShoppingDataSize(String shoppingKind, String searchInput) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<ShoppingDTO> searchPostsPerPage(String shoppingKind, String searchInput, int startIndex,
			int countIndex) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int searchShoppingDataSizeAll(String searchInput) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<ShoppingDTO> searchPostsPerPageAll(String searchInput, int startIndex, int countIndex) {
		// TODO Auto-generated method stub
		return null;
	}

	

}
