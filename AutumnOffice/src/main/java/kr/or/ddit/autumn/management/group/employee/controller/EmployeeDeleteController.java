package kr.or.ddit.autumn.management.group.employee.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeePowerService;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeeService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/management/group/employee")
public class EmployeeDeleteController {
	private final ManagementEmployeeService service;
	private final ManagementEmployeePowerService powService;
	
	@GetMapping("/employeeDelete.do")
	public String empDelete(
		Authentication authentication,
		@RequestParam(name="what", required=true) String empId
		, @ModelAttribute("employee") EmployeeVO employee
		,@ModelAttribute("power") PowerVO power
		, RedirectAttributes redirectAttributes
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		employee.setComCode(comCode);
		
		employee.setEmpId(empId);
		power.setEmpId(empId);
		powService.removePowerUser(power);
		powService.removePowerDirector(power);
		powService.removePowerHead(power);
		service.removeEmployee(employee);
		return "redirect:/management/group/employee/employeeList.do";
	}
	
	@GetMapping("/resignationDelete.do")
	public String resignationDelete(
		Authentication authentication,
		@RequestParam(name="what", required=false) String empId
		,@ModelAttribute("employee") EmployeeVO employee
		, RedirectAttributes redirectAttributes
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		employee.setComCode(comCode);
		
		employee.setEmpId(empId);
		service.removeResignation(employee);
		return("redirect:/management/group/employee/resignationList.do");
	}
	
	@GetMapping("/powerHeadDelete.do")
	public String powerHeadDelete(
		Authentication authentication,
		@RequestParam(name="what", required=true) int powNo
		,@ModelAttribute("employee") EmployeeVO employee
		,@ModelAttribute("power") PowerVO power
		, RedirectAttributes redirectAttributes
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		employee.setComCode(comCode);
		power.setPowNo(powNo);
		powService.removePowerHead(power);
		return "redirect:/management/group/employee/powerHeadList.do";
	}
	
	@GetMapping("/powerDirectorDelete.do")
	public String powerDirectorDelete(
			Authentication authentication,
			@RequestParam(name="what", required=true) int powNo
			,@ModelAttribute("employee") EmployeeVO employee
			,@ModelAttribute("power") PowerVO power
			, RedirectAttributes redirectAttributes
			) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		employee.setComCode(comCode);
		
		power.setPowNo(powNo);
		powService.removePowerDirector(power);
		return "redirect:/management/group/employee/powerDirectorList.do";
	}
}
