package kr.co.anolja.repository.mapper;

import java.util.List;

import kr.co.anolja.repository.domain.User;

public interface GameMapper {
	List<String> selectAnswer();
	void updateGameVictory(User user);
}
