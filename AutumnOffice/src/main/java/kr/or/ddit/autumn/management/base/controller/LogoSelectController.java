package kr.or.ddit.autumn.management.base.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.base.service.LogoManageService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/companyLogo")
@RequiredArgsConstructor
public class LogoSelectController {
	
	private final LogoManageService service;

	@RequestMapping("/selectCompanyLogoImage.do")
	public String logoImageView(Authentication authentication , Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		AttatchVO attatch = service.retrieveLogoImage(comCode);
		
		model.addAttribute("attatch", attatch);
		
		return "ImageView";
		
	}
}
