package kr.or.ddit.autumn.management.wareservice.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.wareservice.service.ServiceHistoryService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/management/wareservice")
public class ServiceHistoryController {
	
	private final ServiceHistoryService service;
	// 서비스 내역 확인 UI
	@GetMapping("/serviceHistoryList.do")
	public String serviceHistoryUI() {
		return "management/wareservice/serviceHistoryList";
	}
	
	@GetMapping(value="/serviceHistoryList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ConsultingServiceVO> serviceHistoryList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		
		PagingVO<ConsultingServiceVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.retrieveServiceHistoryCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ConsultingServiceVO> serviceHistoryList = service.retrieveServiceHistroyList(pagingVO);
		pagingVO.setDataList(serviceHistoryList);
		
		return pagingVO;
	}
	
	@GetMapping("/serviceHistoryView.do")
	public ModelAndView departmentView(Authentication authentication,
		@RequestParam(name="what", required=true) String serCode) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		
		ConsultingServiceVO serviceHistory = service.retrieveServiceHistory(serCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("serviceHistory", serviceHistory);
		mav.setViewName("management/wareservice/serviceHistoryView");
		return mav;
	}
}
