package kr.or.ddit.autumn.management.menu.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.management.menu.service.NoticeManagerService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class NoticeManageController {
	
	private final NoticeManagerService service;
	
	// 공지사항 관리 UI
	@GetMapping("/noticeManage.do")
	public String noticeManageUI() {
		return "management/menu/noticeManage";
	}
	
	@GetMapping(value="/noticeManage.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<NoticeVO> noticeList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		,	@ModelAttribute("simpleCondition") SearchVO simpleCondition
		,	@AuthenticationPrincipal(expression="realUser") CompanyVO company
		) {

		
		PagingVO<NoticeVO> pagingVO = new PagingVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		
		pagingVO.setComcode(company.getComCode());
		log.info("@@@@@@@@@@@@    pagingVO.getCom : " + company.getComCode());
		log.info("@@@@@@@@@@@@    pagingVO.getCom : " + pagingVO.getComCode());
		int totalRecord = service.retrieveNoticeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<NoticeVO> noticeList = service.retrieveNoticeList(pagingVO);
		
		log.info("postList : " + noticeList);
		
		pagingVO.setDataList(noticeList);
		
		log.info("pagingVO : " + pagingVO.getDataList());
		log.info("@@@@@@@@@@@@@@@@@@@@" + pagingVO.getPagingHTML() + "@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
		return pagingVO;
	}
	
	@GetMapping("/noticeView.do")
	public String managePostView(
			@RequestParam(required=true) int what
		,	Model model
	) {
		NoticeVO notice = service.retrieveNotice(what);
		model.addAttribute("notice", notice);
		
		return "management/menu/noticeManageDetail";
	}
	
	@RequestMapping("/noticeDownload.do")
	public String download(
		@RequestParam(name="what", required=true) int attNo
		, Model model
	)throws IOException {
		AttatchVO attatch = service.retrieveAttatch(attNo);
		model.addAttribute("attatch", attatch);
		return "downloadView";
	}
}
