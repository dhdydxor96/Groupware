package kr.or.ddit.autumn.management.base.controller;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.management.base.service.PopupManageService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PopUpVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/base")
@RequiredArgsConstructor
public class GroupPopupController {
	
	private final PopupManageService service;
	
	@ModelAttribute("popup")
	public PopUpVO popup(
				@AuthenticationPrincipal(expression="realUser") EmployeeVO employee) {
		
		PopUpVO popup = new PopUpVO();
		
		log.info("@ModelAttribute 메소드 실행.");
		String comCode = employee.getComCode();
		popup.setComCode(comCode);
		
		popup = service.retrievePopup(popup);
		log.info("popup : " + popup);
		return popup;
	}
	
	@RequestMapping(value = "/usePopupDetail.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PopUpVO popupDetail(
			@ModelAttribute("popup")	PopUpVO popup
			,	@AuthenticationPrincipal(expression="realUser") EmployeeVO employee
			) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 왔는지 확인 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		String comCode = employee.getComCode();
		popup.setComCode(comCode);
		
		popup = service.retrievePopup(popup);
		log.info("@@@@@@@@@ 팝업 공지 확인 @@@@@@@@@@ : " + popup);
		
		return popup;
	}
	
/*	@RequestMapping("/checkPopUp.do")
	public String ckhPopup(
				RedirectAttributes redirectAttributes
			,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
		)throws IOException{
		
		PopUpVO popup = new PopUpVO();
		
		String comCode = company.getComCode();
		popup.setComCode(comCode);
		
		popup = service.retrievePopup(popup);
		log.info("popup : " + popup);
		
		redirectAttributes.addFlashAttribute("popup", popup);
		return "management/base/registPopup";
//		return "index";
	}	*/
	
}