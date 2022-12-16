package kr.or.ddit.autumn.groupware.board.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.groupware.board.dao.BoardDAO;
import kr.or.ddit.autumn.groupware.board.service.CommunicationService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PostVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class CommunicationInsertController {
	
	private final CommunicationService service;
	private final BoardDAO boardDAO;

	@ModelAttribute("post")
	public PostVO post(Authentication authentication) {
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper) authentication.getPrincipal();
		EmployeeVO authEmp = adapter.getRealUser();
		
		log.info(authEmp.getEmpId());
		
		PostVO post = new PostVO();
		
		String empId = authEmp.getEmpId();
		String comCode = authEmp.getComCode();
		
		post.setEmpId(empId);
		post.setBoardList(boardDAO.selectCategory(comCode));
		
/*		
 		PostVO post = new PostVO();
		post.setEmpId(employee.getEmpId());
		
		board.setComCode(employee.getComCode());
		post.setBoardList(boardDAO.selectCategory(board));
*/
		
		return post;
	}
	
	@GetMapping("/groupware/board/communicationInsert.do")
	public String postForm() {
		
		return "groupware/board/communicationForm";
	}
	
	@PostMapping("/groupware/board/communicationInsert.do")
	public String communityInsert(
				@Validated(InsertGroup.class) @ModelAttribute("post") PostVO post
			,	BindingResult errors
			,	Authentication authentication
			,   @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
			,	Model model				
			) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper) authentication.getPrincipal();
		EmployeeVO authEmp = adapter.getRealUser();
		
		String empId = authEmp.getEmpId();
		post.setEmp(authEmp);
		post.setEmpId(empId);
		
		String viewName = null;
		
		log.info(post.getBoCode());

		if(StringUtils.equals(post.getBoCode(), "카테고리 선택") || StringUtils.isBlank(post.getBoCode()) ) {
			model.addAttribute("error", "카테고리를 선택해주세요");
			return "groupware/board/communicationForm";
		}
		
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createPost(post);
			switch (result) {
			case OK:
				viewName = "redirect:/groupware/board/communicationList.do";
				break;	
			default:
				model.addAttribute("message", "서버 오류, 잠시후 다시 시도해주세요.");
				viewName = "groupware/board/communicationForm";
				break;
			}
		}else {
			viewName = "groupware/board/communicationForm";
		}
		return viewName;
	}
}
