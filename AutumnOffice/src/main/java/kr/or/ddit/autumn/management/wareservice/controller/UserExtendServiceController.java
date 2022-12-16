package kr.or.ddit.autumn.management.wareservice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management/wareservice")
public class UserExtendServiceController {
	
	// 서비스 연장 신청 UI
	@GetMapping("/userExtendService.do")
	public String userExtendServiceUI() {
		return "management/wareservice/userExtendService";
	}
}
