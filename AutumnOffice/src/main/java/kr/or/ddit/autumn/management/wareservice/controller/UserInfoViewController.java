package kr.or.ddit.autumn.management.wareservice.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.wareservice.service.ServiceHistoryService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/management/wareservice")
public class UserInfoViewController {
	
	private final ServiceHistoryService service;
	
	// 서비스 정보 확인 UI	
	@GetMapping("/userInfoView.do")
	public ModelAndView employeeView(
		Authentication authentication,
		@RequestParam(name="what", required=true) String comCode
	) {
		log.info("파라미터 comCode {}", comCode);
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		comCode = realuser.getComCode();
		log.info("로그인 정보에 들어있는 comCode {}", comCode );
		
		ConsultingServiceVO serviceHistory = service.retrieveServiceHistory(comCode);
		
		log.info("serviceHistory {}", serviceHistory.getComCode());
		
		serviceHistory.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("serviceHistory", serviceHistory);
		mav.setViewName("management/wareservice/userInfoView");
		return mav;
	}
}
