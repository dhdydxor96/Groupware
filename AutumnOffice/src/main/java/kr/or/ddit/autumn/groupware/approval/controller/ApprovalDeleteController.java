package kr.or.ddit.autumn.groupware.approval.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.vo.ElecAppVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/approval")
public class ApprovalDeleteController {
	
	@Inject
	private ApprovalService service;

	@PostMapping("/approvalDelete.do")
	public String elecAppDelete(int eleNo) {
		
		ElecAppVO elecApp = service.retrieveElecApp(eleNo);
		
		if(elecApp == null) {
			throw new RuntimeException(eleNo + " 문서 없음");
		}
		
		ServiceResult result = service.removeElecApp(elecApp);
		if(result == ServiceResult.FAIL) {
			throw new RuntimeException(eleNo + " 문서 삭제 에러");
		}
		
		return "redirect:/groupware/approval/doc/draftDocList.do";
	}
}
