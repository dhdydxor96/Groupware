package kr.or.ddit.autumn.management.group.department.controller;

import java.util.List;

import javax.validation.Valid;

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
import kr.or.ddit.autumn.management.group.department.service.DepartmentService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 부서 수정 컨트롤러
 *
 */

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/management/group/department/departmentUpdate.do")
public class DepartmentUpdateController {
	private final DepartmentService service;

	@GetMapping
	public String updateForm(Authentication authentication,@RequestParam(name = "what", required = true) String depId, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		DepartmentVO department = service.retrieveDepartment(depId);
		department.setComCode(comCode);
		List<DepartmentVO> departmentList = service.departmentList(department);
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("department", department);
		return "management/group/departmentEdit";
	}

	@PostMapping
	public String departmentUpdate(Authentication authentication, @ModelAttribute("department") DepartmentVO department,
			BindingResult errors, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		department.setComCode(comCode);

		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyDepartment(department);
			String message = null;
			switch (result) {
			case OK:
				viewName = "redirect:/management/group/department/departmentView.do?what=" + department.getDepId();
				break;
			default:
				message = "서버 오류";
				viewName = "management/group/departmentEdit";
				break;
			}
			model.addAttribute("message", message);
		} else {
			viewName = "management/group/departmentEdit";
		}
		return viewName;
	}
}
