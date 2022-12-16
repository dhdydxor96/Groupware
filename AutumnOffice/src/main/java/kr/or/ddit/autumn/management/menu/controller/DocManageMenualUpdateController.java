package kr.or.ddit.autumn.management.menu.controller;

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
import kr.or.ddit.autumn.management.menu.service.DocManageMenualService;
import kr.or.ddit.autumn.vo.RuleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu/docManageMenualUpdate.do")
public class DocManageMenualUpdateController {
	
	private final DocManageMenualService service;
	
	@Inject
	public DocManageMenualUpdateController(DocManageMenualService service) {
		super();
		this.service = service;
	}
	
	@GetMapping
	public String updateForm(
		@RequestParam(name="what", required=true) int rulNo
		, Model model
	) {
		RuleVO rule = service.retrieveRule(rulNo);
		model.addAttribute("rule", rule);
		return "management/menu/docManageMenualEdit";
	}
	
	@PostMapping
	public String ruleUpdate(
		@Validated(UpdateGroup.class) @ModelAttribute("rule") RuleVO rule
		, Model model
		, BindingResult errors
	) {
		String viewName = null;
		log.info("에러스 : {}",errors);
		if(!errors.hasErrors()) {
			int result = service.modifyRule(rule);
			String message = null;
			
			if(result > 0) {
				viewName = "redirect:/management/menu/docManageMenualView.do?what="+rule.getRulNo();
			}else {
				message = "서버 오류";
				viewName = "management/menu/docManageMenualEdit";
			}
			model.addAttribute("message", message);
		}else {
			viewName = "management/menu/docManageMenualEdit";
		}
		return viewName;
	}
}
