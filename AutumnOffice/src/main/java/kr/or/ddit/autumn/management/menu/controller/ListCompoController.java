package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/menu")
public class ListCompoController {
	
	// 메뉴 목록 관리 UI
	@GetMapping("/listCompo.do")
	public String listCompoUI() {
		return "management/menu/listCompo";
	}
}
