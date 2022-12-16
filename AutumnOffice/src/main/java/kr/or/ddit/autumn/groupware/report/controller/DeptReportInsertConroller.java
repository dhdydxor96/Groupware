package kr.or.ddit.autumn.groupware.report.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DeptReportInsertConroller {

	@RequestMapping("/groupware/report/dept/deptReportInsert.do")
	public String deptReportCreate() {
		
		return "groupware/report/deptReportForm";
	}
}