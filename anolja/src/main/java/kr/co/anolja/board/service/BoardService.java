package kr.co.anolja.board.service;

import java.util.List;
import java.util.Map;

import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.domain.BoardFile;
import kr.co.anolja.repository.domain.Comment;

public interface BoardService {

	public void boardDelete(int no) throws Exception;

	public void boardWrite(Board board) throws Exception;

	public Board boardDetail(int no) throws Exception;

	public void boardUpdate(Board board) throws Exception;

	public Map<String, Object> boardList(int pageNo) throws Exception;

	public void boardInsert(Board board, BoardFile boardFile) throws Exception;

	public void boardReply(Board board, BoardFile boardFile) throws Exception;

	
	public List<String> selectFileNo(int no);
	
	public int selectCommentCount(int no);

	// 댓글 시작 
	
	public List<Comment> selectCommentByNo(int no);

	public void insertComment(Comment comment);

	public void deleteComment(Comment comment);

	public void updateComment(Comment comment);

	public List<Board> searchBoard(String board);



//	public int selectBoardCount(Page search);



}
