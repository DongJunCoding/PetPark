package com.petpark.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.PageDTO;
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
		
		ShoppingDTO shoppingView = new ShoppingDTO();
		
		shoppingView = shoppingMapper.shoppingView(shoppingId);
		
		shoppingMapper.viewCount(shoppingId);
		
		return shoppingView;
	}

	@Override
	public int shoppingDataSize(String productKind) {
		
		// 게시판 전체 category일때
		if(productKind.equals("all_product")) {
			
			// 데이터 전체 개수는 매개변수가 필요 없음
			int shoppingDataSizeAll = shoppingMapper.shoppingDataSizeAll();
			
			return shoppingDataSizeAll;
			
		}
				
		int shoppingDataSize = shoppingMapper.shoppingDataSize(productKind);
		
		return shoppingDataSize;
	}

	@Override
	public Map<String, Object> postsPerPage(String productKind, int currentPage, int shoppingSize, String searchInput) {

		// 뉴스 리스트 검색을 한다면
		if (searchInput != null) {

			// PageDTO 생성자에 해당 뉴스 데이터 size와 현재 페이지를 넘겨주어 PageDTO에 페이지 설정을 한다.
			PageDTO page = new PageDTO(shoppingSize, currentPage);

			// DB 에서 페이지 번호에 따라 가져올 데이터의 범위를 지정하기 위한 변수
			int startIndex = (currentPage - 1) * page.getPostPerPage();
			int countIndex = page.getPostPerPage();
			
			// 해당 범위와 검색어에 대한 뉴스 데이터 가져옴
			ArrayList<ShoppingDTO> postsPerPage = new ArrayList<ShoppingDTO>();
			
			// category가 전체 게시판일 때
			if(productKind.equals("all_product")) {
				// true면 커뮤니티 게시판 데이터 리스트 전체를 가져온다.
				postsPerPage = shoppingMapper.searchPostsPerPageAll(searchInput, startIndex, countIndex);
			} else {				
				postsPerPage = shoppingMapper.searchPostsPerPage(productKind, searchInput, startIndex, countIndex);
			}

			System.out.println("postsPerPage : " + postsPerPage.size());
			/*
			 * AJAX 요청은 비동기적으로 데이터를 주고받기 때문에, 여러 데이터를 한 번에 받아오는 것이 효율적인데,
			 * Map<String,Object>를 사용하면 한 번의 요청으로 필요한 모든 데이터를 받을 수 있다.
			 * 
			 */
			Map<String, Object> response = new HashMap<String, Object>();

			response.put("page", page);
			response.put("postsPerPage", postsPerPage);

			return response;
		}
		
		// 검색어 없을 때의 데이터
		PageDTO page = new PageDTO(shoppingSize, currentPage);

		int startIndex = (currentPage - 1) * page.getPostPerPage();
		int countIndex = page.getPostPerPage();

		ArrayList<ShoppingDTO> postsPerPage = new ArrayList<ShoppingDTO>();
		
		if(productKind.equals("all_product")) {
			postsPerPage = shoppingMapper.postsPerPageAll(startIndex, countIndex);
		} else {
			postsPerPage = shoppingMapper.postsPerPage(productKind, startIndex, countIndex);			
		}
	
		Map<String, Object> response = new HashMap<String, Object>();

		response.put("page", page);
		response.put("postsPerPage", postsPerPage);

		return response;
	}

	@Override
	public int searchShoppingDataSize(String productKind, String searchInput) {
		if(productKind.equals("all_product")) {			
			int searchBoardDataSizeAll = shoppingMapper.searchShoppingDataSizeAll(searchInput);
			return searchBoardDataSizeAll;			
		} else {			
			int searchBoardDataSize = shoppingMapper.searchShoppingDataSize(productKind, searchInput);			
			return searchBoardDataSize;			
		}
	}
}
