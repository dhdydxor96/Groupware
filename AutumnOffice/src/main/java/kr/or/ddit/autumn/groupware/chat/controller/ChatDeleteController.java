package kr.or.ddit.autumn.groupware.chat.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.chat.service.ChatRoomService;
import kr.or.ddit.autumn.groupware.chat.service.MessageService;
import kr.or.ddit.autumn.vo.MessageVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/groupware/chat/chatDelete.do")
public class ChatDeleteController {
	@Inject
	private final MessageService messageService;

	@PostMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult chatDelete(@RequestParam("roomId") Integer roomId
									,Authentication authentication){
    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		MessageVO message = new MessageVO();
		message.setEmpId(adapter.getRealUser().getEmpId());
		message.setRoomId(roomId);
		ServiceResult result = messageService.removeChat(message);

		return result;

	}

}
