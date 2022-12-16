package kr.or.ddit.autumn.commons.notify.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.commons.notify.service.NotifyService;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.vo.NotifyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/commons/notify")
public class NotifyUpdateController {

	@Inject
	private NotifyService notifyService;

	//모든 메세지 읽음처리
	@GetMapping(value="/notifyAllRead.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult notifyAllRead(Model model, Authentication authentication){
    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		ServiceResult result = notifyService.modifyAllNotify(adapter.getRealUser().getEmpId());
		return result;
	}
	//메세지 하나 읽음 처리
	@PostMapping(value="/notifyRead.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult notifyRead(@Validated(UpdateGroup.class)@ModelAttribute("notify") 
									NotifyVO notify 
									,Errors errors
									,Authentication authentication){
		ServiceResult result = null;
		if(!errors.hasErrors()) {
    	result = notifyService.modifyNotify(notify);
		}
		return result;
	}

}