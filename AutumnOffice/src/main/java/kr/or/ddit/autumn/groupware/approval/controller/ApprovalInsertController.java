package kr.or.ddit.autumn.groupware.approval.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.logging.log4j.core.config.plugins.validation.constraints.Required;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.groupware.approval.vo.AppFormSelectElementsVO;
import kr.or.ddit.autumn.groupware.approval.vo.ApprovalFormVO;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EleDecideVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/approval")
public class ApprovalInsertController {
	
	@Inject
	private ApprovalService service;
	
	// 결재 작성 뷰 이동
	@GetMapping("/approvalInsert.do")
	public String appInsertUI() {
		log.info("결재 작성 View Load...");
		return "groupware/approval/writeForm";
	}
	
	// 결재 작성 완료 및 기안문서함 이동
	@PostMapping("/approvalInsert.do")
	public String appInsert(
			@Required ApprovalFormVO approvalForm
			, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
		) {
		log.info("결재 작성 데이터 수신... : {}", approvalForm);
		log.info("업로드할 파일 리스트 : {}", approvalForm.getAttatchList());
		
		approvalForm.setEmpId(employee.getEmpId());
		
		ServiceResult result = service.createApproval(approvalForm);
		
		return "redirect:/groupware/approval/doc/draftDocList.do";
	}
	
}
