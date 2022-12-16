package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.management.menu.service.NoticeManagerService;
import kr.or.ddit.autumn.vo.NoticeVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class NoticeManagerUpdateController {
	private final NoticeManagerService service;
	
	@GetMapping("/noticeUpdate.do")
	public String noticeForm(
			@RequestParam(required=true, name="what") int nocNo
			  , NoticeVO notice, Model model
		) {
		notice = service.retrieveNoticeForEdit(nocNo);
		model.addAttribute("notice", notice);
		
		return "management/menu/noticeManageEdit";
	}
	
	@PostMapping("/noticeUpdate.do")
	public String noticeUpdate(
			@Validated(UpdateGroup.class) @ModelAttribute("notice") NoticeVO notice
			, Errors errors
			, Model model
	) {
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyNotice(notice);
			switch (result) {
			case OK:
				viewName = "redirect:/management/menu/noticeView.do?what="+notice.getNocNo();
				break;

			default:
				model.addAttribute("message", "서버 오류, 잠시후 다시 시도해주세요.");
				viewName = "management/menu/noticeManageEdit";
				break;
			}
		}else {
			viewName = "management/menu/noticeManageEdit";
		}
		return viewName;
	}

}
