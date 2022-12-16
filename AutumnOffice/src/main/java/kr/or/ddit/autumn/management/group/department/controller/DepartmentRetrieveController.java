package kr.or.ddit.autumn.management.group.department.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.department.service.DepartmentService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/management/group/department")
public class DepartmentRetrieveController {
	
	private final DepartmentService service;
	
	@GetMapping("/departmentList.do")
	public String listUI() {
		return "management/group/departmentList";
	}
	
	@GetMapping(value="/departmentList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<DepartmentVO> departmentList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<DepartmentVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = service.retrieveDepartmentCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<DepartmentVO> departmentList = service.retrieveDepartmentList(pagingVO);
		pagingVO.setDataList(departmentList);
		
		return pagingVO;
	}
	
	@GetMapping("/departmentView.do")
	public ModelAndView departmentView(Authentication authentication,
		@RequestParam(name="what", required=true) String depId) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		log.info("depId : {}" , depId);
		DepartmentVO department = service.retrieveDepartment(depId);
		log.info("department : {}" , department);
		department.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("department", department);
		mav.setViewName("management/group/departmentView");
		return mav;
	}
	
}
