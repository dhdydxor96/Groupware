package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.management.menu.service.DocManageMenualService;
import kr.or.ddit.autumn.vo.RuleVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class DocManageMenualDeleteController {
	
	private final DocManageMenualService service;
	@PostMapping("/management/menu/docManageMenualDelete.do")
	public String docManageMenualDelete(@Validated(DeleteGroup.class) RuleVO rule, RedirectAttributes redirectAttributes, BindingResult errors) {
		String viewName = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.removeRule(rule);
			switch (result) {
			case OK:
				viewName = "redirect:/management/menu/docManageMenualList.do";
				message = "Success";
				break;				
			default:
				message = "서버 오류";
				viewName = "redirect:/management/menu/docManageMenualView.do?what="+rule.getRulNo();
				break;
			}
		}else {
			message = "누락 데이터 발생";
			viewName = "redirect:/management/menu/docManageMenualView.do?what="+rule.getRulNo();
		}
		redirectAttributes.addFlashAttribute("message", message);
		return viewName;
	}
}
