package kr.or.ddit.autumn.groupware.docmanage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/groupware/docmanage")
public class ManageReportSelectController {

	
	// 문서관리 - 보고서 리스트 조회
	@RequestMapping("/docmanageReportList.do")
	public String docManageReportList() {
		
		return "groupware/docmanage/docmanageReportList";
	}
	
	
	// 문서관리 - 보고서 상세조회
	@RequestMapping("/docManagerReportDetail.do")
	public String docManageHomeView() {
		
		return "groupware/docmanage/docmanageReportDetail";
	}
}
