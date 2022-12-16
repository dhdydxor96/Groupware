package kr.or.ddit.autumn.groupware.survey.controller;

import java.util.List;

import org.springframework.http.MediaType;
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
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.survey.service.SurveyArticleService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyInvestigationService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyQuestionService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyResponseService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyResponseVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/groupware/survey")
public class SurveyInsertController {
	
	private final SurveyService surService;
	private final SurveyArticleService artService;
	private final SurveyQuestionService queService;
	private final SurveyInvestigationService invService;
	private final SurveyResponseService resService;
	
	@GetMapping("/surveyInsert.do")
	public String surveyForm(
		Authentication authentication,
		@ModelAttribute("survey") SurveyVO survey
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		log.info("Get 메소드 핸들러 surveyForm 실행");
		return "groupware/survey/surveyForm";
	}
	
	@PostMapping("/surveyInsert.do")
	public String surveyInsert(
		Authentication authentication,
		@ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("survey") SurveyVO survey
		, Errors errors
		, Model model
	) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		
		log.info("Post 메소드 핸들러 surveyInsert 실행");
		String viewName = null;
		
		if (!errors.hasErrors()) {
			ServiceResult result = surService.createSurvey(survey);

			if (result.equals(ServiceResult.OK)) {
				viewName = "redirect:/groupware/survey/surveyList.do";
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "groupware/survey/surveyForm";
			}
		} else {
			viewName = "groupware/survey/surveyForm";
		}
		return viewName;
	}
	
	@GetMapping("/surveyQuestionInsert.do")
	public String surveyQuestionForm(
		Authentication authentication,
		@ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		,	@ModelAttribute("survey") SurveyVO survey
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		List<SurveyVO> surveyList = queService.retrieveSurveyList(survey);
		model.addAttribute("surveyList", surveyList);
		
		log.info("Get 메소드 핸들러 surveyForm 실행");
		return "groupware/survey/surveyQuestionForm";
	}
	
	@PostMapping("/surveyQuestionInsert.do")
	public String surveyQuestionInsert(
		Authentication authentication,
		@ModelAttribute("survey") SurveyVO survey
		, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		, @ModelAttribute("employee") EmployeeVO employee
		, Errors errors
		, Model model
	) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		int surNo = survey.getSurNo();
		survey.setSurNo(surNo);
		surveyQuestion.setSurNo(survey.getSurNo());
		
		log.info("Post 메소드 핸들러 surveyInsert 실행");
		String viewName = null;
		
		if (!errors.hasErrors()) {
			ServiceResult result = queService.createSurveyQuestion(surveyQuestion);

			if (result.equals(ServiceResult.OK)) {
				viewName = "redirect:/groupware/survey/surveyQuestionList.do";
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "groupware/survey/surveyQuestionForm";
			}
		} else {
			viewName = "groupware/survey/surveyQuestionForm";
		}
		return viewName;
	}
	
	@GetMapping("/surveyArticleInsert.do")
	public String surveyArticleForm(
		Authentication authentication,
		@ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		,	@ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		List<SurveyQuestionVO> surveyQuestionList = artService.retrieveSurveyQuestionList(surveyQuestion);
		model.addAttribute("surveyQuestionList", surveyQuestionList);
		
		log.info("Get 메소드 핸들러 surveyForm 실행");
		return "groupware/survey/surveyArticleForm";
	}
	
	@PostMapping("/surveyArticleInsert.do")
	public String surveyArticleInsert(
		Authentication authentication,
		@ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
		, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		, @ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("survey") SurveyVO survey
		, Errors errors
		, Model model
	) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		int surqueNo = surveyQuestion.getSurqueNo();
		surveyQuestion.setSurqueNo(surqueNo);
		surveyArticle.setSurqueNo(surveyQuestion.getSurqueNo());
		
		log.info("Post 메소드 핸들러 surveyInsert 실행");
		String viewName = null;
		
		if (!errors.hasErrors()) {
			ServiceResult result = artService.createSurveyArticle(surveyArticle);

			if (result.equals(ServiceResult.OK)) {
				viewName = "redirect:/groupware/survey/surveyArticleList.do";
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "groupware/survey/surveyArticleForm";
			}
		} else {
			viewName = "groupware/survey/surveyArticleForm";
		}
		return viewName;
	}
	@ResponseBody
	@GetMapping(value = "/surveyQuestion.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<SurveyQuestionVO> surveyQuestion(
			Authentication authentication,
			@RequestParam(name="surNo") int surNo
			) {
		SurveyQuestionVO surveyQuestion = new SurveyQuestionVO();
		surveyQuestion.setSurNo(surNo);
		List<SurveyQuestionVO> surveyQuestionList = invService.retrieveSurveyQuestionList(surveyQuestion);
		return surveyQuestionList;
	}
	
	@ResponseBody
	@GetMapping(value = "/surveyArticle.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<SurveyArticleVO> surveyArticle(
			Authentication authentication,
			@RequestParam(name="surqueNo") int surqueNo
			) {
		SurveyArticleVO surveyArticle = new SurveyArticleVO();
		surveyArticle.setSurqueNo(surqueNo);
		List<SurveyArticleVO> surveyArticleList = invService.retrieveSurveyArticleList(surveyArticle);
		return surveyArticleList;
	}
	
	@GetMapping("/surveyInvestigationInsert.do")
	public String surveyInvestigationForm(
		Authentication authentication,
		@ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		,@ModelAttribute("survey") SurveyVO survey
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		SurveyArticleVO surveyArticle = new SurveyArticleVO();
		surveyArticle.setSurarcTurn(surveyInvestigation.getSurarcTurn());
		List<SurveyQuestionVO> surveyQuestionList = invService.retrieveSurveyQuestionList(surveyQuestion);
		List<SurveyArticleVO> surveyArticleList = invService.retrieveSurveyArticleList(surveyArticle);
		List<SurveyVO> surveyList = invService.retrieveSurveyList(survey);
		model.addAttribute("surveyQuestionList", surveyQuestionList);
		log.info(">>>> 잘 가져오나??? {}", surveyQuestionList);
		model.addAttribute("surveyArticleList", surveyArticleList);
		log.info(">>>> 잘 가져오나??? {}", surveyArticleList);
		model.addAttribute("surveyList", surveyList);
		log.info(">>>> 잘 가져오나??? {}", surveyList);
		
		log.info("Get 메소드 핸들러 surveyForm 실행");
		return "groupware/survey/surveyInvestigationForm";
	}
	
	
	@PostMapping("/surveyInvestigationInsert.do")
	public String surveyInvestigationInsert(
		Authentication authentication,
		@ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
		, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		, @ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("survey") SurveyVO survey
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, Errors errors
		, Model model
	) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		int surqueNo = surveyQuestion.getSurqueNo();
		surveyQuestion.setSurqueNo(surqueNo);
		surveyArticle.setSurqueNo(surveyQuestion.getSurqueNo());
		
		log.info("Post 메소드 핸들러 surveyInsert 실행");
		String viewName = null;
		
		if (!errors.hasErrors()) {
			ServiceResult result = invService.createSurveyInvestigation(surveyInvestigation,realuser.getComCode());

			if (result.equals(ServiceResult.OK)) {
				log.info("result : {}" + result);
				viewName = "redirect:/groupware/survey/surveyInvestigationList.do";
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "groupware/survey/surveyInvestigationForm";
			}
		} else {
			viewName = "groupware/survey/surveyInvestigationForm";
		}
		return viewName;
	}
	
	@GetMapping("/surveyResponseInsert.do")
	public String surveyResponseForm(
		Authentication authentication,
		@ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		,	@ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
		,	@ModelAttribute("survey") SurveyVO survey
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, @ModelAttribute("surveyResponse") SurveyResponseVO surveyResponse
		, @ModelAttribute("employee") EmployeeVO employee
		,@RequestParam(name="what" , required=true) int surinvNo
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		String empId = realuser.getEmpId();
		List<SurveyQuestionVO> surveyQuestionList = invService.retrieveSurveyQuestionList(surveyQuestion);
		List<SurveyArticleVO> surveyArticleList = invService.retrieveSurveyArticleList(surveyArticle);
		List<SurveyVO> surveyList = invService.retrieveSurveyList(survey);
		model.addAttribute("surveyQuestionList", surveyQuestionList);
		model.addAttribute("surveyArticleList", surveyArticleList);
		model.addAttribute("surveyList", surveyList);
		
		surveyInvestigation = invService.retrieveSurveyInvestigation(surinvNo);
		surveyInvestigation.setSurinvNo(surinvNo);
		surveyInvestigation.setEmpId(empId);
		model.addAttribute("surveyInvestigation", surveyInvestigation);
			if(surveyInvestigation.getSurinvType().equals("객관식")) {
				return "groupware/survey/surveyResponseChoiceForm";
			}else if(surveyInvestigation.getSurinvType().equals("주관식")) {
				return "groupware/survey/surveyResponseEssayForm";
			}
		return "groupware/survey/surveyProgressList";
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method=RequestMethod.GET)
	public int idChk(SurveyResponseVO surveyResponse, @RequestParam(name="surinvNo") int surinvNo, @RequestParam(name="empId") String empId ) {
		log.info("파라미터 값 {}", surveyResponse);
		
		surveyResponse.setSurinvNo(surveyResponse.getSurinvNo());
		surveyResponse.setEmpId(surveyResponse.getEmpId());
		log.info(empId);
		int result = resService.idCheck(surveyResponse);
		return result;
	}
	
	@PostMapping("/surveyResponseInsert.do")
	public String surveyResponseInsert(
		Authentication authentication,
		@ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
		, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		, @ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("survey") SurveyVO survey
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, @ModelAttribute("surveyResponse") SurveyResponseVO surveyResponse
		,@RequestParam(name="surinvNo" , required=true) int surinvNo
		, Errors errors
		, Model model
	) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		surveyResponse.setSurinvNo(surinvNo);
		surveyResponse.setEmpId(empId);
		surveyResponse.setSurresNo(surveyResponse.getSurresNo());
		
		log.info("Post 메소드 핸들러 surveyInsert 실행");
		String viewName = null;
		
		if (!errors.hasErrors()) {
			ServiceResult result = resService.createSurveyResponse(surveyResponse);

			if (result.equals(ServiceResult.OK)) {
				viewName = "redirect:/groupware/survey/surveyProgressList.do";
			} else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "groupware/survey/surveyResponseForm";
			}
		} else {
			viewName = "groupware/survey/surveyResponseForm";
		}
		return viewName;
	}
}
