package kr.co.anolja.main.service;

import java.util.List;

import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.domain.User;

public interface MainService {

	//게시판 불러오기
		public List<Board> boardList();
	//랭크
		public List<User> victoryList();
}
