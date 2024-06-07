package com.petpark.dto;

import lombok.Data;

@Data
public class BoardDTO {

	private String board_id;
	private String categories;
	private String subject;
	private String writer;
	private String content;
	private String date;
	private int view_count;
	
}
