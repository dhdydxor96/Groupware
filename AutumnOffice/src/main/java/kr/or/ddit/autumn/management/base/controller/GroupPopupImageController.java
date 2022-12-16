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
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PopUpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GroupPopupImageController {
	
	@Inject
	private PopupManageService service;
	
	@ModelAttribute("attatch")
	public AttatchVO popup(
				@AuthenticationPrincipal(expression="realUser") EmployeeVO employee) {
		
		PopUpVO popup = new PopUpVO();
		
		log.info("@ModelAttribute 메소드 실행.");
		String comCode = employee.getComCode();
		popup.setComCode(comCode);
		
		AttatchVO attatch = service.retrieveAttatch(employee.getComCode());
		return attatch;
	}
	
	@RequestMapping("/management/menu/usePopUpImageView.do")
	public String download(Model model,	@AuthenticationPrincipal(expression="realUser") EmployeeVO employee)throws IOException{
		
		log.info("@@@@@@@@@@@@@@@@@@@@@ " +employee.getComCode()+ " @@@@@@@@@@@@@@@@@@@@@@@@");
		AttatchVO imageInfoVO = service.retrieveAttatch(employee.getComCode());
		if(imageInfoVO == null) {
			model.addAttribute("message", "noImage");
			return "management/base/popup";
		}
		model.addAttribute("attatch", imageInfoVO);
		return "ImageView";
	}
}
