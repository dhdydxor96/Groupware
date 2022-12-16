package kr.or.ddit.autumn.commons.notify.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.commons.notify.service.NotifyService;
import kr.or.ddit.autumn.vo.NotifyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/commons/notify")
public class NotifySelectController {

	@Inject
	private NotifyService notifyService;

	//알림리스트 데이터
	@GetMapping(value="/notifyList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<NotifyVO> notifyList(Model model, Authentication authentication){
    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		List<NotifyVO> notifyList = notifyService.retrieveNotifyList(adapter.getRealUser().getEmpId());
		return notifyList;
	}

}