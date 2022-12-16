package kr.or.ddit.autumn.web.matters.controller;

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
import kr.or.ddit.autumn.web.matters.service.MattersService;
import kr.or.ddit.autumn.web.vo.MattersVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 *	문의사항 추가 컨트롤러 
 *
 */

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/web/matters/mattersInsert.do")
public class MattersInsertController {
	private final MattersService service;
	@Inject
	private WebApplicationContext context;
	
	@ModelAttribute("matters")
	public MattersVO matters() {
		log.info("@ModelAttribute 메소드 실행.");
		return new MattersVO();
	}
	
	@GetMapping
	public String mattersForm(@ModelAttribute("matters") MattersVO matters) {
		log.info("Get 메소드 핸들러 mattersForm 실행");
		return "web/matters/mattersForm";
	}
	
	@PostMapping
	public String mattersInsert(@Validated(InsertGroup.class) @ModelAttribute("matters") 
	MattersVO matters, Errors errors, Model model
	) {
		log.info("Post 메소드 핸들러 mattersInsert 실행");
		String viewName = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.creaeteMatters(matters);
			
			if(result.equals(ServiceResult.OK)) {
				viewName = "redirect:/web/matters/mattersView.do?what="+matters.getMatNo();
			}else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "web/matters/mattersForm";
			}
		}else {
			viewName = "web/matters/mattersForm";
		}
		return viewName;
	}
}
