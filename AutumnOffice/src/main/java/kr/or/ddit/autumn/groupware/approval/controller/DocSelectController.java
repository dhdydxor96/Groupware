package kr.or.ddit.autumn.groupware.approval.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import kr.or.ddit.autumn.vo.AplDetailVO;
import kr.or.ddit.autumn.vo.AppStatusVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/approval/doc/")
public class DocSelectController {
	
	@Inject
	private ApprovalService service;
	
	// 결재 대기 뷰 이동
	@RequestMapping("/waitAppDocList.do")
	public String waitAppDocUI() {
		return "groupware/approval/waitAppDocList";
	}
	
	// 결재 대기 문서 리스트 Json 데이터로 변환
	@GetMapping(value="/waitAppDocList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public DocBoxPagingVO<ElecAppVO> elecAppList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
	){
		log.info("recieve param[currentPage] : {}", currentPage);
		log.info("recieve param[simpleCondition] : {}", simpleCondition);
		
		DocBoxPagingVO<ElecAppVO> pagingVO = new DocBoxPagingVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setEmpId(employee.getEmpId());
		pagingVO.setMenuFlag("wait");
		pagingVO.setAppFlag("wait");
		int totalRecord = service.retrieveElecAppCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ElecAppVO> elecAppList = service.retrieveElecAppList(pagingVO);
		pagingVO.setDataList(elecAppList);
		
		return pagingVO;
	}
	
	// 결재 대기 문서 상세 조회
	@GetMapping("/waitAppDocDetail.do")
	public String waitAppDocDetail(@RequestParam(name="eleNo", required=true) int eleNo
			, Model model
		) {
		
		ElecAppVO elecApp = service.retrieveElecApp(eleNo);
		log.info("문서 데이터 : {}", elecApp);
		
		model.addAttribute("elecApp", elecApp);
		model.addAttribute("eleMenu", "결재 대기 문서");
		
		return "groupware/approval/waitAppDocView";
	}
	
	@GetMapping(value="/aplDetailList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> aplDetailList(@RequestParam(name="aplNo", required=true) int aplNo) {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		List<AplDetailVO> aplDetail = service.retrieveAplDetailList(aplNo);
		AppStatusVO appStatus = service.retrieveAppStatus(aplNo);
		
		dataMap.put("aplDetail", aplDetail);
		dataMap.put("appStatus", appStatus);
		
		return dataMap;
	}
	
	// 결재 예정 문서 이동
	@GetMapping("/dueAppDocList.do")
	public String dueAppDocUI() {
		return "groupware/approval/dueAppDocList";
	}
	
	// 결재 예정 문서 리스트 Json 데이터로 변환
	@GetMapping(value="/dueAppDocList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public DocBoxPagingVO<ElecAppVO> dueAppList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
	){
		log.info("recieve param[currentPage] : {}", currentPage);
		log.info("recieve param[simpleCondition] : {}", simpleCondition);
		
		DocBoxPagingVO<ElecAppVO> pagingVO = new DocBoxPagingVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		simpleCondition.setState("0");
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setEmpId(employee.getEmpId());
		pagingVO.setMenuFlag("due");
		pagingVO.setAppFlag("expected");
		int totalRecord = service.retrieveElecAppCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<ElecAppVO> elecAppList = service.retrieveElecAppList(pagingVO);
		pagingVO.setDataList(elecAppList);
		
		return pagingVO;
	}
	
	@GetMapping("/docDetail.do")
	public String draftDocDetail(@RequestParam(name="eleNo", required=true) int eleNo
			, @RequestParam(name="eleMenu", required=true) String eleMenu
			, Model model
		) {
		
		ElecAppVO elecApp = service.retrieveElecApp(eleNo);
		log.info("문서 데이터 : {}", elecApp);
		
		model.addAttribute("elecApp", elecApp);
		model.addAttribute("eleMenu", eleMenu);
		
		return "groupware/approval/waitAppDocView";
	}
}
