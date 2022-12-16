package kr.or.ddit.autumn.management.group.employee.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.department.service.DepartmentService;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeePowerService;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeeService;
import kr.or.ddit.autumn.management.group.job.service.JobService;
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
public class EmployeeInsertController {
	
	private final ManagementEmployeeService service;
	private final ManagementEmployeePowerService powService;
	
	@ModelAttribute("employee")
	public EmployeeVO employee() {
		log.info("@ModelAttribute 메소드 실행.");
		return new EmployeeVO();
	}
	
	@GetMapping("/employeeInsert.do")
	public String employeeForm(
			Authentication authentication,
			@ModelAttribute("employee") EmployeeVO employee
			, Model model
			) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		List<DepartmentVO> departmentList = service.retrieveDepartmentList(comCode);
		List<JobVO> jobList = service.retrieveJobList(comCode);
		model.addAttribute("departmentList" , departmentList);
		model.addAttribute("jobList", jobList);
		
		
		log.info("Get 메소드 핸들러 employeeForm 실행");
		return "management/group/employeeForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method=RequestMethod.GET)
	public int idChk(EmployeeVO employee, @RequestParam(name="empId") String empId) {
		employee.setEmpId(empId);
		int result = service.idCheck(employee);
		return result;
	}
	
	@PostMapping("/employeeInsert.do")
	public String employeeInsert(
		Authentication authentication,
		@ModelAttribute("employee") EmployeeVO emp
		, Errors errors
		, Model model
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		emp.setComCode(comCode);
		
		log.info("Post 메소드 핸들러 departmentInsert 실행");
		String viewName = null;

		if (!errors.hasErrors()) {
			ServiceResult result = service.createEmployee(emp);
			ServiceResult powResult = powService.createUser(emp.getEmpId());

			if (result.equals(ServiceResult.OK) && powResult.equals(ServiceResult.OK)) {
				viewName = "redirect:/management/group/employee/employeeView.do?what=" + emp.getEmpId();
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "management/group/employeeForm";
			}
		} else {
			viewName = "management/group/employeeForm";
		}
		return viewName;
	}
}