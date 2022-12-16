package kr.or.ddit.autumn.groupware.chat.controller;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Headers;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.vo.MessageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController // RestController를 붙이면, 컨트롤러 클래스 하위 메서드에 @ResponseBody 어노테이션을 붙이지 않아도 문자열과 JSON// 등을 전송가능
public class EchoMessageHandler {
	
	@Inject
	private SimpMessagingTemplate messagingTemplate; 
	

	
	@MessageMapping("/handledEcho") // 클라이언트에서 handledEcho로 send하면 여기로 와서 메소드실행됨
	public void handler(@Payload MessageVO messageVO, @Header String id) {
		log.info("id header : {}", id);
		log.info("roomId : {}, sender : {}, message : {}, nm : {} , msgDay : {}",messageVO.getRoomId()
				, messageVO.getEmpId(), messageVO.getMsgCon(),messageVO.getEmpNm(),messageVO.getMsgDay());

		
		messagingTemplate.convertAndSend("/topic/echoed/"+messageVO.getRoomId(), messageVO);

	}

	// destination 이 /app/handledEcho 인 구독 요청에 대해 동작하며,
	// 한번의 요청에 한번의 응답만을 처리하게 됨.
	
	@SubscribeMapping("/handledEcho")
	public String subscribeHandler(@Headers Map<String, Object> headers
									,Authentication authentication
									) {
		log.info("headers : {}", headers);
		
		// subscription id 를 생성함.
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		
		String sub_id = adapter.getRealUser().getEmpId();
		return sub_id;
	}

	//=================================1대1==========================================
	

	@MessageMapping("/myProcess")
	@SendToUser("/queue/myProcessResult") // 접속 유저를 대상으로 한 push 메시지,
	public String handlerProcessResult(@Payload String message) {
		log.info("; message : {}", message);
		return message;
	}

	@MessageMapping("/DM")
	public void handlerDM(@Payload MessageVO body) {
		log.info("DM message : {}", body);
//		messagingTemplate.convertAndSendToUser(body.getReceiver(), "/queue/DM", body);

	}
}