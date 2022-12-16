package kr.or.ddit.autumn.groupware.approval.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.groupware.approval.vo.DocBoxPagingVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/approval/doc")
public class RefDocBoxSelectController {
	
	@Inject
	private ApprovalService service;
	
	// 참조/열람 문서함 접근
	@RequestMapping("/refDocList.do")
	public String refDocList() {
		return "groupware/approval/refdocboxList";
	}
	
	@GetMapping(value="/refDocList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public DocBoxPagingVO<ElecAppVO> elecAppList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
			, @RequestParam(name="state", required=false) String state
	){
		log.info("recieve param[currentPage] : {}", currentPage);
		log.info("recieve param[simpleCondition] : {}", simpleCondition);
		log.info("recieve param[state] : {}", state);
		
		DocBoxPagingVO<ElecAppVO> pagingVO = new DocBoxPagingVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setEmpId(employee.getEmpId());
		pagingVO.setMenuFlag(state);
		simpleCondition.setState(state);
		int totalRecord = service.retrieveElecAppCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ElecAppVO> elecAppList = service.retrieveElecAppList(pagingVO);
		pagingVO.setDataList(elecAppList);
		
		return pagingVO;
	}
}
