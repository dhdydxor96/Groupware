package kr.or.ddit.autumn.web.advice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.web.advice.service.AdviceService;
import kr.or.ddit.autumn.web.vo.AdviceVO;
import lombok.RequiredArgsConstructor;
/**
 *	상담요청 삭제 컨트롤러 
 *
 */
@RequiredArgsConstructor
@Controller
public class AdviceDeleteController {
	private final AdviceService service;
	
	@PostMapping("/web/advice/adviceDelete.do")
	public String adviceDelete(
		@Validated(DeleteGroup.class) AdviceVO advice
		, BindingResult errors
		, RedirectAttributes redirectAttributes
	) {
		String viewName = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.removeAdvice(advice);
			switch (result) {
			case INVALIDPASSWORD:
				message = "비번 오류";
				viewName = "redirect:/web/advice/adviceView.do?what="+advice.getAdvNo();
				break;
			case OK:
				viewName = "redirect:/web/advice/adviceList.do";
				break;
				
			default:
				message = "서버 오류";
				viewName = "redirect:/web/advice/adviceView.do?what="+advice.getAdvNo();
				break;
			}
		}else {
			message = "누락 데이터 발생";
			viewName = "redirect:/web/advice/adviceView.do?what="+advice.getAdvNo();
		}
		redirectAttributes.addFlashAttribute("message", message);
		return viewName;
	}
}
