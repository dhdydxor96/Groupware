package kr.or.ddit.autumn.groupware.gm.customer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayYearListController {
	
	@RequestMapping("/groupware/gm/customer/payyearList.do")
	public String payYearList() {
		return "groupware/gm/customer/payyearList";
	}
}
