package com.petpark.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.CrawlingDTO;
import com.petpark.mapper.MainPageMapper;

/*
 * 홈페이지 메인페이지의 데이터들을 다루는 Service class
 * 메뉴에 뉴스 정보와 각 게시판들, 지도, 쇼핑 등 다양한 메뉴가 있으며 이 정보들에 대한 데이터들을 처리하는 class
 */

@Service
public class MainPageServiceImpl implements MainPageService {
	
	@Autowired
	private MainPageMapper mainPageMapper;

	@Override
	public ArrayList<CrawlingDTO> selectRecentNews() throws Exception { // 뉴스 최신 10개 데이터

		return mainPageMapper.selectRecentNews();
	}

	
	@Override
	public ArrayList<CrawlingDTO> selectVeterinaryField() throws Exception {
		
		ArrayList<CrawlingDTO> selectVeterinaryFields = new ArrayList<CrawlingDTO>();
		
		selectVeterinaryFields = mainPageMapper.selectVeterinaryField();
		
		return selectVeterinaryFields;
	}

}
