package kr.or.ddit.autumn.groupware.report.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/groupware/report/dept")
public class DeptReportSelectController {

	// 부서별 보고서 리스트
	@RequestMapping("/deptReportList.do")
	public String deptReportList() {
		
		return "groupware/report/deptReportList";
	}
	
	// 보고서 상세 (현재 보고한 사람, 언제 보고해야하는지)
	@RequestMapping("/deptReportDetail.do")
	public String deptReportDetail() {
		
		return "groupware/report/deptReportDetail";
	}

	// 보고 내용
	@RequestMapping("/deptReportContentDetail.do")
	public String deptReportContentDetail() {
		
		return "groupware/report/deptReportContentDetail";
	}
	
}