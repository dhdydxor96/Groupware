package kr.or.ddit.autumn.management.menu.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.management.menu.service.NoticeManagerService;
import kr.or.ddit.autumn.vo.NoticeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class NoticeManageDeleteController {
	private final NoticeManagerService service;
	
	@PostMapping(value="/noticeDeletes.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> deleteNotice(
			@RequestBody int[] nocNos
			, Errors errors
			, Model model
		){
		Map<String, Object> result = new HashMap<String, Object>();
		
		log.info("@@@@@@@@@@@@@@@@@@@ 호출 확인 @@@@@@@@@@@@@@@@@@@");
		
		for(int i=0; i< nocNos.length; i++) {
			result.put("message", service.removeNotices(nocNos[i]));
		}
		return result;
	}
	
	@PostMapping("/noticeDelete.do")
	public String NoticeDelete(
			@Validated(DeleteGroup.class) NoticeVO notice
			, Errors errors, Model model
			, RedirectAttributes redirectAttributes) {
		String viewName = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.removeNotice(notice);
			switch (result) {
			case OK:
				viewName = "redirect:/management/menu/noticeManage.do";
				break;
			default:
				message = "서버 오류, 잠시후 다시 시도해주세요.";
				viewName = "redirect:/management/menu/noticeManageDetail?what="+notice.getNocNo();
				break;
			}
		}else {
			message = "누락 데이터 발생";
			viewName = "redirect:/management/menu/noticeManageDetail?what="+notice.getNocNo();
		}
		redirectAttributes.addFlashAttribute("message", message);
		return viewName;
	}
}
