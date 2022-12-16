package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.management.menu.service.NoticeManagerService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class NoticeManagerInsertController {

	private final NoticeManagerService service;

	@ModelAttribute("notice")
	public NoticeVO notice(Authentication authentication) {
		
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO authCom = adapter.getRealUser();
		
		log.info(authCom.getComCode());

		NoticeVO notice = new NoticeVO();
		
		String comCode = authCom.getComCode();
		notice.setComCode(comCode);
		
		System.out.println("@@@@@@@@@@@@@@@@ "+notice.getComCode()+"@@@@@@@@@@@@@@@@@@@@");
		
		return notice;
	}

	@GetMapping("/noticeInsert.do")
	public String noticeForm() {

		return "management/menu/noticeManageForm";
	}

	@PostMapping("/noticeInsert.do")
	public String communityInsert(
				@Validated(InsertGroup.class) @ModelAttribute("notice") NoticeVO notice
			,	BindingResult errors	
			,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
			,	Model model				
		) {
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@ 호출 11111 @@@@@@@@@@@@@@@@@@@@@@");
		
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createNoticeBymanager(notice);
			switch (result) {
			case OK:
				viewName = "redirect:/management/menu/noticeManage.do";
				break;

			default:
				model.addAttribute("message", "서버 오류, 잠시후 다시 시도해주세요.");
				viewName = "management/menu/noticeManageForm";
				break;
			}
		}else {
			viewName = "management/menu/noticeManageForm";
		}
		return viewName;
	}
}
