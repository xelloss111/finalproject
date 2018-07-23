package kr.co.anolja.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.repository.domain.Board;
import kr.co.anolja.repository.mapper.MainMapper;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainMapper mapper;
	
	@Override
	public List<Board> boardList() {
		return mapper.boardList();
	}

	

}
