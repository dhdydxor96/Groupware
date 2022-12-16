package kr.or.ddit.autumn.groupware.gm.customer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PayMonthListController {
	
	@RequestMapping("/groupware/gm/customer/paymonthList.do")
	public String payMonthList() {
		return "groupware/gm/customer/paymonthList";
	}
}
