package kr.or.ddit.autumn.management.group.job.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.management.group.job.service.JobService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.JobVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/management/group/job")
public class JobInsertController {
	private final JobService service;

	@ModelAttribute("job")
	public JobVO job() {
		log.info("@ModelAttribute 메소드 실행.");
		return new JobVO();
	}

	@GetMapping("/jobInsert.do")
	public String jobForm(Authentication authentication,@ModelAttribute("job") JobVO job, Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		job.setComCode(comCode);
		log.info("Get 메소드 핸들러 jobForm 실행");
		List<JobVO> jobList = service.jobList(job);
		model.addAttribute("jobList",jobList);
		return "management/group/jobForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method=RequestMethod.GET)
	public int idChk(JobVO job, @RequestParam(name="jobId") int jobId) {
		job.setJobId(jobId);
		int result = service.idCheck(job);
		return result;
	}

	@PostMapping("/jobInsert.do")
	public String jobInsert(Authentication authentication, @ModelAttribute("job") JobVO job, Errors errors,
		Model model) {
		CompanyVOWrapper adapter = (CompanyVOWrapper) authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		job.setComCode(comCode);
		
		log.info("파라미터 정보 {}", job);
		
		log.info("Post 메소드 핸들러 jobInsert 실행");
		String viewName = null;

		if (!errors.hasErrors()) {
			ServiceResult result = service.createJob(job);

			if (result.equals(ServiceResult.OK)) {
				viewName = "redirect:/management/group/job/jobView.do?what=" + job.getJobId();
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "management/group/jobForm";
			}
		} else {
			viewName = "management/group/jobForm";
		}
		return viewName;
	}

}
