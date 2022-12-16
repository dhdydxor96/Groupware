package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/menu")
public class ApprovalManageController {
	
	// 전자 결재 관리 UI
	@GetMapping("/approvalManage.do")
	public String approvalManageUI() {
		return "management/menu/approvalManage";
	}
}
