package kr.or.ddit.autumn.management.base.controller;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.management.base.service.PopupManageService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PopUpVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/base")
@RequiredArgsConstructor
public class PopupController {
	
	private final PopupManageService service;
	
	@ModelAttribute("popup")
	public PopUpVO popup(
				@AuthenticationPrincipal(expression="realUser") CompanyVO company) {
		
		PopUpVO popup = new PopUpVO();
		
		log.info("@ModelAttribute 메소드 실행.");
		String comCode = company.getComCode();
		popup.setComCode(comCode);
		
		popup = service.retrievePopup(popup);
		AttatchVO attatch = service.retrieveAttatch(company.getComCode());
		popup.setAttatch(attatch);
		
		log.info("popup : " + popup);
		return popup;
	}
	
	// 팝업 관리 UI
	@GetMapping("/popup.do")
	public String popupUI() {
		
		return "management/base/registPopup";
	}
	
	@PostMapping("/popup.do")
	public String popUpInsert(
				@ModelAttribute("popup") PopUpVO popup
			,	Errors errors	
			,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
			,	Model model
		) {
		String comCode = company.getComCode();
		popup.setComCode(comCode);
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@ 새로 등록할 공지 정보 확인: " + popup.toString() + "@@@@@@@@@@@@@@@@@@@@@@");
		
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.creatPopup(popup);
			switch (result) {
			case OK:
				viewName = "redirect:/management/base/popup.do";
				break;	
			default:
				model.addAttribute("message", "서버 오류, 잠시후 다시 시도해주세요.");
				viewName = "management/base/registPopup";
				break;
			}
		}else {
			viewName = "management/base/registPopup";
		}
		return viewName;
	}
	
	@RequestMapping(value = "/popupDetail.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PopUpVO popupDetail(
				@ModelAttribute("popup")	PopUpVO popup
			,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
		) {
		
		String comCode = company.getComCode();
		popup.setComCode(comCode);
		
		popup = service.retrievePopup(popup);
		log.info("popup : " + popup);
		
		return popup;
	}
	
	@RequestMapping("/checkPopUp.do")
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
	}
	
	@RequestMapping(value="/modifyPopupSta.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String modifyPopupSta(
				PopUpVO popup
			,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
			) {
		
		log.info("popup : " + popup);
		popup.setComCode(company.getComCode());
		
		ServiceResult result = service.modifyPopup(popup);
		System.out.println("왔는지 확인 00000000000000 result : " + result);
			switch (result) {
			case OK:
					System.out.println("왔는지 확인 11111111111111");
					return "OK";
			default:
					System.out.println("왔는지 확인 22222222222222");
					return "Fail";
			}
	}
	
}