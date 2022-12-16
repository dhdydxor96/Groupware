package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.groupware.resource.vo.ResourceInfoVO;
import kr.or.ddit.autumn.management.menu.service.ResourceManageService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.MeetRoomVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class ResourceManageUpdateController {

	private final ResourceManageService service;

	// ================================
	// * 관리자페이지 - 회의실 수정 UI
	// ================================
	@GetMapping("/resourceManageUpdate.do")
	public String resourceManageUI(@RequestParam("what") int meetNo, Model model ) {
		
		ResourceInfoVO info = service.retrieveMeetInfo(meetNo);
		
		model.addAttribute("meetInfo", info);
		
		return "management/menu/resourceManageEdit";
	}
	
	// ================================
	// * 회의실 수정하기 (회의실이미지+회의실+회의실상세정보)
	// ================================
	@PostMapping(value="/resourceManageUpdate.do")
	public String resourceMeetRoomList(ResourceInfoVO meetInfo, Authentication authentication, Model model){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		log.info("회의실 수정할 때 파라미터 정보 {}", meetInfo);
		
		meetInfo.setComCode(comCode);
	
		// 회의실 수정하기
		ServiceResult result = service.updateMeetInfo(meetInfo); 
		
		// 만약 회의실이 수정되지 않았다면
		if(result.equals(ServiceResult.OK)) {
			return "redirect:/management/menu/resourceManageView.do?what="+meetInfo.getMeetNo();
		}else {
			model.addAttribute("meetInfo", meetInfo);
			return "management/menu/resourceManageEdit";
		}
		
	}
}
