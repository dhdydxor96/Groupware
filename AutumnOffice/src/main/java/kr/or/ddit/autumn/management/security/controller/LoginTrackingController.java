package kr.or.ddit.autumn.management.security.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.security.service.LoginTrackingService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.LogVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/management/security")
public class LoginTrackingController {
	
	@Inject
	private final LoginTrackingService service;
	// 로그인 추적 관리
	@GetMapping("/loginTracking.do")
	public String loginTrackingUI() {
		return "management/security/loginTracking";
	}
	
	@GetMapping(value="/loginTracking.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<LogVO> serviceHistoryList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		
		PagingVO<LogVO> pagingVO = new PagingVO<>(5,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = service.totalRecodeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<LogVO> loginTrackingList = service.loginTrackingList(pagingVO);
		pagingVO.setDataList(loginTrackingList);
		
		return pagingVO;
	}
}
