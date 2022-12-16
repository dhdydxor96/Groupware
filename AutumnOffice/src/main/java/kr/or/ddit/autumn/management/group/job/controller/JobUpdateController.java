package kr.or.ddit.autumn.management.group.job.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.job.service.JobService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.JobVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/management/group/job/jobUpdate.do")
public class JobUpdateController {
	private final JobService service;

	@GetMapping
	public String updateForm(Authentication authentication,@RequestParam(name = "what", required = true) int jobId, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		JobVO job = service.retrieveJob(jobId);
		job.setComCode(comCode);
		job.setJobId(jobId);
		List<JobVO> jobList = service.jobList(job);
		model.addAttribute("jobList",jobList);
		model.addAttribute("job", job);
		return "management/group/jobEdit";
	}

	@PostMapping
	public String jobUpdate(Authentication authentication, @ModelAttribute("job") JobVO job, BindingResult errors,
			Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		job.setComCode(comCode);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = service.modifyJob(job);
			String message = null;
			switch (result) {
			case OK:
				viewName = "redirect:/management/group/job/jobView.do?what=" + job.getJobId();
				break;
			default:
				message = "서버 오류";
				viewName = "management/group/jobEdit";
				break;
			}
			model.addAttribute("message", message);
		} else {
			viewName = "management/group/jobEdit";
		}
		return viewName;
	}
}
