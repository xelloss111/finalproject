package kr.co.anolja.game.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.repository.mapper.GameMapper;

@Service
public class GameServiceImpl implements GameService {
	
	@Autowired
	private GameMapper mapper;
	
	public String selectAnswer() {
		return mapper.selectAnswer();
	}
}
