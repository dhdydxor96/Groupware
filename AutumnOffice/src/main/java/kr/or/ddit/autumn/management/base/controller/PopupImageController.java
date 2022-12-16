package kr.or.ddit.autumn.management.base.controller;

import java.io.IOException;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.management.base.service.PopupManageService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.PopUpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PopupImageController {
	
	@Inject
	private PopupManageService service;
	
	@ModelAttribute("attatch")
	public AttatchVO popup(
				@AuthenticationPrincipal(expression="realUser") CompanyVO company) {
		
		PopUpVO popup = new PopUpVO();
		
		log.info("@ModelAttribute 메소드 실행.");
		String comCode = company.getComCode();
		popup.setComCode(comCode);
		
		AttatchVO attatch = service.retrieveAttatch(company.getComCode());
		return attatch;
	}
	
	@RequestMapping("/management/menu/popUpImageView.do")
	public String download(Model model,	@AuthenticationPrincipal(expression="realUser") CompanyVO company)throws IOException{
		
		log.info("@@@@@@@@@@@@@@@@@@@@@ " +company.getComCode()+ " @@@@@@@@@@@@@@@@@@@@@@@@");
		AttatchVO imageInfoVO = service.retrieveAttatch(company.getComCode());
		if(imageInfoVO == null) {
			model.addAttribute("message", "noImage");
			return "management/base/popup";
		}
		model.addAttribute("attatch", imageInfoVO);
		return "ImageView";
	}
}
