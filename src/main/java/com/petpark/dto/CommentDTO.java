package com.petpark.dto;

import lombok.Data;

@Data
public class CommentDTO {

	private String comment_id;
	private String board_no;
	private String writer;
	private String content;
	private String date;
}
