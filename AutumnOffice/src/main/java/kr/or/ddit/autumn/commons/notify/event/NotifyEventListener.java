package kr.or.ddit.autumn.commons.notify.event;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.autumn.vo.NotifyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class NotifyEventListener {
	

	@Resource(name="otherWsSessions")
	private List<WebSocketSession> otherWsSessions;

	@EventListener(NewNotifyEvent.class)
	public void newNotifyEventListener(NewNotifyEvent event) throws IOException {
		NotifyVO newNotify = event.getSource();
		log.info("{} 가 작성한 새 알림, {} 한테 보냈음.", newNotify.getSendempId(), newNotify.getEmpId());
		
		ObjectMapper mapper = new ObjectMapper();
		//마샬링작업
		String jsonPayload = mapper.writeValueAsString(newNotify);
		TextMessage message = new TextMessage(jsonPayload);
		
		// WebSocket 연결이 수립되어 있는 모든 사용자에게 푸시 메시지 전송하기.
		
		for(WebSocketSession singleSession : otherWsSessions) {
			String memId = singleSession.getPrincipal().getName();
			if(memId.equals(newNotify.getEmpId())) {
				singleSession.sendMessage(message);
			}
		}
	}

}
