
package kr.or.ddit.autumn.groupware.report.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReportHomeSelectController {

	@RequestMapping("/groupware/report/reportHome.do")
	public String reportHome() {
		
		return "groupware/report/reportHome";
	}
}