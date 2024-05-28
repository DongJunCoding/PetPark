package com.petpark.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.CrawlingDTO;
import com.petpark.mapper.NewsInfoMapper;

@Service
public class NewsServiceImpl implements NewsService {

	@Autowired
	private NewsInfoMapper newsInfoMapper;
	
	@Override
	public CrawlingDTO newsView(String newsId) {
		
		CrawlingDTO newsView = new CrawlingDTO();
		
		newsView = newsInfoMapper.newsView(newsId);
		
		return newsView;
		
	}

	
	@Override
	public ArrayList<CrawlingDTO> selectVeterinaryField() throws Exception {
		
		ArrayList<CrawlingDTO> selectVeterinaryFields = new ArrayList<CrawlingDTO>();
		
		selectVeterinaryFields = newsInfoMapper.selectVeterinaryField();
		
		return selectVeterinaryFields;
	}

}
