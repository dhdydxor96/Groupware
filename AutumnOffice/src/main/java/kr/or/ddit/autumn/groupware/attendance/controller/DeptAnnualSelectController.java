package kr.or.ddit.autumn.groupware.attendance.controller;

import java.time.LocalDate;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.DepAnnualService;
import kr.or.ddit.autumn.groupware.attendance.vo.DepAnnualVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/attendance/dept/annual")
public class DeptAnnualSelectController {
	
	@Inject
	private DepAnnualService service;

	// 부서 연차 현황 확인
//	@RequestMapping("/deptAnnualList.do")
//	public String deptAnnualList(Authentication authentication, Model model) {
//		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
//		EmployeeVO realuser = adapter.getRealUser();
//		String depId = realuser.getDepId();
//		
//		List<DepAnnualVO> depAnnualList = service.selectDepAnnual(depId);
//		model.addAttribute("depAnnualList",depAnnualList);
//		
//		return "groupware/attendance/deptAnnualList";
//	}
	
	@RequestMapping(value="/deptAnnualList.do", method=RequestMethod.GET)
	public String listUI(Model model) {
		 // 현재 날짜 구하기 (시스템 시계, 시스템 타임존)
        LocalDate now = LocalDate.now();
 
        // 연도
        int year = now.getYear();
        
        String nowYear = year +"년";
        
        model.addAttribute("nowYear", nowYear);
		
		return "groupware/attendance/deptAnnualList";
	}
	
	@RequestMapping(value="/deptAnnualList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<DepAnnualVO> deptAnnualList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition,
			Authentication authentication) {
		
		//로그인 내역
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String depId = realuser.getDepId();
		String comCode = realuser.getComCode();
		String powRole =null;
		
		//권한을 통해 인사정보를 확인할 대상 걸러내기
		if(realuser.getEmpRoles().contains("ROLE_HEAD")) {
			// 부서장의 권한으로 접근 시
			powRole = "ROLE_HEAD";
			
		}else if(realuser.getEmpRoles().contains("ROLE_CEO")) {
			// 이사급의 권한으로 접근시
			powRole = "ROLE_CEO";
			
		}
		
		// 페이징 처리
		PagingVO<DepAnnualVO> pagingVO = new PagingVO<>(5,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDepId(depId);
		pagingVO.setComcode(comCode);
		pagingVO.setPowRole(powRole);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.retrieveTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<DepAnnualVO> depAnnualList = service.retrieveDepAnnualList(pagingVO);
		
		log.info("사용연차 {}", depAnnualList);
		
		pagingVO.setDataList(depAnnualList);
		
		return pagingVO;
	}
	
	
}
