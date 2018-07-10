package kr.co.anolja.repository.mapper;

import java.util.List;

import kr.co.anolja.repository.domain.Board;

public interface BoardMapper {
	
	public void boardDelete(int no) throws Exception;
	
	public void boardWrite(Board board) throws Exception;

	public Board boardDetail(int no) throws Exception;
	
	public void boardUpdate(Board board) throws Exception;

	public List<Board> boardList() throws Exception;
	
}
