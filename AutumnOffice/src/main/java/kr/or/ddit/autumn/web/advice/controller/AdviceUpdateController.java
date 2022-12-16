package kr.or.ddit.autumn.web.advice.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.web.advice.service.AdviceService;
import kr.or.ddit.autumn.web.vo.AdviceVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import lombok.extern.slf4j.Slf4j;

/**
 *	상담요청 수정 컨트롤러 
 *
 */

@Slf4j
@Controller
@RequestMapping("/web/advice/adviceUpdate.do")
public class AdviceUpdateController {
	private final AdviceService service;
	
	@Inject
	public AdviceUpdateController(AdviceService service) {
		super();
		this.service = service;
	}
	
	@GetMapping
	public String updateForm(
		@RequestParam(name="what", required=true) int advNo
		, Model model
	) {
		AdviceVO advice = service.retrieveAdvice(advNo);
		model.addAttribute("advice", advice);
		return "web/advice/adviceEdit";
	}
	
	@PostMapping
	public String adviceUpdate(
		@Validated(UpdateGroup.class) @ModelAttribute("advice") AdviceVO advice
		, BindingResult errors
		, Model model
	) {
		String viewName = null;
		log.info("에러스 : {}",errors);
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyAdvice(advice);
			String message = null;
			switch (result) {
			case INVALIDPASSWORD:
				message = "비밀번호 오류";
				viewName = "web/advice/adviceEdit";
				break;
			case OK:
				viewName = "redirect:/web/advice/adviceView.do?what="+advice.getAdvNo();
				break;
			default:
				message = "서버 오류";
				viewName = "web/advice/adviceEdit";
				break;
			}
			model.addAttribute("message", message);
		}else {
			viewName = "web/advice/adviceEdit";
		}
		return viewName;
	}
}
