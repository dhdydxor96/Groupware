package kr.or.ddit.autumn.web.consulting.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.autumn.web.consulting.service.ConsultingService;
import kr.or.ddit.autumn.web.vo.ConsultingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 *	서비스 신청하기(회사정보 입력 받는 폼) 컨트롤러
 *
 */


@Slf4j
@Controller
@RequestMapping("/web/consulting")
@RequiredArgsConstructor
@SessionAttributes(names = "consulting")
public class ConsultingController {
	
	private final ConsultingService service;
	
	@ModelAttribute("consulting")
	public ConsultingVO consulting() {
		log.info("@ModelAttribute 메소드 실행.");
		return new ConsultingVO();
	}
	
	
	@GetMapping("/consultingProtect.do")
	public String ConsultingProtect() {
		return "web/consulting/consultingProtect";
	}
	
	@GetMapping("/consultingForm.do")
	public String ConsultingForm() {
		log.info("Get 메소드 핸들러 consultingForm 실행");
		return "web/consulting/consultingForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(ConsultingVO consulting) {
		int result = service.idCheck(consulting);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/codeChk", method = RequestMethod.POST)
	public int codeChk(ConsultingVO consulting) {
		int result = service.comCodeCheck(consulting);
		return result;
	}
	
	@PostMapping("/consultingForm.do")
	public String ConsultingInsert(
		@Valid
		@ModelAttribute("consulting") ConsultingVO consulting
		, RedirectAttributes redirectAttributes
		, BindingResult errors
	) {
		log.info("ConsultingVO : ", consulting);

		if(errors.hasErrors()) {
			String errorsName = BindingResult.MODEL_KEY_PREFIX+"consulting";
			redirectAttributes.addFlashAttribute(errorsName, errors);
			return "redirect:/web/consulting/consultingForm.do";
		}else {
			return "redirect:/web/consulting/consultingService.do";
		}
		
	}
	
}
