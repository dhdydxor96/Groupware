package kr.or.ddit.autumn.management.menu.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.management.menu.service.DocManageMenualService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.RuleVO;
import kr.or.ddit.autumn.web.vo.MattersReplyVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
public class DocManageMenualRetrieveController {
	private DocManageMenualService service;
	
	@Inject
	public void setService(DocManageMenualService service) {
		this.service = service;
		log.info(" 주입된 business logic : {} ", service.getClass().getName());
	}

	@RequestMapping(value="docManageMenualList.do", method=RequestMethod.GET)
	public String listUI() {
		return "management/menu/docManageMenualList";
	}
	
	@RequestMapping(value="docManageMenualList.do", method=RequestMethod.GET
					, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<RuleVO> list(
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
		, @AuthenticationPrincipal(expression="realUser") CompanyVO company
	){
		PagingVO<RuleVO> pagingVO = new PagingVO<>(10,5);
		pagingVO.setComcode(company.getComCode());
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.retrieveRuleCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<RuleVO> docManageMenualList = service.retrieveRuleList(pagingVO);
		pagingVO.setDataList(docManageMenualList);
		
		return pagingVO;
	}
	
	@RequestMapping("docManageMenualView.do")
	public ModelAndView docManageMenualView(@RequestParam(name="what", required=true) int rulNo, Model model) {
		RuleVO rule = service.retrieveRule(rulNo);
		System.out.println(rule.toString());
		ModelAndView mav = new ModelAndView();
		mav.addObject("rule", rule);
		mav.setViewName("management/menu/docManageMenualView");
		
		return mav;
	}
	
}
