package kr.or.ddit.autumn.groupware.attendance.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.AttendStatusService;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.vo.EmpStatusVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/groupware/attendance/my/status")
@RequiredArgsConstructor
@Slf4j
public class MyStatusSelectController {
	
	private final AttendStatusService service;
	
	
	// ================================
	// * 내 근태 현황 확인하기
	// ================================
	@RequestMapping("/myStatusList.do")
	public String myStatus(Authentication authentication, Model model) {
		// 이름, 직위, 연차정보 가져오기
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		List<StatusVO> statusList = service.retrieveMyStatus(empId);
		
		model.addAttribute("statusList",statusList);
		
		return "groupware/attendance/mystatusList";
	}
	
	
	// ================================
	// * 출근시간 기록하기
	// ================================
	@RequestMapping(value="/goToWork.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int myGoToWork(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		ServiceResult result = service.createMyStartWork(empId);
		
		if(result.equals(ServiceResult.OK)) {
			return 1;
		}else {
			return 0;
		}
	}
	
	// ================================
	// * 출근 버튼 중복 방지용
	// ================================
	@RequestMapping(value="/goToWorkList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int myGoToWorkOverlap(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		int num = service.retrieveMyStartWorkOverlap(empId);
		
		return num;
	}
	
	// ================================
	// * 퇴근시간 기록하기
	// ================================
	@RequestMapping(value="/endWork.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int myEndWork(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		ServiceResult result = service.updateMyEndWork(empId);
		
		if(result.equals(ServiceResult.OK)) {
			return 1;
		}else {
			return 0;
		}
	}
	
	// ================================
	// * 나의 업무정보 확인하기 (근태메뉴 상단)
	// ================================
	@RequestMapping(value="/myWorkInfo.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public StatusVO myWorkInfo(Authentication authentication) {
		//로그인한 나의정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		StatusVO status = service.retrieveMyWorkInfo(empId);
		
		return status;
	}
	
	// ================================
	// * 이번주 누적/초과/잔여 계산
	// ================================
	@RequestMapping(value="/myStatusTime.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public StatusVO myStatusTime(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		StatusVO status =  service.retrieveMyStatusSum(empId);
		
		log.info(status.getSumSta() +"," + status.getOverTime());
		return status;
	}
	
	// ================================
	// * 이번달 누적/초과 계산
	// ================================
	@RequestMapping(value="/myStatusMonthTime.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public StatusVO myStatusMonthTime(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		StatusVO status =  service.retrieveMyStatusSumMonth(empId);
		
		log.info(status.getSumSta() +"," + status.getOverTime());
		return status;
	}
}


