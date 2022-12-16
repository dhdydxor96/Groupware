package kr.or.ddit.autumn.web.matters.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.web.matters.service.MattersService;
import kr.or.ddit.autumn.web.vo.MattersVO;
import lombok.RequiredArgsConstructor;

/**
 *	문의사항 삭제 컨트롤러 
 *
 */

@RequiredArgsConstructor
@Controller
public class MattersDeleteController {
	private final MattersService service;
	@PostMapping("/web/matters/mattersDelete.do")
	public String mattersDelete(@Validated(DeleteGroup.class) MattersVO matters,BindingResult errors, RedirectAttributes redirectAttributes) {
		String viewName = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.removeMatters(matters);
			switch (result) {
			case INVALIDPASSWORD:
				message = "비번 오류";
				viewName = "redirect:/web/matters/mattersView.do?what="+matters.getMatNo();
				break;
			case OK:
				viewName = "redirect:/web/matters/mattersList.do";
				break;
				
			default:
				message = "서버 오류";
				viewName = "redirect:/web/matters/mattersView.do?what="+matters.getMatNo();
				break;
			}
		}else {
			message = "누락 데이터 발생";
			viewName = "redirect:/web/matters/mattersView.do?what="+matters.getMatNo();
		}
		redirectAttributes.addFlashAttribute("message", message);
		return viewName;
	}
}
