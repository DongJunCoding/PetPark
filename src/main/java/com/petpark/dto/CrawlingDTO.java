package com.petpark.dto;

import lombok.Data;

@Data
public class CrawlingDTO {

	private int newsId;
	private String categories;
	private String subject;
	private String writer;
	private String main_image;
	private String content;
	private String date;
	private String update_date;
	private int view_count;
	
}
