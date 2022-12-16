package kr.or.ddit.autumn.groupware.gm.customer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UnpaidListController {
	
	@RequestMapping("/groupware/gm/customer/unpaidList.do")
	public String payMonthList() {
		return "groupware/gm/customer/unpaidList";
	}
}
