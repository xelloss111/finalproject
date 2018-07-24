package kr.co.anolja.common.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.co.anolja.repository.domain.Game;
import kr.co.anolja.repository.domain.User;
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
	
	// 정답갯수 관리
	public static Map<String, Integer> rightAnswerCnt = new HashMap<>();
	int cnt = 0;
	
	final int maxUsers = 5;
	
	@Override
	public synchronized void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// HttpSession 에서 사용자 정보 가져오기
		Map<String, Object> attrs = session.getAttributes();
		String id = (String)attrs.get("id");
		
		// 요청한 사용자 정보관리
		users.add(session);
		chatList.add(id);
		System.out.println(id + " 연결됨");
		
		// 접속한 유저가 5명일 때 못들어오게하기
		if (users.size() > maxUsers) {
			if (users.get(maxUsers) != null) {
				users.get(maxUsers).sendMessage(new TextMessage("room full"));
			}
		}
		// 그렇지 않으면 참여시키기
		else {
			System.out.println("--------------------");
			System.out.println("접속한 사용자 목록");
			for (WebSocketSession wss : users) {
				System.out.println(wss);
				wss.sendMessage(new TextMessage("notice:"+id+"님이 참여하셨습니다."));
			}
			System.out.println("--------------------");
		}
		
		if (chatList.size() == maxUsers) {
			// uesr가 나갔다 다시 들어왔을 때 게임중일 때는 return시키기
			if (questions != null) {
				return;
			}
			
			// DB에서 문제 뽑아서 10문제 List에 담기
			if (questions == null) {
				questions = mapper.selectAnswer();
//			System.out.println(questions.size());
			}
			
			// 모든 게임이 끝나면 리셋시키기
			if (questionNo == 10) {
				questionNo = 0;
				userNo = 0;
				Game.setQuestionNo(null);
				Game.setQuestionuser(null);
			}
			
			// 문제와 출제자 담기
			Game.setQuestionNo(questions.get(questionNo));
			Game.setQuestionuser(chatList.get(userNo));
			System.out.println("현재문제: "+Game.getQuestionNo()+", 현재 출제자: "+Game.getQuestionuser());
			
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage("notice:게임을 시작합니다."));
				wss.sendMessage(new TextMessage("notice:이번차례 : "+chatList.get(userNo)+"님"));
				wss.sendMessage(new TextMessage("현재문제:"+Game.getQuestionNo()));
			}
			
			// 문제 출제자에게만 문제 전송하기
			users.get(userNo).sendMessage(new TextMessage("question:"+Game.getQuestionNo()));
		}
	}
	public static boolean flag = false;
	
	@Override
	protected synchronized void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map<String, Object> attrs = session.getAttributes();
		String id = (String)attrs.get("id");
		
		if (message.getPayload().equals("next")) {
			questionSend();
		}
		else if (message.getPayload().contains("rcmndCnt")) {
			System.out.println(id+" : "+message.getPayload());
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage(message.getPayload()));
			}
		}
		else if (message.getPayload().contains("gallery:")) {
			String msg = message.getPayload().substring("gallery:".length());
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage(msg));
			}
		}
		else if (message.getPayload().equals("gameEnd")) {
			endGame(session);
		}
		else if (message.getPayload().equals("Time Over")) {
			session.sendMessage(new TextMessage("notice:"+message.getPayload()));
		}
		else if (message.getPayload().contains("그림이 마음에") || message.getPayload().equals("hide")) {
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage(message.getPayload()));
			}
		}
		// 받은 메세지와 현재 문제가 같을 경우(정답인 경우)
		else if (message.getPayload().equals(Game.getQuestionNo())) {
			for (WebSocketSession wss : users) {
				if ( !wss.getId().equals(session.getId()) ) {
					wss.sendMessage(new TextMessage(id + ": " + message.getPayload()));
				}
			}
			if (flag == true) {
				return;
			}
			User user = new User();
			user.setId(id);
			mapper.updateGameVictory(user);
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage("notice:"+id+"님 ["+message.getPayload()+"] 정답입니다!!!"));
				flag = false;
			}
			
			// 한 게임의 셋트당 맞춘 문제 수 관리
			if (rightAnswerCnt.get(id) == null) {
				rightAnswerCnt.put(id, 0);
			}
			cnt = rightAnswerCnt.get(id);
			cnt++;
			rightAnswerCnt.remove(id);
			rightAnswerCnt.put(id, cnt);
//			System.out.println("정답맞출시 : "+ id +rightAnswerCnt.get(id));
			synchronized (users) {
				for (int i = 0; i < chatList.size(); i++) {
					for (WebSocketSession wss : users) {
						wss.sendMessage(new TextMessage("rightAnswerCnt:"+id+":"+rightAnswerCnt.get(id)));
					}
				}
			}
			flag = true;
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

	/**
	 * @param session
	 * @throws IOException
	 * @throws InterruptedException
	 */
	private void endGame(WebSocketSession session) throws IOException, InterruptedException {
		if (questionNo == 10) {return;}
//		for (int i = 5; i >= 1; i--) { 
//			session.sendMessage(new TextMessage("notice:초 후 게임을 시작합니다."));
//			Thread.sleep(1000); 
//		}
		for (WebSocketSession wss : users) {
			wss.sendMessage(new TextMessage("notice:게임을 시작합니다."));
			wss.sendMessage(new TextMessage("notice:이번차례 : "+chatList.get(userNo)+"님"));
			wss.sendMessage(new TextMessage("현재문제:"+Game.getQuestionNo()));
		}
	}

	/**
	 * @throws IOException
	 */
	private void questionSend() throws IOException {
		// 출제자에게 문제 보내기
//		System.out.println("출제자..에게문제보내기: " + users.get(userNo));
		users.get(userNo).sendMessage(new TextMessage("question:"+Game.getQuestionNo()));
		
		System.out.println("문제번호: "+questionNo);
		// 10문제 끝나면 게임 끝내기
		if (questionNo == 10) {
			for (WebSocketSession wss : users) {
				wss.sendMessage(new TextMessage("notice:모든 게임이 끝났습니다. 메인으로 넘어갑니다!~"));
			}
			questions = null;
			Game.setQuestionNo(null);
			Game.setQuestionuser(null);
			return;
		}
	}

	@Override
	public synchronized void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> attrs = session.getAttributes();
		String id = (String)attrs.get("id");
		
		if (users.size() > maxUsers) {
		}
		else {
			for (WebSocketSession wss : users) {
				if ( !wss.getId().equals(session.getId()) ) {
					wss.sendMessage(new TextMessage("notice:"+id+"님 접속종료"));
				}
			}
		}
		
		users.remove(session);
		chatList.remove(id);
		System.out.println(id + " 연결 종료");
		System.out.println("--------------------");
		System.out.println("접속한 사용자 목록");
		for (WebSocketSession wss : users) {
			System.out.println(wss);
		}
		System.out.println("--------------------");
		
		if (chatList.size() == 1) {
			users.get(0).sendMessage(new TextMessage("notice:게임 참여 인원수 부족으로 게임을 끝냅니다."));
		}
		if (chatList.size() == 0) {
			questions = null;
			questionNo = 0;
			userNo = 0;
			cnt = 0;
			rightAnswerCnt.remove(id);
			Game.setQuestionNo(null);
			Game.setQuestionuser(null);
		}
	}
	
}
