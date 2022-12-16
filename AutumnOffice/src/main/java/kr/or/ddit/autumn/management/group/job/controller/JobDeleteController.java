package kr.or.ddit.autumn.management.group.job.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.job.service.JobService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.JobVO;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/management/group/job/jobDelete.do")
public class JobDeleteController {
	private final JobService service;
	
	@GetMapping
	public String jobDelete(
		Authentication authentication,
		@RequestParam(name="what", required=true) int jobId
		, @ModelAttribute("job") JobVO job
		, RedirectAttributes redirectAttributes
	) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		job.setComCode(comCode);
		
		job.setJobId(jobId);
		service.removeJob(job);
		return "redirect:/management/group/job/jobList.do";
	}
}
