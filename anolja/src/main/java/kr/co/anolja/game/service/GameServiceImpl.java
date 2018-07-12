package kr.co.anolja.game.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anolja.repository.mapper.GameMapper;

@Service
public class GameServiceImpl implements GameService {
	
	@Autowired
	private GameMapper mapper;
	
	public void selectAnswer() {
//		System.out.println(mapper.selectAnswer());
//		List<String> list = mapper.selectAnswer();
//		System.out.println(list.size());
//		return mapper.selectAnswer();
	}
}
