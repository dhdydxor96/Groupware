package kr.or.ddit.autumn.groupware.attendance.controller;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.AttendPrivacyService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/groupware/attendance")
public class AttendPrivacyImageController {

	private final AttendPrivacyService service;
	
	@RequestMapping("/dept/privacy/privacyImageView.do")
	public String depImage(@RequestParam(required=true, name="who") String empId, Model model) throws IOException {
		
		AttatchVO imageInfoVO = service.retrieveProfileImage(empId);
		
		model.addAttribute("attatch", imageInfoVO);
		
		return "ImageView";
		
	}
	
	@RequestMapping("/my/privacy/privacyImageView.do")
	public String myImage(Authentication authentication, Model model) throws IOException {
		
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		AttatchVO imageInfoVO = service.retrieveProfileImage(empId);
		
		model.addAttribute("attatch", imageInfoVO);
		
		return "ImageView";
	}
}
