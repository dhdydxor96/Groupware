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
@RequestMapping("/management/group/employee/employeeUpdate.do")
public class EmployeeUpdateController {
	private final ManagementEmployeeService service;
	
	@GetMapping
	public String updateForm(Authentication authentication,
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
		return "management/group/employeeEdit";
	}
	
	@PostMapping
	public String employeeUpdate(Authentication authentication, @ModelAttribute("employee") EmployeeVO emp,
			BindingResult errors, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		emp.setComCode(comCode);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyEmployee(emp);
			String message = null;
			switch (result) {
			case OK:
				viewName = "redirect:/management/group/employee/employeeView.do?what=" + emp.getEmpId();
				break;
			default:
				message = "서버 오류";
				viewName = "management/group/employeeEdit";
				break;
			}
			model.addAttribute("message", message);
		} else {
			viewName = "management/group/employeeEdit";
		}
		return viewName;
	}
}
