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
	public int newsDataSize(String category) throws Exception {
						
		int newsDataSize = newsInfoMapper.newsDataSize(category);
		
		return newsDataSize;
	}


	@Override
	public ArrayList<CrawlingDTO> postsPerPage(String category, int startIndex, int endIndex) throws Exception {

		ArrayList<CrawlingDTO> postsPerPage = new ArrayList<CrawlingDTO>();
		
		postsPerPage = newsInfoMapper.postsPerPage(category, startIndex, endIndex);
				
		return postsPerPage;
	}

}
