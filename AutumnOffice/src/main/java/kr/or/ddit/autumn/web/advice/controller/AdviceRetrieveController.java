package kr.or.ddit.autumn.web.advice.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.web.advice.service.AdviceReplyService;
import kr.or.ddit.autumn.web.advice.service.AdviceService;
import kr.or.ddit.autumn.web.vo.AdviceReplyVO;
import kr.or.ddit.autumn.web.vo.AdviceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

/**
 *	상담요청 조회/상세보기 컨트롤러 
 *
 */

@Slf4j
@Controller
@RequestMapping("/web/advice")
public class AdviceRetrieveController {
	private AdviceService service;
	private AdviceReplyService replyService;
	
	@Inject
	public void setService(AdviceService service) {
		this.service = service;
		log.info(" 주입된 business logic : {} ", service.getClass().getName());
	}
	
	@Inject
	public void setReplyService(AdviceReplyService replyService) {
		this.replyService = replyService;
	}
	
	@RequestMapping(value="adviceList.do", method=RequestMethod.GET)
	public String listUI() {
		return "web/advice/adviceList";
	}
	
	@RequestMapping(value="adviceList.do", method=RequestMethod.GET
			, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<AdviceVO> list(
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		PagingVO<AdviceVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.retrieveAdviceCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AdviceVO> adviceList = service.retrieveAdviceList(pagingVO);
		pagingVO.setDataList(adviceList);
		
		return pagingVO;
	}
	@RequestMapping("adviceView.do")
	public ModelAndView adviceView(@RequestParam(name="what", required=true) int advNo) {
		AdviceVO advice = service.retrieveAdvice(advNo);
		List<AdviceReplyVO> adviceReplyList = replyService.adviceReplyList(advNo);
		ModelAndView mav = new ModelAndView();
		mav.addObject("advice", advice);
		mav.addObject("advReply", adviceReplyList);
		mav.setViewName("web/advice/adviceView");
		return mav;
	}
}
