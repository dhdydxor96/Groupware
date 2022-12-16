package kr.or.ddit.autumn.groupware.profile.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.employee.service.EmployeeService;
import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Controller
@RequestMapping("/groupware/profile")
public class ProfileConditionController {
	@Inject
	EmployeeService service;

	//로그아웃 할때 offline상태 만들기
	@PostMapping(value="/logout.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult logout(Authentication authentication) {

		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO employee = adapter.getRealUser();
		
		ServiceResult result = service.offlineEmployee(employee.getEmpId());
	
		return result;
	}
	
	//자리비움 상태 만들기
	//나중에 validate랑 에러 메세지로 바꾸기
	@PostMapping(value="/condition.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ServiceResult profileAway(@RequestParam("empSta") String empSta
									,Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO employee = adapter.getRealUser();
		ServiceResult result;
		if(empSta.equals("1")) {
		 result = service.onlineEmployee(employee.getEmpId());
		}else {
		 result = service.awayEmployee(employee.getEmpId());	
		}
		return result;
	}

}
