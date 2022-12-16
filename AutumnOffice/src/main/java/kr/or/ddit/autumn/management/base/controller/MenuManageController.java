package kr.or.ddit.autumn.management.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/base")
public class MenuManageController {
	
	// 메뉴 운영 권한 UI
	@GetMapping("/menuManage.do")
	public String menuManageUI() {
		return "management/base/menuManage";
	}
}
