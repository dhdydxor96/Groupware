package kr.or.ddit.autumn.groupware.mail.controller;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.groupware.mail.vo.ReceiveMailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/mail")
public class MailSelectController {
	
	private ServletContext application;


	// 받은메일함뷰
	@GetMapping("/mailList.do")
	public String mailListUI(Model model) {
		model.addAttribute("mail", "받은메일함");
		return "groupware/mail/mailList";
	}


	// 메일상세뷰
	@GetMapping("/mailDetail.do")
	public String mailDetailUI(Model model,
							   @RequestParam("mailNo") Integer mailNo) {
		model.addAttribute("mailNo", mailNo);
		
		model.addAttribute("mail", "받은메일함");
		return "groupware/mail/mailDetail";
	}
	
	// 메일상세뷰
	@GetMapping(value="/mailDetail.do" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ReceiveMailVO mailDetail(HttpServletRequest request,Model model,
								   @RequestParam("mailNo") String mailNo) {
			application = request.getServletContext();
			Map<String,ReceiveMailVO> mailMap = (Map<String, ReceiveMailVO>) application.getAttribute("mailMap");
			ModelAndView mv =new ModelAndView();
			mv.setViewName("groupware/mail/mailDetail");
			
			mv.addObject("mailMap", mailMap.get("mail"+mailNo));

			return  mailMap.get("mail"+mailNo);
	}
	

}