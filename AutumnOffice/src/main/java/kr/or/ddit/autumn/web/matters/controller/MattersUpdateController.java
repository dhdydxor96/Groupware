package kr.or.ddit.autumn.web.matters.controller;

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
import kr.or.ddit.autumn.web.matters.service.MattersService;
import kr.or.ddit.autumn.web.vo.MattersVO;
import lombok.extern.slf4j.Slf4j;

/**
 *	문의사항 수정 컨트롤러 
 *
 */

@Slf4j
@Controller
@RequestMapping("/web/matters/mattersUpdate.do")
public class MattersUpdateController {
	private final MattersService service;
	
	@Inject
	public MattersUpdateController(MattersService service) {
		super();
		this.service = service;
	}
	
	@GetMapping
	public String updateForm(
		@RequestParam(name="what", required=true) int matNo
		, Model model
	) {
		MattersVO matters = service.retrieveMatters(matNo);
		model.addAttribute("matters", matters);
		return "web/matters/mattersEdit";
	}
	
	@PostMapping
	public String mattersUpdate(
		@Validated(UpdateGroup.class) @ModelAttribute("matters") MattersVO matters
		, BindingResult errors
		, Model model
	) {
		String viewName = null;
		log.info("에러스 : {}",errors);
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyMatters(matters);
			String message = null;
			switch (result) {
			case INVALIDPASSWORD:
				message = "비밀번호 오류";
				viewName = "web/matters/mattersEdit";
				break;
			case OK:
				viewName = "redirect:/web/matters/mattersView.do?what="+matters.getMatNo();
				break;
			default:
				message = "서버 오류";
				viewName = "web/matters/mattersEdit";
				break;
			}
			model.addAttribute("message", message);
		}else {
			viewName = "web/matters/mattersEdit";
		}
		return viewName;
	}
}
