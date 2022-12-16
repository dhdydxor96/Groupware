package kr.or.ddit.autumn.web.matters.controller;


import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.web.matters.service.MattersReplyService;
import kr.or.ddit.autumn.web.matters.service.MattersService;
import kr.or.ddit.autumn.web.vo.MattersReplyVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

/**
 *	문의사항 조회/상세보기 컨트롤러 
 *
 */

@Slf4j
@Controller
@RequestMapping("/web/matters")
public class MattersRetrieveController {
	private MattersService service;
	private MattersReplyService replyService;
	
	@Inject
	public void setService(MattersService service) {
		this.service = service;
		log.info(" 주입된 business logic : {} ", service.getClass().getName());
	}
	
	@Inject
	public void setReplyService(MattersReplyService replyService) {
		this.replyService = replyService;
	}



	@RequestMapping(value="mattersList.do", method=RequestMethod.GET)
	public String listUI() {
		return "web/matters/mattersList";
	}
	
	@RequestMapping(value="mattersList.do", method=RequestMethod.GET
					, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<MattersVO> list(
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		PagingVO<MattersVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.retrieveMattersCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<MattersVO> mattersList = service.retrieveMattersList(pagingVO);
		pagingVO.setDataList(mattersList);
		
		return pagingVO;
	}
	
	@RequestMapping("mattersView.do")
	public ModelAndView mattersView(@RequestParam(name="what", required=true) int matNo, Model model) {
		MattersVO matters = service.retrieveMatters(matNo);
		List<MattersReplyVO> replyList = replyService.mattersReplyList(matNo);
		ModelAndView mav = new ModelAndView();
		mav.addObject("matters", matters);
		mav.addObject("reply", replyList);
		mav.setViewName("web/matters/mattersView");
		
		return mav;
	}
}	
