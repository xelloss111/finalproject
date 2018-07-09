package kr.co.anolja.common.handler;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component("game")
public class WebSocketHandler extends TextWebSocketHandler {
	private Map<String, WebSocketSession> users = new HashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session.getId() + " 연결됨");
		// 요청한 사용자 정보관리
		users.put(session.getId(), session);
		System.out.println("접속한 사용자 목록");
		Set<String> keys = users.keySet();
		for (String user : keys) {
			System.out.println(user);
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("아이디:" + session.getId() + "메세지: " + message.getPayload());
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println(session.getId() + " 연결 종료");
		users.remove(session.getId());
	}
	
	
}
