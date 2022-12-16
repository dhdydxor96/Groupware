package kr.or.ddit.autumn.web.experience.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.web.experience.service.ExperienceService;
import kr.or.ddit.autumn.web.experience.service.MailSendService;
import kr.or.ddit.autumn.web.vo.ExperienceVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 *	체험하기 컨트롤러 
 *
 */

@Slf4j
@Controller
@RequestMapping("/web/experience")
@RequiredArgsConstructor
public class ExperienceController {
	@Autowired
	private final ExperienceService service;
	@Autowired
	private MailSendService mailService;
	
	@ModelAttribute("experience")
	public ExperienceVO experience() {
		log.info("@ModelAttribute 메소드 실행.");
		return new ExperienceVO();
	}
	@GetMapping("/experienceInsert.do")
	public String ExperienceForm(@ModelAttribute("experience") ExperienceVO experience) {
		log.info("Get 메소드 핸들러 experienceForm 실행");
		return "web/experience/experienceForm";
	}
	
	// 이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);
	}
	
	@PostMapping("/experienceInsert.do")
	public String ExperienceInsert(@Validated(InsertGroup.class) 
		@ModelAttribute("experience") ExperienceVO experience
		, Errors errors, Model model
	) {
		log.info("Post 메소드 핸들러 experienceInsert 실행");
		String viewName = null;
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createExperience(experience);
			
			if(result.equals(ServiceResult.OK)) {
				viewName = "web/experience/experienceResult";
			}else {
				String message = "체험하기 실패";
				model.addAttribute("message", message);
				viewName = "web/experience/experienceForm";
			}
		}else {
			viewName = "web/experience/experienceForm";
		}
		return viewName;
	}
		
}
