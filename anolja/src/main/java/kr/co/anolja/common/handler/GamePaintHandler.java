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
	
	private List<WebSocketSession> connectedUsers;
	
	public GamePaintHandler() {
		connectedUsers = new ArrayList<WebSocketSession>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		connectedUsers.add(session);
		System.out.println(connectedUsers.size());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		for (WebSocketSession wss : connectedUsers) {
			if ( !wss.getId().equals(session.getId()) ) {
				wss.sendMessage(new TextMessage(message.getPayload()));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		connectedUsers.remove(session);
	}
	
}
