package kr.or.ddit.autumn.groupware.approval.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.groupware.approval.vo.AppFormSelectElementsVO;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/approval")
public class ApprovalSelectController {
	
	@Inject
	private ApprovalService service;
	
	// 전자 결재 홈
	@RequestMapping("/approvalHome.do")
	public String homeUI() {
		log.info("전자 결재 홈 View Load...");
		
		return "groupware/approval/home";
	}
	
	// 결재 양식 리스트, 부서 리스트 조회 해서 json data 비동기 처리 컨트롤러
	@GetMapping("/appFormList.do")
	@ResponseBody
	public AppFormSelectElementsVO appFormSelectElementsToJson(@AuthenticationPrincipal(expression="realUser") EmployeeVO employee){
		AppFormSelectElementsVO elements = new AppFormSelectElementsVO();
		
		log.info("결재 양식 리스트, 부서 리스트 조회 controller load...");
		
		String comCode = employee.getComCode();
		log.info("회사 코드 load : {}", comCode);
		
		List<AppFormVO> appFormList = service.retrieveAppFormList(comCode);
		log.info("결재 양식 리스트 : {}", appFormList);
		List<DepartmentVO> departmentList = service.retrieveDepartmentList(comCode);
		log.info("부서 리스트 : {}", departmentList);
		elements.setAppFormList(appFormList);
		elements.setDepartmentList(departmentList);
		
		log.info("Json Data 출력 : {}", elements);
		return elements;
	}
	
	@GetMapping("/departmentList.do")
	@ResponseBody
	public List<DepartmentVO> departmentListToJson(@AuthenticationPrincipal(expression="realUser") EmployeeVO principal) {
		List<DepartmentVO> departmentList = service.retrieveDeptGroupList(principal.getComCode());
		log.info("부서 리스트 : {}", departmentList);
		return departmentList;
	}
}
