package kr.or.ddit.autumn.groupware.board.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.board.service.NoticeService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class NoticeListController {
	
	private final NoticeService service;
	
	@RequestMapping("/groupware/board/noticeList.do")
	public String noticeUI() {
		return "groupware/board/noticeList";
	}
	
	@GetMapping(value="/groupware/board/noticeList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<NoticeVO> NoticeList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		,	@ModelAttribute("simpleCondition") SearchVO simpleCondition
		,	Authentication authentication
	) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper) authentication.getPrincipal();
		EmployeeVO authEmp = adapter.getRealUser();
		
		PagingVO<NoticeVO> pagingVO = new PagingVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		
		
		pagingVO.setComcode(authEmp.getComCode());
		int totalRecord = service.retrieveNoticeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<NoticeVO> postList = service.retrieveNoticeList(pagingVO);
		
		pagingVO.setDataList(postList);
		
		return pagingVO;
	}
	
	@GetMapping("/groupware/board/noticeView.do")
	public String noticeView(
			@RequestParam(required=true) int what
		,	Model model
	) {
		NoticeVO notice = service.retrieveNotice(what);
		model.addAttribute("notice", notice);
		
		return "groupware/board/noticeDetail";
	}
	
	@RequestMapping("/groupware/board/noticeDownload.do")
	public String download(
		@RequestParam(name="what", required=true) int attNo
		, Model model
	)throws IOException {
		AttatchVO attatch = service.retrieveAttatch(attNo);
		model.addAttribute("attatch", attatch);
		return "downloadView";
	}
}
