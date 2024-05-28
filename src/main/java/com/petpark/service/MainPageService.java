package com.petpark.service;

import java.util.ArrayList;

import com.petpark.dto.CrawlingDTO;

public interface MainPageService {

	/* News 데이터 최신 10개 리스트 가져오기 */
	ArrayList<CrawlingDTO> selectRecentNews() throws Exception;

}
