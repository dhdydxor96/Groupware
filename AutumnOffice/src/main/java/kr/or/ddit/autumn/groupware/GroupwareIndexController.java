package kr.or.ddit.autumn.groupware;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.management.base.service.PopupManageService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PopUpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GroupwareIndexController {
	
	@Inject
	private PopupManageService popupService;
	
	@ModelAttribute("popup")
	public PopUpVO popup(
		@AuthenticationPrincipal(expression="realUser") EmployeeVO employee) {
		
		PopUpVO popup = new PopUpVO();
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@ 확인 @@@@@@@@@@@@@@@@@@@@@@@");
		String comCode = employee.getComCode();
		popup.setComCode(comCode);
		
		popup = popupService.retrievePopup(popup);
		log.info("popup : " + popup);
		return popup;
	}
	
	@RequestMapping("/groupware/index.do")
	public String defaultIndex() {
		log.info("Groupware Index Page Load...");
		return "groupware/index";
	}
}
