package kr.or.ddit.autumn.groupware.attendance.controller;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.AttendPrivacyService;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/groupware/attendance/my/privacy")
public class MyPrivacySelectController {

	private final AttendPrivacyService service;
	
	// ================================
	// * 내 인사 정보 확인
	// ================================
	@RequestMapping("/myPrivacyList.do")
	public String myPrivacyList(Authentication authentication, Model model) {
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		AttendEmployeeVO empInfo = service.retrieveMyPrivacyInfo(empId);
		
		model.addAttribute("empInfo",empInfo);
		
		return "groupware/attendance/myprivacyList";
	}
	
	// ================================
	// * 내 인사정보 확인 - AJAX
	// ================================
	@ResponseBody
	@RequestMapping(value="/myPrivacyList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public AttendEmployeeVO myPrivacyInfo(Authentication authentication, @RequestParam("who") String empId) {
		
		AttendEmployeeVO empInfo = service.retrieveMyPrivacyInfo(empId);
		
		return empInfo;
	}
}
