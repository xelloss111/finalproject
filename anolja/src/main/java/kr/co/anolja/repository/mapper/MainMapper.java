package kr.co.anolja.repository.mapper;

import java.util.List;

import kr.co.anolja.repository.domain.Board;

public interface MainMapper {
	
	//게시판 불러오기
	public List<Board> boardList();
}
