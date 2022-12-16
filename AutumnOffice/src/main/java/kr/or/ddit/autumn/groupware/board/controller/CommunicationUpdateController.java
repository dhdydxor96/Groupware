package kr.or.ddit.autumn.groupware.board.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.groupware.board.dao.BoardDAO;
import kr.or.ddit.autumn.groupware.board.service.CommunicationService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PostVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class CommunicationUpdateController{
	private final CommunicationService service;
	private final BoardDAO boardDAO;

	@GetMapping("/groupware/board/communicationUpdate.do")
	public String communityupdateForm(
			@RequestParam(required=true, name="what") int poNo
		,	@AuthenticationPrincipal(expression="realUser") EmployeeVO employee
		  , PostVO post, Model model
		){

		post = service.retrievePostForEdit(poNo);
		post.setBoardList(boardDAO.selectCategory(employee.getComCode()));
		
		model.addAttribute("post", post);
		
		return "groupware/board/communicationEdit";
	}
	
	@PostMapping("/groupware/board/communicationUpdate.do")
	public String communityUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("post") PostVO post
			, Errors errors
			, Model model
	) {
		String viewName = null;
		
		log.info(post.getBoCode());
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyPost(post);
			switch (result) {
			case OK:
				viewName = "redirect:/groupware/board/communicationView.do?what="+post.getPoNo();
				break;

			default:
				model.addAttribute("message", "서버 오류, 잠시후 다시 시도해주세요.");
				viewName = "groupware/board/communicationEdit";
				break;
			}
		}else {
			viewName = "groupware/board/communicationEdit";
		}
		return viewName;
	}
}
