package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/menu")
public class MailManageController {
	
	// 메일 관리 UI
	@GetMapping("/mailManage.do")
	public String mailManageUI() {
		return "management/menu/mailManage";
	}
}
