package kr.or.ddit.autumn.management.wareservice.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.wareservice.service.UserInfoHistoryService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/wareservice")
public class UserInfoHistoryController {

	@Inject
	private UserInfoHistoryService service;
	
	@GetMapping("/userInfoHistoryList.do")
	public String userInfoHistoryList() {
		return "management/wareservice/userInfoHistoryList";
	}
	
	@GetMapping(value="/userInfoHistoryList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<ConsultingServiceVO> userInfoHistoryList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		PagingVO<ConsultingServiceVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setComcode(comCode);
		pagingVO.setSimpleCondition(simpleCondition);
		log.info("페이징 들어오나",currentPage, simpleCondition, comCode);
		log.info("페이징 되니 {}", pagingVO.getComCode());
		
		int totalRecord = service.infoTotalRecode(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ConsultingServiceVO> userInfoHistoryList = service.infoServiceList(pagingVO);
		pagingVO.setDataList(userInfoHistoryList);
		
		return pagingVO;
	}
	
	
}
