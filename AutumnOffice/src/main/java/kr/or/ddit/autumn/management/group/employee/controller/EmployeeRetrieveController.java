package kr.or.ddit.autumn.management.group.employee.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeePowerService;
import kr.or.ddit.autumn.management.group.employee.service.ManagementEmployeeService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/management/group/employee")
public class EmployeeRetrieveController {
	
	private final ManagementEmployeeService service;
	private final ManagementEmployeePowerService powService;
	
	@GetMapping("/employeeList.do")
	public String listUI() {
		return "management/group/employeeList";
	}
	
	@GetMapping(value = "/employeeList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmployeeVO> employeeList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = service.retrieveEmpCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<EmployeeVO> employeeList = service.retrieveEmployeeList(pagingVO);
		pagingVO.setDataList(employeeList);
		
		return pagingVO;
	}
	
	@GetMapping("/employeeView.do")
	public ModelAndView employeeView(
		Authentication authentication,
		@RequestParam(name="what", required=true) String empId
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		EmployeeVO employee = service.retrieveEmployee(empId);
		employee.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("employee", employee);
		mav.setViewName("management/group/employeeView");
		return mav;
	}
	
	@GetMapping("/resignationList.do")
	public String listResignationUI() {
		return "management/group/resignationList";
	}
	
	@GetMapping(value = "/resignationList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmployeeVO> resignationList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = service.retrieveResignationEmpCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<EmployeeVO> employeeList = service.retrieveResignationList(pagingVO);
		pagingVO.setDataList(employeeList);
		
		return pagingVO;
	}
	
	@GetMapping("/powerHeadList.do")
	public String listPowerHeadUI(@ModelAttribute("employee") EmployeeVO employee) {
		return "management/group/powerHeadList";
	}
	
	@GetMapping(value = "/powerHeadList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmployeeVO> powerHeadList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
		, @ModelAttribute("employee") EmployeeVO employee
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = powService.retrieveHeadCount(pagingVO);
		employee.setEmpNm(employee.getEmpNm());
		pagingVO.setTotalRecord(totalRecord);
		List<EmployeeVO> employeeList = powService.retrieveEmployeeHeadList(pagingVO);
		pagingVO.setDataList(employeeList);
		
		return pagingVO;
	}
	
	@GetMapping("/powerDirectorList.do")
	public String listPowerDirectorUI() {
		return "management/group/powerDirectorList";
	}
	
	@GetMapping(value = "/powerDirectorList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmployeeVO> powerDirectorList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<EmployeeVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = powService.retrieveDirectorCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<EmployeeVO> employeeList = powService.retrieveEmployeeDirectorList(pagingVO);
		pagingVO.setDataList(employeeList);
		
		return pagingVO;
	}
		
	
	
}
