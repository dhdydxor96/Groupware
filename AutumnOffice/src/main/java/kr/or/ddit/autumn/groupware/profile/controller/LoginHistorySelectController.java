package kr.or.ddit.autumn.groupware.profile.controller;

import java.util.List;

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

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.groupware.attendance.vo.PeriodSearchVO;
import kr.or.ddit.autumn.groupware.profile.service.GroupwareProfileService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/profile")
@RequiredArgsConstructor
public class LoginHistorySelectController {
	
	private final GroupwareProfileService service;
	
	@GetMapping("/loginHistoryList.do")
	public String loginHistoryUI() {
		return "groupware/profile/loginHistoryList";
	}
	
	@PostMapping(value="/loginHistoryList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public AttendPagingVO<LogVO> loginHistoryInfo(Authentication authentication, Model model,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") PeriodSearchVO simpleCondition){
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		AttendPagingVO<LogVO> pagingVO = new AttendPagingVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setEmpId(empId);
		int totalRecord = service.retrieveLoginIpInfoTotalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<LogVO> logInfoList = service.retrieveLoginIpInfo(pagingVO);
		pagingVO.setDataList(logInfoList);
		
		
		return pagingVO;
		
	}
}
