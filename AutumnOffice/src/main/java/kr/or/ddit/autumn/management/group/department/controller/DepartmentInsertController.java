package kr.or.ddit.autumn.management.group.department.controller;

import java.util.List;

import javax.validation.Valid;

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
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 부서 추가 컨트롤러
 *
 */

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/management/group/department")
public class DepartmentInsertController {
	private final DepartmentService service;

	@ModelAttribute("department")
	public DepartmentVO department() {
		log.info("@ModelAttribute 메소드 실행.");
		return new DepartmentVO();
	}

	@GetMapping("/departmentInsert.do")
	public String departmentForm(Authentication authentication
			,@ModelAttribute("department") DepartmentVO department
			,@ModelAttribute("power") PowerVO power
			, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		department.setComCode(comCode);
		log.info("Get 메소드 핸들러 departmentForm 실행");
		List<DepartmentVO> departmentList = service.departmentList(department);
		List<PowerVO> powerList = service.retrieveHeadList(power);
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("powerList",powerList);
		return "management/group/departmentForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method=RequestMethod.GET)
	public int idChk(DepartmentVO department, @RequestParam(name="depId") String depId) {
		department.setDepId(depId);
		int result = service.idCheck(department);
		return result;
	}

	@PostMapping("/departmentInsert.do")
	public String departmentInsert(Authentication authentication, @ModelAttribute("department") DepartmentVO department,
			Errors errors, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		department.setComCode(comCode);

		log.info("Post 메소드 핸들러 departmentInsert 실행");
		String viewName = null;

		if (!errors.hasErrors()) {
			ServiceResult result = service.createDepartment(department);

			if (result.equals(ServiceResult.OK)) {
				viewName = "redirect:/management/group/department/departmentView.do?what=" + department.getDepId();
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "management/group/departmentForm";
			}
		} else {
			viewName = "management/group/departmentForm";
		}
		return viewName;
	}

}
