package kr.or.ddit.autumn.management.menu.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
public class ResourceManageController {
	
	private final ResourceManageService service;

	// ================================
	// * 관리자페이지 - 회의실 관리 UI
	// ================================
	@GetMapping("/resourceManage.do")
	public String resourceManageUI() {
		return "management/menu/resourceManage";
	}
	
	// ================================
	// * 회의실 리스트 띄우기
	// ================================
	@RequestMapping(value="/resourceManage.do" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MeetRoomVO> resourceMeetRoomList(Authentication authentication ,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			){
		
		log.info("simpleCondition값 {}",simpleCondition);
		
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<MeetRoomVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setComcode(comCode);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.selectTotalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<MeetRoomVO> meetRoomList = service.retrieveMeetRoomList(pagingVO);
		pagingVO.setDataList(meetRoomList);
		
		return pagingVO;
	}
	
	// ================================
	// * 회의실 상세정보
	// ================================
	@RequestMapping("/resourceManageView.do")
	public String resourceMeetInfo(@RequestParam("what") int meetNo, Model model) {
		
		ResourceInfoVO meetInfo = service.retrieveMeetInfo(meetNo);
		
		model.addAttribute("meetInfo", meetInfo);
		
		return "management/menu/resourceManageView";
	}
}
