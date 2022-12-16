package kr.or.ddit.autumn.management.group.department.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.department.service.DepartmentService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/management/group/department/departmentDelete.do")
public class DepartmentDeleteController {
	private final DepartmentService service;
	
	@GetMapping
	public String departmentDelete(
		Authentication authentication,
		@RequestParam(name="what", required=true) String depId
		,@ModelAttribute("department") DepartmentVO department
		, RedirectAttributes redirectAttributes
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		department.setComCode(comCode);
		
		department.setDepId(depId);
		service.removeDepartment(department);
		return "redirect:/management/group/department/departmentList.do";
	}
	
}
