package kr.or.ddit.autumn.management.group.employee.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeePowerService;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeeService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.JobVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/management/group/employee")
public class EmployeePowerInsertController {
	private final ManagementEmployeeService service;
	private final ManagementEmployeePowerService powService;
	
	@GetMapping("/powerHeadInsert.do")
	public String powerHeadForm(Authentication authentication,
			@ModelAttribute("employee") EmployeeVO employee
			,@RequestParam(name="what" , required=true) String empId, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		employee = service.retrieveEmployee(empId);
		
		List<DepartmentVO> departmentList = service.retrieveDepartmentList(comCode);
		List<JobVO> jobList = service.retrieveJobList(comCode);
		model.addAttribute("departmentList" , departmentList);
		model.addAttribute("jobList", jobList);
		
		model.addAttribute("employee", employee);
		return "management/group/powerHeadForm";
	}
	
	@PostMapping("/powerHeadInsert.do")
	public String powerHeadInsert(Authentication authentication, @ModelAttribute("employee") EmployeeVO emp,
			BindingResult errors, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		emp.setComCode(comCode);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyEmployee(emp);
			ServiceResult powResult = powService.createHead(emp.getEmpId());
			
			if (result.equals(ServiceResult.OK) && powResult.equals(ServiceResult.OK)) {
				viewName = "redirect:/management/group/employee/employeeView.do?what=" + emp.getEmpId();
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "management/group/employeeList";
			}
		} else {
			viewName = "management/group/employeeList";
		}
		return viewName;
	}
	
	@GetMapping("/powerDirectorInsert.do")
	public String powerDirectorForm(Authentication authentication,
			@ModelAttribute("employee") EmployeeVO employee
			,@RequestParam(name="what" , required=true) String empId, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		employee = service.retrieveEmployee(empId);
		
		List<DepartmentVO> departmentList = service.retrieveDepartmentList(comCode);
		List<JobVO> jobList = service.retrieveJobList(comCode);
		model.addAttribute("departmentList" , departmentList);
		model.addAttribute("jobList", jobList);
		
		model.addAttribute("employee", employee);
		return "management/group/powerDirectorForm";
	}
	
	@PostMapping("/powerDirectorInsert.do")
	public String powerDirectorInsert(Authentication authentication, @ModelAttribute("employee") EmployeeVO emp,
			BindingResult errors, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		emp.setComCode(comCode);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyEmployee(emp);
			ServiceResult powResult = powService.createDirector(emp.getEmpId());
			
			if (result.equals(ServiceResult.OK) && powResult.equals(ServiceResult.OK)) {
				viewName = "redirect:/management/group/employee/employeeView.do?what=" + emp.getEmpId();
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "management/group/employeeList";
			}
		} else {
			viewName = "management/group/employeeList";
		}
		return viewName;
	}
}
