package kr.or.ddit.autumn.groupware.report.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CompletionReportSelectController {

	@RequestMapping("/groupware/report/completion/completionReportList.do")
	public String completionReportList() {
		
		return "groupware/report/completionReportList";
	}
}