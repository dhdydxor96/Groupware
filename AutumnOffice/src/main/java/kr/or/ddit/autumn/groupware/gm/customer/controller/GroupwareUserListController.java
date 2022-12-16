package kr.or.ddit.autumn.groupware.gm.customer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GroupwareUserListController {
	
	@RequestMapping("/groupware/gm/customer/groupwareuserList.do")
	public String groupwareUserList() {
		return "groupware/gm/customer/groupwareuserList";
	}
	@RequestMapping("/groupware/gm/customer/groupwareuserDetail.do")
	public String groupwareUserDetail() {
		return "groupware/gm/customer/groupwareuserDetail";
	}
}
