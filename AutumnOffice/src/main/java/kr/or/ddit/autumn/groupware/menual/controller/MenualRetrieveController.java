package kr.or.ddit.autumn.groupware.menual.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.commons.employee.service.EmployeeService;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.management.menu.service.DocManageMenualService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.RuleVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/menual")
public class MenualRetrieveController {
	
	private DocManageMenualService service;
	
	@Inject
	public void setService(DocManageMenualService service) {
		this.service = service;
		log.info(" 주입된 business logic : {} ", service.getClass().getName());
	}

	@RequestMapping(value="menualList.do", method=RequestMethod.GET)
	public String listUI() {
		System.out.println("여기");
		return "groupware/menual/menualList";
	}
	
	@RequestMapping(value="menualList.do", method=RequestMethod.GET
					, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<RuleVO> list(
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
		,Authentication authentication
	){
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
    	
		
		PagingVO<RuleVO> pagingVO = new PagingVO<>(10,5);
		pagingVO.setComcode(adapter.getRealUser().getComCode());
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.retrieveRuleCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<RuleVO> menualList = service.retrieveRuleList(pagingVO);
		pagingVO.setDataList(menualList);
		
		return pagingVO;
	}
	
	@RequestMapping("menualView.do")
	public ModelAndView menualView(@RequestParam(name="what", required=true) int rulNo, Model model) {
		RuleVO rule = service.retrieveRule(rulNo);
		System.out.println(rule.toString());
		ModelAndView mav = new ModelAndView();
		mav.addObject("rule", rule);
		mav.setViewName("groupware/menual/menualView");
		
		return mav;
	}
	
}
