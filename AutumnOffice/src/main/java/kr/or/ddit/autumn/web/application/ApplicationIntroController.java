package kr.or.ddit.autumn.web.application;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *	기능소개 페이지 컨트롤러
 *
 */

@Controller
public class ApplicationIntroController {
	
	@RequestMapping("/web/application/applicationintro.do")
	public String applicationintro() {
		return "web/application/applicationintro";
	}
	
	@RequestMapping("/web/application/applicationMail.do")
	public String applicationMail() {
		return "web/application/applicationmail";
	}
	
	@RequestMapping("/web/application/applicationApproval.do")
	public String applicationApproval() {
		return "web/application/applicationapproval";
	}
	
	@RequestMapping("/web/application/applicationWork.do")
	public String applicationWork() {
		return "web/application/applicationwork";
	}
	
	@RequestMapping("/web/application/applicationReport.do")
	public String applicationReport() {
		return "web/application/applicationreport";
	}
	
	@RequestMapping("/web/application/applicationAddress.do")
	public String applicationAddress() {
		return "web/application/applicationaddress";
	}
	
	@RequestMapping("/web/application/applicationCalendar.do")
	public String applicationCalendar() {
		return "web/application/applicationcalendar";
	}
	
	@RequestMapping("/web/application/applicationSurvey.do")
	public String applicationSurvey() {
		return "web/application/applicationsurvey";
	}
	
	@RequestMapping("/web/application/applicationReservation.do")
	public String applicationReservation() {
		return "web/application/applicationreservation";
	}
	
	@RequestMapping("/web/application/applicationDocument.do")
	public String applicationDocument() {
		return "web/application/applicationdocument";
	}
	
	@RequestMapping("/web/application/applicationBoard.do")
	public String applicationBoard() {
		return "web/application/applicationboard";
	}
	
	@RequestMapping("/web/application/applicationCommunity.do")
	public String applicationCommunity() {
		return "web/application/applicationcommunity";
	}
	
	@RequestMapping("/web/application/applicationMessenger.do")
	public String applicationMessenger() {
		return "web/application/applicationmessenger";
	}
	@RequestMapping("/web/application/applicationFile.do")
	public String applicationFile() {
		return "web/application/applicationfile";
	}
	@RequestMapping("/web/application/applicationManager.do")
	public String applicationManager() {
		return "web/application/applicationmanager";
	}
}
