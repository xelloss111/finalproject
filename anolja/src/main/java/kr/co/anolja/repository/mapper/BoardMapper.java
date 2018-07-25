package kr.co.anolja.repository.mapper;

import java.util.List;

import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.domain.BoardFile;

public interface BoardMapper {
	
	public void boardDelete(int no) throws Exception;
	public void boardWrite(Board board) throws Exception;
	public Board boardDetail(int no) throws Exception;
	public void boardUpdate(Board board) throws Exception;
	public List<Board> boardList(int pageNo) throws Exception;
	public void boardInsert(Board board) throws Exception;
	public void boardInsertFile(BoardFile boardFile);
	public void updateViewCnt(int bNo);
	
	public List<Board> searchBoard(String board);
	
	
	public void boardReply(Board board) throws Exception;
	
	public void boardUpdateNo(int bNo) throws Exception;
	
	public List<Board> selectBoard(Board board);

	public int selectBoardCount();
	
	public void insertBoardFile(BoardFile boardFile);
	
	
	public void updateReplyBoard(Board board);
	public void updateBno(int getbNo);
	
	public List<BoardFile> selectFileNo(int no);
	
	public int selectCommentCount(int no);
	
}
