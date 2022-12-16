package kr.or.ddit.autumn.commons.login.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.service.LoginFindPasswordService;
import kr.or.ddit.autumn.commons.login.service.LoginMailSendService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/commons/login")
@Controller
@RequiredArgsConstructor
public class LoginFindPasswordController {

	private final LoginFindPasswordService service;
	
	private final LoginMailSendService serviceMail;
	
	
	@PostMapping(value="/employeeCheck.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int employeeCheck(EmployeeVO employeeVO) {
		
		int rowcnt = 0;
		int result = 0;
		
		rowcnt = service.checkEmp(employeeVO);
		if(rowcnt == 1 ) {			
			String temp = serviceMail.joinEmail(employeeVO.getEmpMail());
			employeeVO.setEmpPass(temp);
			result = service.updateEmp(employeeVO);
			return result;
		}else {
			return rowcnt;
		}
						
	}
}
