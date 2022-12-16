package kr.or.ddit.autumn.groupware.attendance.controller;

import java.security.Principal;
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
import kr.or.ddit.autumn.groupware.attendance.service.MyAnnualService;
import kr.or.ddit.autumn.groupware.attendance.vo.AnnualRecodeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AnnualVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.groupware.attendance.vo.PeriodSearchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.SearchVO;

@Controller
@RequestMapping("/groupware/attendance/my/annual")
public class MyAnnualSelectController {
	
	@Inject
	private MyAnnualService service;
	
	// 현재 날짜 구하기 
	@RequestMapping(value="/myAnnualList.do", method=RequestMethod.GET)
	public String listUI(Model model) {
        LocalDate now = LocalDate.now();
 
        // 연도
        int year = now.getYear();
        
        String nowYear = year +"년";
        
        model.addAttribute("nowYear", nowYear);
		return "groupware/attendance/myannualList";
	}
	
	// 내 연차 내역 확인 -- 연차 통계
	@RequestMapping(value="/myAnnualList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody
	public AnnualVO myAnnualList(Authentication authentication) {
		// 이름, 직위, 연차정보 가져오기
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		AnnualVO annual = service.selectMyAnnual(empId);
		
		// 사용 연차 내역
		
		// 형이 필요한 컬럼을 기반으로 VO 만들기 -> DAO 메소드 만들기 -> mapper xml -> service 만들기(잔여 연차 계산) 
		// -> controller에서 model에 넣기
		return annual;
	}
	
	// 내 연차 사용 내역
	@RequestMapping(value="/myAnnualUseList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public AttendPagingVO<AnnualRecodeVO> myAnnualUserList(Authentication authentication, Model model,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") PeriodSearchVO simpleCondition){
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		AttendPagingVO<AnnualRecodeVO> pagingVO = new AttendPagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		
		pagingVO.setEmpId(empId);
		int totalRecord = service.retrieveTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AnnualRecodeVO> annualUseList = service.retrieveMyAnnualRecodeList(pagingVO);
		pagingVO.setDataList(annualUseList);
		
		return pagingVO;
	}
	
}
