package com.petpark.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpark.dto.CommentDTO;
import com.petpark.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentMapper commentMapper;
	
	@Override
	public int boardCommentWrite(String board_no, String writer, String content) {
		
		int result = commentMapper.boardCommentWrite(board_no, writer, content);
		
		return result;
	}

	@Override
	public ArrayList<CommentDTO> selectBoardComment(String board_no) {
		
		ArrayList<CommentDTO> boardComment = new ArrayList<CommentDTO>();
		
		boardComment = commentMapper.selectBoardComment(board_no);
		
		return boardComment;
	}

	@Override
	public int deleteBoardComment(String comment_id, String board_no) {
		
		int result = commentMapper.deleteBoardComment(comment_id, board_no);
		
		return result;
	}

}
