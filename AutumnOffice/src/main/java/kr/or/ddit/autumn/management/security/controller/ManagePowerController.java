package kr.or.ddit.autumn.management.security.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/security")
public class ManagePowerController {
	
	// 관리자 권한 관리
	@GetMapping("managerPower.do")
	public String managePowerUI() {
		return "management/security/managerPower";
	}
}
