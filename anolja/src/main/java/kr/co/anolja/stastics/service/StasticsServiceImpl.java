package kr.co.anolja.stastics.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class StasticsServiceImpl implements StasticsService {
	private String apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiNGQ3MjJlMC01ZmY3LTAxMzYtYzljZC00OTk2OTY0YzJkYzMiLCJpc3MiOiJnYW1lbG9ja2VyIiwiaWF0IjoxNTMwNTE2NjIzLCJwdWIiOiJibHVlaG9sZSIsInRpdGxlIjoicHViZyIsImFwcCI6ImFwaXByYWN0aWNlIn0.9zcoqesjlQaFzvmntiYCRUvpHThDBXQv8YKO57ROxiE";

	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}

	//계정 아이디 식별자 얻기
	public String getAccountId(String playerName) {
		String apiAddress="https://api.playbattlegrounds.com/shards/pc-krjp/players?filter[playerNames]="+playerName;

		String errMsg = "";

		InputStreamReader isr = null;

		BufferedReader br = null;

		StringBuilder sb = new StringBuilder();

		JsonArray jsonArray = null;

		try {
			URL url = new URL(apiAddress);

			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("accept", "application/vnd.api+json");
			con.setRequestProperty("Authorization", apiKey);

			isr = new InputStreamReader(con.getInputStream());


			br = new BufferedReader(isr);



			while(true) {
				String line = br.readLine();

				if(line == null) {
					break;
				}

				sb.append(line);
			}

			JsonParser parser = new JsonParser();

			JsonObject jsonObject =  (JsonObject)parser.parse(sb.toString());

			//System.out.println(jsonObject.get("data"));
			jsonArray =  jsonObject.get("data").getAsJsonArray();

			//System.out.println(((JsonObject)jsonArray.get(0)).get("id"));
			/*
		apiAddress = "https://api.playbattlegrounds.com/shards/pc-na/players/coppersin/seasons/division.bro.official.2018-07";
		url = new URL(apiAddress);
			 */
		}catch (Exception e) {
			errMsg = "URL 경로에 해당하는 자료 없음";
			return errMsg;

		}finally {
			try {

				isr.close();
				br.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				errMsg += ",IO에러 발생";
				return errMsg;
			}
		}
		return ((JsonObject)jsonArray.get(0)).get("id").toString().replaceAll("\"", "");
	}

	//해당 계정의 최근  매치 데이터를 JSON 배열 형태로 반환 -> 이 메소드를 통해서 얻은 정보로 getMatchUserInfo/getMatchInfo를 이용한다. 
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getMatchId(String accountId) {

		String apiAddress="https://api.playbattlegrounds.com/shards/pc-krjp/players/"+accountId;

		String errMsg = "";

		InputStreamReader isr = null;

		BufferedReader br = null;

		StringBuilder sb = new StringBuilder();
		
		JsonObject jsonObject = null;
		
		Map<String,Object> map = null;
		
		List<Map<String,Object>> list = new ArrayList<>();
		
		try {
			URL url = new URL(apiAddress);

			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("accept", "application/vnd.api+json");
			con.setRequestProperty("Authorization", apiKey);

			isr = new InputStreamReader(con.getInputStream());


			br = new BufferedReader(isr);



			while(true) {
				String line = br.readLine();

				if(line == null) {
					break;
				}

				sb.append(line);
			}
			
			JsonParser parser = new JsonParser();
			
			jsonObject = (JsonObject)parser.parse(sb.toString());
			
			JsonArray jsonArr = ((JsonObject)((JsonObject)((JsonObject)(jsonObject.get("data"))).get("relationships")).get("matches")).getAsJsonArray("data");
			
			for(int i = 0;i<jsonArr.size();i++) {
				map = new ObjectMapper().readValue(jsonArr.get(i).toString(), HashMap.class);
				
				list.add(map);
			}
			
			//System.out.println(((JsonObject)jsonArray.get(0)).get("id"));
			/*
		apiAddress = "https://api.playbattlegrounds.com/shards/pc-na/players/coppersin/seasons/division.bro.official.2018-07";
		url = new URL(apiAddress);
			 */
		}catch (Exception e) {
			e.printStackTrace();

		}finally {
			try {
				isr.close();
				br.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	//매치 아이디와 아이디를 입력하면 해당 매치에 대한 사용자의 정보를 JSON형태 문자열로 반환
	public String getMatchUserInfo(String matchId,String playerName) {
		String apiAddress="https://api.playbattlegrounds.com/shards/pc-krjp/matches/"+matchId;

		String errMsg = "";

		InputStreamReader isr = null;

		BufferedReader br = null;

		StringBuilder sb = new StringBuilder();

		String player = null;

		try {
			URL url = new URL(apiAddress);

			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("accept", "application/vnd.api+json");
			con.setRequestProperty("Authorization", apiKey);

			isr = new InputStreamReader(con.getInputStream());


			br = new BufferedReader(isr);



			while(true) {
				String line = br.readLine();

				if(line == null) {
					break;
				}

				sb.append(line);
			}

			JsonParser parser = new JsonParser();
			
			
			//			System.out.println(parser.parse(sb.toString()));

			JsonObject jsonObject = (JsonObject)parser.parse(sb.toString());
			
			

//			Included 매치에 대한 사용자 정보 추출 
			//			System.out.println(jsonObject.get("included"));
			JsonArray jsonArr = (jsonObject.get("included")).getAsJsonArray();


			for(int i = 0; i < jsonArr.size(); i++) {
				//				if((((JsonObject)jsonArr.get(i)).get("type")).toString().equals("roster")) {
				//					
				//					continue;
				//				}
				
				if((((JsonObject)jsonArr.get(i)).get("type")).toString().equals("\"participant\"") && (((JsonObject)jsonArr.get(i)).get("type")).toString()!=null) {
					if(((JsonObject)((JsonObject)((JsonObject)jsonArr.get(i)).get("attributes")).get("stats")).get("name").toString().equals("\""+playerName+"\"")) {
						
						String gameMode = jsonObject.getAsJsonObject("data").get("attributes").getAsJsonObject().get("gameMode").toString();
						String createdAt = jsonObject.getAsJsonObject("data").get("attributes").getAsJsonObject().get("createdAt").toString();
						String mapName = jsonObject.getAsJsonObject("data").get("attributes").getAsJsonObject().get("mapName").toString();
						
						JsonObject resultObject = (((JsonObject)((JsonObject)jsonArr.get(i)).get("attributes")).get("stats").getAsJsonObject());
						
						resultObject.addProperty("gameMode", gameMode);
						resultObject.addProperty("createdAt", createdAt);
						resultObject.addProperty("mapName", mapName);
						
						player = resultObject.toString();
						//.addProperty("gameMode", gameMode)
					}
				};

				//				System.out.println(((JsonObject)((JsonObject)((JsonObject)jsonArr.get(i)).get("attributes")).get("stats")).get("name"));
			}



			//			System.out.println(player);


			//a3133ab5-517f-47e1-9ddd-854173b10405


			//System.out.println(((JsonObject)jsonArray.get(0)).get("id"));
			/*
		apiAddress = "https://api.playbattlegrounds.com/shards/pc-na/players/coppersin/seasons/division.bro.official.2018-07";
		url = new URL(apiAddress);
			 */
		}catch (Exception e) {
			e.printStackTrace();

		}finally {
			try {

				isr.close();
				br.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return player;

	}

	//매치 아이디에 해당하는 매치정보를 Map형태로 반환
	@SuppressWarnings("unchecked")
	public Map<String,Object> getMatchInfo(String matchId) {
		String apiAddress="https://api.playbattlegrounds.com/shards/pc-krjp/matches/"+matchId;

		String errMsg = "";

		InputStreamReader isr = null;

		BufferedReader br = null;

		StringBuilder sb = new StringBuilder();

		Map<String,Object> map = null;

		try {
			URL url = new URL(apiAddress);

			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("accept", "application/vnd.api+json");
			con.setRequestProperty("Authorization", apiKey);

			isr = new InputStreamReader(con.getInputStream());


			br = new BufferedReader(isr);



			while(true) {
				String line = br.readLine();

				if(line == null) {
					break;
				}

				sb.append(line);
			}

			JsonParser parser = new JsonParser();

			//			System.out.println(parser.parse(sb.toString()));

			JsonObject jsonObject = (JsonObject)parser.parse(sb.toString());

			String matchInfo = (((JsonObject)(jsonObject.get("data"))).get("attributes")).toString();


			map = new ObjectMapper().readValue(matchInfo, HashMap.class);

			//a3133ab5-517f-47e1-9ddd-854173b10405


			//System.out.println(((JsonObject)jsonArray.get(0)).get("id"));
			/*
		apiAddress = "https://api.playbattlegrounds.com/shards/pc-na/players/coppersin/seasons/division.bro.official.2018-07";
		url = new URL(apiAddress);
			 */
		}catch (Exception e) {
			e.printStackTrace();

		}finally {
			try {

				isr.close();
				br.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return map;

	}

	//해당 시즌과 게임모드를 입력받아 해당하는 계정 데이터의 시즌 해당 정보를 JSON으로 반환
	@SuppressWarnings("unchecked")
	public Map<String,Object> getSeasonInfo(String accountId,String seasonInfo,String gameMode) {
		String apiAddress="https://api.playbattlegrounds.com/shards/pc-krjp/players/"+accountId+"/seasons/"+seasonInfo;

		String errMsg = "";

		InputStreamReader isr = null;

		BufferedReader br = null;

		StringBuilder sb = new StringBuilder();

		JsonObject jsonObject = null;

		Map<String,Object> map = null;

		try {
			URL url = new URL(apiAddress);

			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("accept", "application/vnd.api+json");
			con.setRequestProperty("Authorization", apiKey);

			isr = new InputStreamReader(con.getInputStream());


			br = new BufferedReader(isr);



			while(true) {
				String line = br.readLine();

				if(line == null) {
					break;
				}

				sb.append(line);
			}

			JsonParser parser = new JsonParser();

			jsonObject =  (JsonObject)parser.parse(sb.toString());

			//System.out.println(jsonObject.get("data"));

			//System.out.println(((JsonObject)jsonArray.get(0)).get("id"));
			/*
		apiAddress = "https://api.playbattlegrounds.com/shards/pc-na/players/coppersin/seasons/division.bro.official.2018-07";
		url = new URL(apiAddress);
			 */

			String matchInfo = ((JsonObject)(JsonObject)((JsonObject)(jsonObject.get("data"))).get("attributes").getAsJsonObject().get("gameModeStats")).get(gameMode).toString();


			map = new ObjectMapper().readValue(matchInfo, HashMap.class);

		}catch (Exception e) {
			e.printStackTrace();

		}finally {
			try {

				isr.close();
				br.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getMatchUserInfoList(List<Map<String,Object>> list,String playerName){
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		for(int i=0;i<list.size();i++) {
			 String json = getMatchUserInfo(list.get(i).get("id").toString(), playerName);
			 
			 try {
				Map<String,Object> userInfo = new ObjectMapper().readValue(json, HashMap.class);
				resultList.add(userInfo);
			} catch (JsonParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JsonMappingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		return resultList;
	}
	
	public List<Map<String,Object>> getMatchInfoList(List<Map<String,Object>>list){
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		for(int i=0;i<list.size();i++) {
			 Map<String,Object> info = getMatchInfo(list.get(i).get("id").toString());
			 System.out.println(info);
				
			resultList.add(info);
		}
			
		
		return resultList;
	}
	
	
}
