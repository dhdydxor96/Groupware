package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/menu")
public class ArchiveManageController {
	
	// 자료실 관리 UI
	@GetMapping("/archiveManage.do")
	public String archiveManageUI() {
		return "management/menu/archiveManage";
	}
}
