package kr.or.ddit.autumn.web.advice.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.web.advice.service.AdviceService;
import kr.or.ddit.autumn.web.vo.AdviceVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 *	상담요청 추가 컨트롤러 
 *
 */

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/web/advice/adviceInsert.do")
public class AdviceInsertController {
	private final AdviceService service;
	
	@Inject
	private WebApplicationContext context;
	
	@ModelAttribute("advice")
	public AdviceVO advice() {
		log.info("@ModelAttribute 메소드 실행.");
		return new AdviceVO();
	}
	
	@GetMapping
	public String adviceForm(@ModelAttribute("advice") AdviceVO advice) {
		log.info("Get 메소드 핸들러 adviceForm 실행");
		return "web/advice/adviceForm";
	}
	
	@PostMapping
	public String adviceInsert(@Validated(InsertGroup.class) @ModelAttribute("advice")
		AdviceVO advice, Errors errors, Model model
	) {
		log.info("Post 메소드 핸들러 adviceInsert 실행");
String viewName = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createAdvice(advice);
			
			if(result.equals(ServiceResult.OK)) {
				viewName = "redirect:/web/advice/adviceView.do?what="+advice.getAdvNo();
			}else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "web/advice/adviceForm";
			}
		}else {
			viewName = "web/advice/adviceForm";
		}
		return viewName;
	}
}
