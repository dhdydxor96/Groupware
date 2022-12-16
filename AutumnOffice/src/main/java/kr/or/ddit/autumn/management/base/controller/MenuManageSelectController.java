/*package kr.or.ddit.autumn.management.base.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.vo.DepAnnualVO;
import kr.or.ddit.autumn.management.base.service.MenuManageService;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Controller
public class MenuManageSelectController {

	@Inject
	private MenuManageService service;
	
	@RequestMapping("/management/base/menu/menuManage.do")
	public String empAllList(Authentication authentication, Model model) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String depId = realuser.getDepId();
		
		List<EmployeeVO> empAllList = service.AllEmployeeList(depId);
		model.addAttribute("empAllList",empAllList);
		
		return "management/base/menuManage";
	}
}
*/