package kr.or.ddit.autumn.management.menu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.management.menu.service.CommunityManagerService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.BoardVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class CommunityManagerController {
	
	private final CommunityManagerService service;
	
	// 커뮤니티 관리 UI
	@GetMapping("/communityManage.do")
	public String noticeManageUI() {
		return "management/menu/communityManage";
	}
	
	@GetMapping(value="/communityManage.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<BoardVO> communityList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		,	@ModelAttribute("simpleCondition") SearchVO simpleCondition
		,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
		) {

		PagingVO<BoardVO> pagingVO = new PagingVO<>(5,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);

		log.info("@@@@@@@@@@@@@@@@@@@@" + pagingVO.getSimpleCondition() + "@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		pagingVO.setComcode(company.getComCode());
		int totalRecord = service.retrieveCommunityCount(pagingVO);

		
		pagingVO.setTotalRecord(totalRecord);
		
		log.info("@@@@@@@@@@@@@@@@@@@@ TotalRecord" + pagingVO.getTotalRecord() + "@@@@@@@@@@@@@@@@@@@@@@@@@@");
		List<BoardVO> communityList = service.retrieveCommunityList(pagingVO);

		
		pagingVO.setDataList(communityList);
		
		log.info("@@@@@@@@@@@@@@@@@@@@ DataList" + pagingVO.getDataList() + "@@@@@@@@@@@@@@@@@@@@@@@@@@");
		log.info("@@@@@@@@@@@@@@@@@@@@ PagingHTML" + pagingVO.getPagingHTML() + "@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		return pagingVO;
	}
	
	@GetMapping(value="/checkID.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String checkId(
			@RequestParam(name="code", required=true) String code
	) {
		log.info("@@@@@@@@@@@@@@@@@@@" + code + "@@@@@@@@@@@@@@@@@@@");
		String dupCode = service.searchCode(code);
		
		log.info("@@@@@@@@@@@@@@@@@@@" + dupCode + "@@@@@@@@@@@@@@@@@@@");
		
		String res = null;
		if(dupCode == null) {
			res = "ok";
		}else {
			res = "fail";
		}
		
		log.info("@@@@@@@@@@@@@@@@@@@" + res + "@@@@@@@@@@@@@@@@@@@");
		
		return res;
	}
	
	@PostMapping(value="/insertCommunity.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String insertCommunity(
				@Validated(InsertGroup.class) @ModelAttribute("board") BoardVO board
			,	BindingResult errors
			,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
			,	Model model
		) {
		
		String res = null;
		
		
		log.info("@@@@@@@@@@@@@@@@@@@" + board.getBoYn() + "@@@@@@@@@@@@@@@@@@@");
		
		if(StringUtils.isBlank(board.getBoCode()) || StringUtils.isBlank(board.getBoType())) {
			model.addAttribute("error", "커뮤니티 코드 및 이름을 입력해주세요");
			res = "empty";
			return res;
		}

		board.setComCode(company.getComCode());
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createCommunity(board);
			switch (result) {
			case OK:
				res = "OK";
				break;	
			default:
				res = "Fail";
				break;
			}
		}else {
			res = "Fail";
		}
		return res;
	}
	
	@PostMapping(value="/communityDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> deleteNotice(
			@RequestBody String[] boNos
			, Errors errors
			, Model model
		){
		Map<String, Object> result = new HashMap<String, Object>();
		
		log.info("@@@@@@@@@@@@@@@@@@@ 비상 비상 비상~~~ @@@@@@@@@@@@@@@@@@@");
		
		for(int i=0; i< boNos.length; i++) {
			result.put("message", service.removeCommunity(boNos[i]));
		}
		return result;
	}
	
}