package kr.or.ddit.autumn.commons.notify.controller;

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
import kr.or.ddit.autumn.commons.notify.service.NotifyService;
import kr.or.ddit.autumn.vo.NotifyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/commons/notify")
public class NotifyDeleteController {

	@Inject
	private NotifyService notifyService;

	//알림 하나 제거
	@PostMapping(value="/notifyDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult notifyDelete(@RequestParam("notNo") Integer notNo
									){
    	ServiceResult result = notifyService.removeNotify(notNo);
		return result;
	}
	//알림 전부 제거
	@PostMapping(value="/notifyAllDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult notifyAllDelete(NotifyVO notify, Authentication authentication){
    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
    	ServiceResult result = notifyService.removeAllNotify(adapter.getRealUser().getEmpId());
		return result;
	}

}