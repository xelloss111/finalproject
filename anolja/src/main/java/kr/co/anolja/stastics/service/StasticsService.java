package kr.co.anolja.stastics.service;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface StasticsService {
	public void setApiKey(String apiKey);
	//계정 아이디 식별자 얻기
	public String getAccountId(String playerName);
	//해당 계정의 최근  매치 데이터를 JSON 배열 형태로 반환
	public String getUserMatchId(String accountId);
	//매치 아이디와 아이디를 입력하면 해당 매치에 대한 사용자의 정보를 JSON형태 문자열로 반환
	public String getMatchUserInfo(String matchId,String playerName);
	//매치 아이디에 해당하는 매치정보를 Map형태로 반환
	public Map<String,Object> getMatchInfo(String matchId);
	//해당 시즌과 게임모드를 입력받아 해당하는 계정 데이터의 시즌 해당 정보를 JSON으로 반환
	public String getSeasonInfo(String accountId,String seasonInfo,String gameMode);

}
