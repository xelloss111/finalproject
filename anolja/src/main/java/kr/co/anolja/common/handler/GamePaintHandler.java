package kr.co.anolja.common.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component("gamePaint")
public class GamePaintHandler extends TextWebSocketHandler {
	
//	public GamePaintHandler() {}
//	
//	// 웹소켓 리스트
//	private Map<String, WebSocketSession> users = new HashMap<>();
//	
//	// 접속자 아이디 공유하기위한 리스트
//	public static List<String> chatList = new ArrayList<>();
//	
//	@Override
//	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//		Map<String, Object> attrs = session.getAttributes();
//		String id = (String)attrs.get("id");
////		System.out.println(id + " 연결됨");
//		
//		// 요청한 사용자 정보관리
//		users.put(id, session);
//		chatList.add(id);
//		
//		System.out.println("--------------------");
//		System.out.println("접속한 사용자 목록");
//		Set<String> keys = users.keySet();
//		for (String user : keys) {
//			System.out.println(user);
//			WebSocketSession wss = users.get(user);
//			wss.sendMessage(new TextMessage("notice:"+id+"님이 참여하셨습니다."));
//		}
//		System.out.println("--------------------");
//	}
//
//	@Override
//	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//		Map<String, Object> attrs = session.getAttributes();
//		String id = (String)attrs.get("id");
//		
//		Set<String> keys = users.keySet();
//		for (String user : keys) {
//			WebSocketSession wss = users.get(user);
//			if ( !wss.getId().equals(session.getId()) ) {
//				wss.sendMessage(new TextMessage(id + ": " + message.getPayload()));
//            }
//		}
//		System.out.println("아이디:" + id + ", 메세지: " + message.getPayload());
//	}
//
//	@Override
//	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//		Map<String, Object> attrs = session.getAttributes();
//		String id = (String)attrs.get("id");
//		
//		Set<String> keys = users.keySet();
//		for (String user : keys) {
//			System.out.println(user);
//			WebSocketSession wss = users.get(user);
//			if ( !wss.getId().equals(session.getId()) ) {
//				wss.sendMessage(new TextMessage("notice:"+id+"님 접속종료"));
//			}
//		}
//		
//		users.remove(id);
//		chatList.remove(id);
//		System.out.println(id + " 연결 종료");
//	}
	
}
