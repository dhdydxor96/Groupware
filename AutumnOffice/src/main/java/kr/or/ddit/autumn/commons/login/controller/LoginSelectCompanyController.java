package kr.or.ddit.autumn.commons.login.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.service.LoginSelectCompanyService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@RequestMapping("/commons/login")
@Controller
public class LoginSelectCompanyController {

	@Inject
	private LoginSelectCompanyService service;
	
	@RequestMapping(value="/checkCompany.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CompanyVO> checkCompany(){
		
		List<CompanyVO> list = service.companyCheck();
		
		return list;
	}
	
	
}
