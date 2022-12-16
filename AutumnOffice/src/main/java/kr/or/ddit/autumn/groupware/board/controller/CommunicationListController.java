package kr.or.ddit.autumn.groupware.board.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.board.dao.BoardDAO;
import kr.or.ddit.autumn.groupware.board.service.CommunicationService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CommentsVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PostVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/groupware/board")
@RequiredArgsConstructor
public class CommunicationListController {
	
	private final CommunicationService service;
	private final BoardDAO boardDAO;
	
	@ModelAttribute("post")
	public PostVO post(Authentication authentication) {
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper) authentication.getPrincipal();
		EmployeeVO authEmp = adapter.getRealUser();
		
		log.info(authEmp.getEmpId());
		
		PostVO post = new PostVO();
		
		String empId = authEmp.getEmpId();
		String comCode = authEmp.getComCode();
		
		post.setEmpId(empId);
		post.setBoardList(boardDAO.selectCategory(comCode));

		return post;
	}
	
	@GetMapping(value="/communicationList.do")
	public String communityUI() {
		return "groupware/board/communicationList";
	}
	
	@GetMapping(value="/communicationList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<PostVO> communicationList(
				@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			,	@ModelAttribute("simpleCondition") SearchVO simpleCondition
			,	Authentication authentication
			) {
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper) authentication.getPrincipal();
		EmployeeVO authEmp = adapter.getRealUser();
		
		PagingVO<PostVO> pagingVO = new PagingVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setBoCode(simpleCondition.getSearchCommunity());
		
		pagingVO.setComcode(authEmp.getComCode());
		int totalRecord = service.retrievePostCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<PostVO> postList = service.retrievePostList(pagingVO);
		
		log.info("postList : " + postList);
		
		pagingVO.setDataList(postList);
		
		log.info("pagingVO : " + pagingVO.getDataList());
		
		return pagingVO;
	}
	
	@GetMapping("/communicationView.do")
	public String postView(
			@RequestParam(required=true) int what
		,	Model model
	) {
		PostVO post = service.retrievePost(what);
		model.addAttribute("post", post);
		
		return "groupware/board/communicationDetail";
	}
	
	@PostMapping(value="/communicationView.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String communicationReplyList(@ModelAttribute("comments") CommentsVO comments) {
		String viewName = null;
				
		
		return viewName;
	}
	
	@RequestMapping("/communicationDownload.do")
	public String download(
		@RequestParam(name="what", required=true) int attNo
		, Model model
	)throws IOException {
		AttatchVO attatch = service.retrieveAttatch(attNo);
		model.addAttribute("attatch", attatch);
		return "downloadView";
	}
	
}
