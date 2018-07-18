package kr.co.anolja.repository.mapper;

import java.util.List;
import java.util.Map;

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
	
	
	public List<Board> selectBoard(Board board);

	public int selectBoardCount();
	
	public void insertBoardFile(BoardFile boardFile);
	
}
