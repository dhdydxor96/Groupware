package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/menu")
public class DocManageController {
	
	// 문서 관리 UI
	@GetMapping("/docManage.do")
	public String docManageUI() {
		return "management/menu/docManage";
	}
}
