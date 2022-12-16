package kr.or.ddit.autumn.groupware.calendar.event;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.autumn.vo.CalendarVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CalendarEventListener {
	
	@Resource(name="otherWsSessions")
	private List<WebSocketSession> otherWsSessions;

	@EventListener(NewCalendarEvent.class)
	public void newBoardEventListener(NewCalendarEvent event) throws IOException {
		CalendarVO newCalendar = event.getSource();
		log.info("{} 가 작성한 새 일정, {} 제목으로 올라왔음.", newCalendar.getEmpId(), newCalendar.getCalTit());
		//여기서 뉴보드에 어떻게 데이터가 담겼냐??   
		// Insert컨트롤러에서 이런식으로 넣었음  NewBoardEvent event = new NewBoardEvent(board);
		//				context.publishEvent(event);
		//TextMessage에 객체는 못담기에  newBoard를 제이슨형태로 바꿔야함
		ObjectMapper mapper = new ObjectMapper();
		//마샬링작업
		String jsonPayload = mapper.writeValueAsString(newCalendar);
		TextMessage message = new TextMessage(jsonPayload);
		
		// WebSocket 연결이 수립되어 있는 모든 사용자에게 푸시 메시지 전송하기.
		for(WebSocketSession singleSession : otherWsSessions) {
			singleSession.sendMessage(message);
			
		}
	}

}
