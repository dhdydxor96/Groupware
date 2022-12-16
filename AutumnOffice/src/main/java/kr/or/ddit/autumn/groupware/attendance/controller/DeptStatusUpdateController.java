package kr.or.ddit.autumn.groupware.attendance.controller;

import java.text.ParseException;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.AttendStatusService;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Controller
public class DeptStatusUpdateController {

	@Inject
	private AttendStatusService service;
	
	// ================================
	// * 부서장/대표이사 한정 - 부서원의 근태 상태 변경
	// ================================
	@RequestMapping("/groupware/attendance/dept/status/updateDeptEmployeeStatus.do")
	public String updateDeptEmployeeInfo(Authentication authentication, StatusVO status, RedirectAttributes ratt) throws ParseException {
		
		// 로그인 정보 확인
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		status.setStaId(empId);
		
		ServiceResult result = service.updateDeptEmployeeInfo(status);
		
		if(result.equals(ServiceResult.FAIL)) {
			ratt.addFlashAttribute("message", "근태 상태 변경에 실패하였습니다.");
		}
		
		return "redirect:/groupware/attendance/dept/status/deptStatusList.do";
	}
}
