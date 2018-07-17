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
	public synchronized void afterConnectionEstablished(WebSocketSession session) throws Exception {
		connectedUsers.add(session);
		
		if (connectedUsers.size() == 3) {
			// 현재 출제자에게 그림 그릴 수 있는 권한 주기
			for (int i = 0; i < connectedUsers.size(); i++) {
				if (Game.getQuestionuser() == GameChatHandler.chatList.get(i)) {
					connectedUsers.get(i).sendMessage(new TextMessage("OK"));
				}
				else {
					connectedUsers.get(i).sendMessage(new TextMessage("NO"));
				}
				connectedUsers.get(i).sendMessage(new TextMessage("{ \"mode\" : \"fill\", \"color\" : \"#FFFFFF\" }"));
			}
		}
	}

	@Override
	protected synchronized void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 한문제가 끝난 후 문제와 출제자 다음으로 set해주기
		if (message.getPayload().equals("next")) {
			GameChatHandler.flag = false;
			++GameChatHandler.questionNo;
			++GameChatHandler.userNo;
			if (GameChatHandler.userNo > GameChatHandler.chatList.size()-1) {
				GameChatHandler.userNo = 0;
			}
			if (GameChatHandler.questionNo < 10) {
				Game.setQuestionNo(GameChatHandler.questions.get(GameChatHandler.questionNo));
				Game.setQuestionuser(GameChatHandler.chatList.get(GameChatHandler.userNo));
			}
			if (GameChatHandler.questionNo == 10) {
				GameChatHandler.questions = null;
			}
		}
		if (message.getPayload().equals("gameRestart")) {
			for (int i = 0; i < connectedUsers.size(); i++) {
				if (Game.getQuestionuser() == GameChatHandler.chatList.get(i)) {
					connectedUsers.get(i).sendMessage(new TextMessage("OK"));
				}
				else {
					synchronized(connectedUsers.get(i)) {
						connectedUsers.get(i).sendMessage(new TextMessage("NO"));
					}
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
	public synchronized void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		connectedUsers.remove(session);
	}
	
}
