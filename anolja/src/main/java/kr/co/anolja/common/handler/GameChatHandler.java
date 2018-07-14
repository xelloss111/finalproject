package kr.co.anolja.common.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.co.anolja.repository.domain.Game;
import kr.co.anolja.repository.mapper.GameMapper;

@Component("gameChat")
public class GameChatHandler extends TextWebSocketHandler {
	
	@Autowired
	private GameMapper mapper;
	
	// 문제 리스트
	public static List<String> questions;
	// 문제 번호
	public static int questionNo;
	public static int userNo;
	
	public GameChatHandler() {}
	
	// 웹소켓 리스트
	private List<WebSocketSession> users = new ArrayList<>();
	// 접속자 아이디 공유하기위한 리스트
	public static List<String> chatList = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// HttpSession 에서 사용자 정보 가져오기
		Map<String, Object> attrs = session.getAttributes();
		String id = (String)attrs.get("id");
//		System.out.println(id + " 연결됨");
		
		// 요청한 사용자 정보관리
		users.add(session);
		chatList.add(id);
		
		System.out.println("--------------------");
		System.out.println("접속한 사용자 목록");
		for (WebSocketSession wss : users) {
			System.out.println(wss);
			wss.sendMessage(new TextMessage("notice:"+id+"님이 참여하셨습니다."));
		}
		System.out.println("--------------------");
		
		// DB에서 문제 뽑아서 20문제 List에 담기
		if (questions == null) {
			questions = mapper.selectAnswer();
//			System.out.println(questions.size());
		}
		
//		if (chatList.size() == 2) {
//		}
		 if (chatList.size() == 2) {
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage("notice:게임을 시작합니다."));
			}
			
			// 문제와 출제자 담기
			Game.setQuestionNo(questions.get(questionNo));
			Game.setQuestionuser(chatList.get(userNo));
			
//			System.out.println("현재문제: "+Game.getQuestionNo()+", 현재 출제자: "+Game.getQuestionuser());
			
			// 문제 출제자에게만 문제 전송하기
			users.get(userNo).sendMessage(new TextMessage("question:"+Game.getQuestionNo()));
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map<String, Object> attrs = session.getAttributes();
		String id = (String)attrs.get("id");
		
		if (message.getPayload().equals("gameEnd")) {
			for (int i = 10; i >= 1; i--) { 
				session.sendMessage(new TextMessage("notice:"+i+"초 후 게임을 시작합니다."));
				Thread.sleep(1000); 
			}
			
//			Game.setQuestionNo(questions.get(questionNo));
//			Game.setQuestionuser(chatList.get(userNo));
//			System.out.println("chatList.get(userNo): "+chatList.get(userNo));
			
//			System.out.println("현재문제: "+Game.getQuestionNo()+", 현재 출제자: "+Game.getQuestionuser());

			users.get(userNo).sendMessage(new TextMessage("question:"+Game.getQuestionNo()));
//			System.out.println("users.get(userNo): " + users.get(userNo));
//			System.out.println("questions.get(questionNo): " + questions.get(questionNo));
			
			session.sendMessage(new TextMessage("notice:게임을 시작합니다."));
			session.sendMessage(new TextMessage("notice:이번차례 : "+chatList.get(userNo)+"님"));
		}
		else if (message.getPayload().equals("Time Over")) {
			session.sendMessage(new TextMessage("notice:"+message.getPayload()));
		}
		else if (message.getPayload().equals(Game.getQuestionNo())) {
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage("notice:"+id+"님 ["+message.getPayload()+"] 정답입니다!!!"));
			}
		}
		else {
			for (WebSocketSession wss : users) {
				if ( !wss.getId().equals(session.getId()) ) {
					wss.sendMessage(new TextMessage(id + ": " + message.getPayload()));
				}
				
			}
		}
		System.out.println("아이디:" + id + ", 메세지: " + message.getPayload());
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> attrs = session.getAttributes();
		String id = (String)attrs.get("id");
		
		for (WebSocketSession wss : users) {
			if ( !wss.getId().equals(session.getId()) ) {
				wss.sendMessage(new TextMessage("notice:"+id+"님 접속종료"));
			}
		}
		
		users.remove(session);
		chatList.remove(id);
		System.out.println(id + " 연결 종료");
	}
	
}
