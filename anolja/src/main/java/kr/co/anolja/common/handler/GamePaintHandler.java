package kr.co.anolja.common.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.co.anolja.repository.domain.Game;

@Component("gamePaint")
public class GamePaintHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> connectedUsers;
//	private Game question;
	
	public GamePaintHandler() {
		connectedUsers = new ArrayList<WebSocketSession>();
//		question = new Game();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		connectedUsers.add(session);
		System.out.println(connectedUsers.size());
		
//		if (connectedUsers.size() == 6) {
//		}
		 if (connectedUsers.size() == 2) {
//			 System.out.println(Game.getQuestionNo());
//			 System.out.println(Game.getQuestionuser());
//			while(true) {
				if (Game.getQuestionNo() != null && Game.getQuestionuser() != null && !Game.getQuestionNo().equals("") && !Game.getQuestionuser().equals("")) {
//					System.out.println("Game.getQuestionuser(): "+Game.getQuestionuser());
					for (int i = 0; i < connectedUsers.size(); i++) {
//						System.out.println("connectedUsers.get(i): "+connectedUsers.get(i));
//						System.out.println("GameChatHandler.chatList.get(i): "+GameChatHandler.chatList.get(i));
						if (Game.getQuestionuser() == GameChatHandler.chatList.get(i)) {
							System.out.println("현재문제: "+Game.getQuestionNo()+", 현재 출제자: "+Game.getQuestionuser());
							connectedUsers.get(i).sendMessage(new TextMessage("OK"));
						}
						else {
							connectedUsers.get(i).sendMessage(new TextMessage("NO"));
						}
					}
				}
//			}
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		for (int i = 0; i < connectedUsers.size(); i++) {
			if (Game.getQuestionuser() == GameChatHandler.chatList.get(i)) {
				connectedUsers.get(i).sendMessage(new TextMessage("OK"));
			}
			else {
				connectedUsers.get(i).sendMessage(new TextMessage("NO"));
			}
		}

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
