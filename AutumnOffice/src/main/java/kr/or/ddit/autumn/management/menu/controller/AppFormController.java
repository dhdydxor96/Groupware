package kr.or.ddit.autumn.management.menu.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.menu.service.AppFormService;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/management/menu")
public class AppFormController {
	
	private final AppFormService service;
	
	@GetMapping("/appFormList.do")
	public String listUI() {
		return "management/menu/appFormList";
	}
	
	@GetMapping(value="/appFormList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AppFormVO> appFormList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<AppFormVO> pagingVO = new PagingVO<>(5,1);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = service.retrieveAppFormCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AppFormVO> appFormList = service.retrieveAppFormList(pagingVO);
		pagingVO.setDataList(appFormList);
		
		return pagingVO;
	}
	
	@GetMapping("/appFormInsert.do")
	public String appForm(Authentication authentication,@ModelAttribute("appForm") AppFormVO appForm, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		appForm.setComCode(comCode);
		log.info("Get 메소드 핸들러 appForm 실행");
		return "management/menu/appForm";
	}
	
	@PostMapping("/appFormInsert.do")
	public String appFormInsert(Authentication authentication
		, @ModelAttribute("appForm") AppFormVO appForm,
		Errors errors, Model model
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		appForm.setComCode(comCode);
		
		log.info("Post 메소드 핸들러 appFormInsert 실행");
		String viewName = null;
		
		if (!errors.hasErrors()) {
			ServiceResult result = service.createAppForm(appForm);

			if (result.equals(ServiceResult.OK)) {
				viewName = "redirect:/management/menu/appFormList.do";
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "management/menu/appForm";
			}
		} else {
			viewName = "management/menu/appForm";
		}
		return viewName;
	}
	
	
	@GetMapping("/appFormDelete.do")
	public String appFormDelete(
		Authentication authentication,
		@RequestParam(name="what", required=true) int apfNo
		,@ModelAttribute("appForm") AppFormVO appForm
		, RedirectAttributes redirectAttributes	
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		appForm.setComCode(comCode);
		
		appForm.setApfNo(apfNo);
		service.removeAppForm(appForm);
		return "redirect:/management/menu/appFormList.do";
	}
}
