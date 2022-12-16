package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.management.menu.service.ResourceManageService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.MeetRoomVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class ResourceManageInsertController {

	private final ResourceManageService service;
	
	// ================================
	// * 관리자페이지 - 회의실 등록 UI
	// ================================
	@GetMapping("/resoureManageInsert.do")
	public String resourceMeetForm() {
		return "management/menu/resourceManageForm";
	}
	
	// ================================
	// * 회의실 등록하기 (회의실 이미지+회의실+회의실 상세정보)
	// ================================
	@PostMapping("/resoureManageInsert.do")
	public String resourceMeetInsert(ResourceInfoVO meetInfo, Authentication authentication, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		log.info("회의실 등록할 때 파라미터 정보 {}", meetInfo);
		
		meetInfo.setComCode(comCode);
	
		// 회의실 등록하기
		ServiceResult result = service.createMeetRoom(meetInfo); 
		
		// 만약 회의실이 등록되지 않았다면
		if(result.equals(ServiceResult.OK)) {
			return "redirect:/management/menu/resourceManage.do";
		}else {
			model.addAttribute("meetInfo", meetInfo);
			return "management/menu/resourceManageForm";
		}
		
	}
}
