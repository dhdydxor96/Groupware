package kr.or.ddit.autumn.web.intro;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

/**
 *	회사소개 페이지 컨트롤러 
 *
 */

@Controller
public class OfficeIntroController {
		
	@RequestMapping("/web/intro/officeintro.do")
	public String officeintro() {
		return "web/intro/officeintro";
	}
	
	@RequestMapping("/web/intro/officehistory.do")
	public String officehistory() {
		return "web/intro/officehistory";
	}
	
	@RequestMapping("/web/intro/officefind.do")
	public String officefind() {
		return "web/intro/officefind";
	}
}
