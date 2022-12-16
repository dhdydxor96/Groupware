package kr.or.ddit.autumn.websocket;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class NotifyPushMessageHandler extends TextWebSocketHandler {
	
	
	@Resource(name="otherWsSessions")
	private List<WebSocketSession> otherWsSessions;

	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session.getPrincipal().getName());
		if(session.getPrincipal().getName() != null) {
		otherWsSessions.add(session); //연결된 세션 리스트에 추가
		}
		
		
		for(WebSocketSession singleSession : otherWsSessions) {
			log.info("접속자리스트 : {}",singleSession.getPrincipal().getName());
		}
	
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		otherWsSessions.remove(session);//연결 끈어진 세션 리스트에서 제거
		
	}
}
