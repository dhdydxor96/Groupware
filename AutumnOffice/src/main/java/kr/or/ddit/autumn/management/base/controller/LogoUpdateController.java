package kr.or.ddit.autumn.management.base.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.management.base.service.LogoManageService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/base")
@RequiredArgsConstructor
public class LogoUpdateController {
	
	private final LogoManageService service;
	
	// ================================
	// * 관리자페이지 - 로고 변경 화면
	// 기존에 등록했던 이미지가 존재한다면 파일명을 띄워준다.
	// ================================
	@GetMapping("/logoChange.do")
	public String logoUpdateUI(Authentication authentication, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		AttatchVO attatch = service.retrieveLogoImage(comCode);
		
		if(attatch!=null) {
			model.addAttribute("attatchFnm",attatch.getAttFnm());
		}
		
		return "management/base/logoChange";
	}
	
	// ================================
	// * 로고 변경하기
	// ================================
	@PostMapping("/logoChange.do")
	public String logoUpdate(Authentication authentication, CompanyVO companyVO ,RedirectAttributes ratt) {
		log.info("파라미터 정보 - company : {}" , companyVO);

		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		
		log.info("파라미터 정보 - AttatchList : {}", companyVO.getAttatchList() );
		
		companyVO.setComCode(comCode);
		
		ServiceResult result = service.updateLogoImage(companyVO);
		
		if(result.equals(ServiceResult.FAIL)) {
			ratt.addFlashAttribute("message", "기업 로고 이미지 변경에 실패하였습니다.잠시 후에 다시 시도해주세요.");
		}else {
			ratt.addFlashAttribute("message", "기업 로고 이미지 변경에 성공하였습니다.");
		}
		
		return "redirect:/management/base/logoChange.do";
	}
	
}
