package kr.co.anolja.stastics.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;


public interface StasticsService {
	public void setApiKey(String apiKey);
	
	//계정 아이디 식별자 얻기
	public String getAccountId(String playerName);
	//해당 계정의 최근  매치 데이터를 JSON 배열 형태로 반환
	public List<Map<String,Object>> getMatchId(String accountId);
	//매치 아이디와 아이디를 입력하면 해당 매치에 대한 사용자의 정보를 JSON형태 문자열로 반환
	public String getMatchUserInfo(String matchId,String playerName);
	//매치 아이디에 해당하는 매치정보를 Map형태로 반환
	public Map<String,Object> getMatchInfo(String matchId);
	//해당 시즌과 게임모드를 입력받아 해당하는 계정 데이터의 시즌 해당 정보를 JSON으로 반환
	public Map<String, Object> getSeasonInfo(String accountId,String seasonInfo,String gameMode);
	//매치 리스트를 불러오는 메소드
	public List<Map<String,Object>> getMatchUserInfoList(List<Map<String,Object>> list,String playerName);
}
