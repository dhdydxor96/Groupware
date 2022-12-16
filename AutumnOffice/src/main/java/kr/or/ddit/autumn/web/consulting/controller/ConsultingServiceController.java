package kr.or.ddit.autumn.web.consulting.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.web.consulting.service.ConsultingService;
import kr.or.ddit.autumn.web.consulting.service.ConsultingServiceService;
import kr.or.ddit.autumn.web.vo.ConsultingVO;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 *	서비스 신청하기(멤버십 정보) 컨트롤러 
 *
 */


@Slf4j
@Controller
@RequestMapping("/web/consulting/consultingService.do")
@RequiredArgsConstructor
@SessionAttributes({"consulting", "consultingService"})
public class ConsultingServiceController {
	
	private final ConsultingService conService;
	
	private final ConsultingServiceService serService;
	
	@ModelAttribute("consultingService")
	public ConsultingServiceVO consulting(@ModelAttribute("consulting") ConsultingVO consulting) {
		ConsultingServiceVO consultingService = new ConsultingServiceVO();
		consultingService.setConsulting(consulting);
		return consultingService;
	}
	
	@GetMapping
	public String ConsultingServiceForm() {
		return "web/consulting/consultingService";
	}
	
	@PostMapping
	public String ConsultingServiceInsert(
		@Valid
		@ModelAttribute("consultingService") ConsultingServiceVO consultingService
		, @ModelAttribute("consulting") ConsultingVO consulting
		, BindingResult errors
		, RedirectAttributes redirectAttributes
		, SessionStatus sessionStatus
	) {
		log.info("ConsultingServiceVO : {}", consultingService);
		String resultmsg = "";
		if(errors.hasErrors()) {
			String errorsName = BindingResult.MODEL_KEY_PREFIX+"consultingService";
			redirectAttributes.addFlashAttribute(errorsName, errors);
			return "redirect:/web/consulting/consultingService.do";
		}else {
			conService.createConsulting(consulting);
			serService.createConsultingService(consultingService);
			sessionStatus.setComplete();
			resultmsg = "서비스 신청에 완료하였습니다. 마스터 아이디, 마스터 비밀번호로 관리자 로그인 하시기 바랍니다.";
			redirectAttributes.addFlashAttribute("resultmsg", resultmsg);
			return "redirect:/groupware/login/login.do";
		}
	}
}
