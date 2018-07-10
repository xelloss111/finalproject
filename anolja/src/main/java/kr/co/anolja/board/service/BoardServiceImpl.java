package kr.co.anolja.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;
	
	@Override
	public void boardDelete(int no) throws Exception {
		boardMapper.boardDelete(no);
	}

	@Override
	public void boardWrite(Board board) throws Exception {
		boardMapper.boardWrite(board);
	}

	@Override
	public Board boardDetail(int no) throws Exception {
		return boardMapper.boardDetail(no);
	}

	@Override
	public void boardUpdate(Board board) throws Exception {
		boardMapper.boardUpdate(board);
	}

	@Override
	public List<Board> boardList() throws Exception {
		return boardMapper.boardList();
	}
	
	
	
	
	
	

}
