package kr.or.ddit.autumn.groupware.approval.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.vo.AplDetailVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/approval")
public class ApprovalUpdateController {
	
	@Inject
	private ApprovalService service;
	
	@PostMapping(value="/approvalUpdate.do")
	public String appLineUpdate(
			@RequestParam(name="eleNo", required=true) int eleNo 
			, @RequestParam(name="cancel", required=false) String cancel
			, @Validated AplDetailVO aplDetail
			, Errors errors, RedirectAttributes scope
			, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
			) {
		ServiceResult result = null;
		
		aplDetail.setEmpId(employee.getEmpId());
		if(StringUtils.isNotBlank(cancel)) {
			result = service.modifyCancel(eleNo, aplDetail, cancel);
		}
		
		if(!errors.hasErrors() && !StringUtils.isNotBlank(cancel)) {
			aplDetail.setEmpSign(employee.getEmpSign());
			result = service.modifyAplDetail(aplDetail, eleNo);
		}
		scope.addAttribute("eleNo", eleNo);
		return "redirect:/groupware/approval/doc/waitAppDocDetail.do";
	}
	
	@PostMapping(value="/signUpdate.do")
	public String empSignUpdate(@AuthenticationPrincipal(expression="realUser") EmployeeVO employee
			,	@RequestParam(name="empSignImg", required=true)MultipartFile empSignImg) {
		String signImg = null;
		
		try {
			employee.setEmpSignImg(empSignImg);
			log.info("서명 이미지 셋팅...");
			log.info("데이터 : {}", empSignImg);
		} catch (IOException e) {
			log.info("empSign 셋팅 중 오류발생...{}", e.getMessage());
		}
		ServiceResult result = service.modifyEmpSign(employee);
			
		return "groupware/approval/signUpdateView";
	}
}
