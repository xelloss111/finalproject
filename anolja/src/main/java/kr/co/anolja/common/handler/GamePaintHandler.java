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
	
	public GamePaintHandler() {
		connectedUsers = new ArrayList<WebSocketSession>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		connectedUsers.add(session);
		
//		if (connectedUsers.size() == 6) {
//		}
		 if (connectedUsers.size() == 2) {
			if (Game.getQuestionNo() != null && Game.getQuestionuser() != null && !Game.getQuestionNo().equals("") && !Game.getQuestionuser().equals("")) {
				for (int i = 0; i < connectedUsers.size(); i++) {
					if (Game.getQuestionuser() == GameChatHandler.chatList.get(i)) {
						connectedUsers.get(i).sendMessage(new TextMessage("OK"));
					}
					else {
						connectedUsers.get(i).sendMessage(new TextMessage("NO"));
					}
				}
			}
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		if (message.getPayload().equals("next")) {
			++GameChatHandler.questionNo;
			++GameChatHandler.userNo;
			if (GameChatHandler.userNo > GameChatHandler.chatList.size()-1) {
				GameChatHandler.userNo = 0;
			}
			Game.setQuestionNo(GameChatHandler.questions.get(GameChatHandler.questionNo));
			Game.setQuestionuser(GameChatHandler.chatList.get(GameChatHandler.userNo));
		}
		if (message.getPayload().equals("gameRestart")) {
			for (int i = 0; i < connectedUsers.size(); i++) {
				if (Game.getQuestionuser() == GameChatHandler.chatList.get(i)) {
					connectedUsers.get(i).sendMessage(new TextMessage("OK"));
				}
				else {
					connectedUsers.get(i).sendMessage(new TextMessage("NO"));
				}
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
