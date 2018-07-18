package kr.co.anolja.repository.mapper;

import java.util.List;

import kr.co.anolja.repository.domain.Comment;

public interface CommentMapper {

	List<Comment> selectCommentByNo(int no);

	void insertComment(Comment comment);
	
	void deleteComment(Comment comment);
	
	void updateComment(Comment comment);
	
}
