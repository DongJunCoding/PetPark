package com.petpark.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.petpark.dto.CommentDTO;

@Mapper
public interface CommentMapper {
	
	// 게시판 댓글 쓰기
	public int boardCommentWrite(String board_no, String writer, String content);
	
	// 게시판 번호에 따른 댓글 리스트
	public ArrayList<CommentDTO> selectBoardComment(String board_no);
	
	// 게시판 댓글 삭제
	public int deleteBoardComment(String comment_id, String board_no);
	
	// 게시판 댓글 수정
	public int modifyBoardComment(String content, String board_no, String comment_id);
}
