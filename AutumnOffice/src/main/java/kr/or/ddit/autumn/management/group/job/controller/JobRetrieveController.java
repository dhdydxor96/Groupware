package kr.or.ddit.autumn.management.group.job.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.job.service.JobService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/management/group/job")
public class JobRetrieveController {
	private final JobService service;
	
	@GetMapping("/jobList.do")
	public String listUI() {
		return "management/group/jobList";
	}
	
	@GetMapping(value="/jobList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<JobVO> jobList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
	){
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<JobVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		int totalRecord = service.retrieveJobCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<JobVO> jobList = service.retrieveJobList(pagingVO);
		pagingVO.setDataList(jobList);
		
		return pagingVO;
	}
	
	@GetMapping("/jobView.do")
	public ModelAndView jobView(Authentication authentication,
		@RequestParam(name="what", required=true) int jobId) {
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		JobVO job = service.retrieveJob(jobId);
		job.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("job", job);
		mav.setViewName("management/group/jobView");
		return mav;
	}
}
