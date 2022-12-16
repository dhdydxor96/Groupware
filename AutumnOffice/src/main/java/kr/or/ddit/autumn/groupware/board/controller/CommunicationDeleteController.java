package kr.or.ddit.autumn.groupware.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.groupware.board.service.CommunicationService;
import kr.or.ddit.autumn.vo.PostVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CommunicationDeleteController {
	private final CommunicationService service;
	
	@PostMapping("groupware/board/communicationDelete.do")
	public String communityDelete(
				@Validated(DeleteGroup.class) @ModelAttribute("post") PostVO post 
			, Errors errors, Model model
			, RedirectAttributes redirectAttributes) {
		String viewName = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.removePost(post);
			switch (result) {
			case OK:
				viewName = "redirect:/groupware/board/communicationList.do";
				break;
			default:
				message = "서버 오류, 잠시후 다시 시도해주세요.";
				viewName = "redirect:/groupware/board/communicationView.do?what="+post.getPoNo();
				break;
			}
		}else {
			message = "누락 데이터 발생";
			viewName = "redirect:/groupware/board/communicationView.do?what="+post.getPoNo();
		}
		redirectAttributes.addFlashAttribute("message", message);
		return viewName;
	}
}
