package kr.or.ddit.autumn.management;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.managementindex.service.ManagementIndexService;
import kr.or.ddit.autumn.management.managementindex.vo.ManagementIndexVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import lombok.RequiredArgsConstructor;

@Controller
public class ManagementIndexController {
	
	

	@Inject
	private ManagementIndexService service;
	
	@GetMapping("/management/index.do")
	public ModelAndView managementIndexView(Authentication authentication) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		ManagementIndexVO selectIndexView = service.selectIndex(comCode);
		
		System.out.println("selectIndexView" + selectIndexView);
		ModelAndView mav = new ModelAndView();
		mav.addObject("selectIndexView", selectIndexView);
		mav.setViewName("management/index");
		return mav;

	}
}
