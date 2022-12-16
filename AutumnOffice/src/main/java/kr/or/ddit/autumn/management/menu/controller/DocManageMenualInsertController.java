package kr.or.ddit.autumn.management.menu.controller;

import javax.inject.Inject;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.management.menu.service.DocManageMenualService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.RuleVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/management/menu/docManageMenualInsert.do")
public class DocManageMenualInsertController {
		
		@Inject
		private final DocManageMenualService service;
		@Inject
		private WebApplicationContext context;
		
		@ModelAttribute("rule")
		public RuleVO rule() {
			log.info("@ModelAttribute 메소드 실행.");
			return new RuleVO();
		}
		
		@GetMapping
		public String docManageMenualForm(@ModelAttribute("rule") RuleVO rule) {
			log.info("Get 메소드 핸들러 mattersForm 실행");
			return "management/menu/docManageMenualForm";
		}
		
		@PostMapping
		public String docManageMenualInsert(@Validated(InsertGroup.class) @ModelAttribute("rule") 
		RuleVO rule
		, @AuthenticationPrincipal(expression="realUser") CompanyVO company
		, Errors errors
		, Model model
		) {
			log.info("Post 메소드 핸들러 mattersInsert 실행 {} ", rule);
			
			String viewName = null;
			rule.setComCode(company.getComCode());
			
			if(!errors.hasErrors()) {
				ServiceResult result = service.createRule(rule);
				
				if(result.equals(ServiceResult.OK)) {
					viewName = "redirect:/management/menu/docManageMenualList.do";
				}else {
					String message = "등록 실패";
					model.addAttribute("message", message);
					viewName = "management/menu/docManageMenualForm";
				}
			}else {
				viewName = "management/menu/docManageMenualForm";
			}
			return viewName;
		}
}

