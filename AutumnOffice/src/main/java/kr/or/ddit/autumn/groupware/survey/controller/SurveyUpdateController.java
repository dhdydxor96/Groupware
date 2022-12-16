package kr.or.ddit.autumn.groupware.survey.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.survey.service.SurveyArticleService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyInvestigationService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyQuestionService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/groupware/survey")
public class SurveyUpdateController {
	
	private final SurveyService surService;
	private final SurveyArticleService artService;
	private final SurveyQuestionService queService;
	private final SurveyInvestigationService invService;
	
	@GetMapping("/surveyUpdate.do")
	public String surveyEdit(
		Authentication authentication,
		@ModelAttribute("survey") SurveyVO survey
		,@RequestParam(name="what" , required=true) int surNo
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		survey = surService.retrieveSurvey(surNo);
		model.addAttribute("survey", survey);
		return "groupware/survey/surveyEdit";
	}
	
	@PostMapping("/surveyUpdate.do")
	public String surveyUpdate(Authentication authentication,
			@ModelAttribute("employee") EmployeeVO employee
			,@RequestParam(name="what" , required=true) int surNo
			, @ModelAttribute("survey") SurveyVO survey
			, Errors errors
			, Model model) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		survey.setSurNo(surNo);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = surService.modifySurvey(survey);
			String message = null;
			switch (result) {
			case OK:
				viewName = "redirect:/groupware/survey/surveyView.do?what=" + survey.getSurNo();
				break;
			default:
				message = "서버 오류";
				viewName = "groupware/survey/surveyEdit";
				break;
			}
			model.addAttribute("message", message);
		} else {
			viewName = "groupware/survey/surveyEdit";
		}
		return viewName;
	}
	
	@GetMapping("/surveyQuestionUpdate.do")
	public String surveyQuestionEdit(
		Authentication authentication,
		@ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		, @ModelAttribute("survey") SurveyVO survey
		,@RequestParam(name="what" , required=true) int surqueNo
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		List<SurveyVO> surveyList = queService.retrieveSurveyList(survey);
		model.addAttribute("surveyList", surveyList);
		
		surveyQuestion = queService.retrieveSurveyQuestion(surqueNo);
		model.addAttribute("surveyQuestion", surveyQuestion);
		return "groupware/survey/surveyQuestionEdit";
	}
	
	@PostMapping("/surveyQuestionUpdate.do")
	public String surveyQuestionUpdate(Authentication authentication,
			@ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
			,@RequestParam(name="what" , required=true) int surqueNo
			, @ModelAttribute("survey") SurveyVO survey
			, @ModelAttribute("employee") EmployeeVO employee
			, Errors errors
			, Model model) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		surveyQuestion.setSurqueNo(surqueNo);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = queService.modifySurveyQuestion(surveyQuestion);
			String message = null;
			switch (result) {
			case OK:
				viewName = "redirect:/groupware/survey/surveyQuestionView.do?what=" + surveyQuestion.getSurqueNo();
				break;
			default:
				message = "서버 오류";
				viewName = "groupware/survey/surveyQuestionEdit";
				break;
			}
			model.addAttribute("message", message);
		} else {
			viewName = "groupware/survey/surveyQuestionEdit";
		}
		return viewName;
	}
	
	@GetMapping("/surveyArticleUpdate.do")
	public String surveyArticleEdit(
		Authentication authentication,
		@ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
		, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		,@RequestParam(name="what" , required=true) int surarcNo
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		List<SurveyQuestionVO> surveyQuestionList = artService.retrieveSurveyQuestionList(surveyQuestion);
		model.addAttribute("surveyQuestionList", surveyQuestionList);
		
		surveyArticle = artService.retrieveSurveyArticle(surarcNo);
		model.addAttribute("surveyArticle", surveyArticle);
		return "groupware/survey/surveyArticleEdit";
	}
	
	@PostMapping("/surveyArticleUpdate.do")
	public String surveyArticleUpdate(Authentication authentication,
			@ModelAttribute("employee") EmployeeVO employee
			,@RequestParam(name="what" , required=true) int surarcNo
			, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
			, @ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
			, @ModelAttribute("survey") SurveyVO survey
			, Errors errors
			, Model model) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		surveyQuestion.setSurqueNo(surveyQuestion.getSurqueNo());
		surveyArticle.setSurarcNo(surarcNo);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = artService.modifySurveyArticle(surveyArticle);
			String message = null;
			switch (result) {
			case OK:
				viewName = "redirect:/groupware/survey/surveyArticleView.do?what=" + surveyArticle.getSurarcNo();
				break;
			default:
				message = "서버 오류";
				viewName = "groupware/survey/surveyArticleEdit";
				break;
			}
			model.addAttribute("message", message);
		} else {
			viewName = "groupware/survey/surveyArticleEdit";
		}
		return viewName;
	}
	
	@GetMapping("/surveyInvestigationUpdate.do")
	public String surveyInvestigationEdit(
		Authentication authentication,
		@ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
		, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
		, @ModelAttribute("survey") SurveyVO survey
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		,@RequestParam(name="what" , required=true) int surinvNo
		, Model model
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		List<SurveyQuestionVO> surveyQuestionList = invService.retrieveSurveyQuestionList(surveyQuestion);
		List<SurveyVO> surveyList = invService.retrieveSurveyList(survey);
		List<SurveyArticleVO> surveyArticleList = invService.retrieveSurveyArticleList(surveyArticle);
		model.addAttribute("surveyQuestionList", surveyQuestionList);
		model.addAttribute("surveyList", surveyList);
		model.addAttribute("surveyArticleList", surveyArticleList);
		
		surveyInvestigation = invService.retrieveSurveyInvestigation(surinvNo);
		model.addAttribute("surveyInvestigation", surveyInvestigation);
		return "groupware/survey/surveyInvestigationEdit";
	}
	
	@PostMapping("/surveyInvestigationUpdate.do")
	public String surveyInvestigationUpdate(Authentication authentication,
			@ModelAttribute("employee") EmployeeVO employee
			,@RequestParam(name="what" , required=true) int surinvNo
			, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
			, @ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
			, @ModelAttribute("survey") SurveyVO survey
			, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
			, Errors errors
			, Model model) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		surveyQuestion.setSurqueNo(surveyQuestion.getSurqueNo());
		surveyInvestigation.setSurinvNo(surinvNo);
		
		String viewName = null;
		log.info("에러스 : {}", errors);
		if (!errors.hasErrors()) {
			ServiceResult result = invService.modifySurveyInvestigation(surveyInvestigation);
			String message = null;
			switch (result) {
			case OK:
				viewName = "redirect:/groupware/survey/surveyInvestigationView.do?what=" + surveyInvestigation.getSurinvNo();
				break;
			default:
				message = "서버 오류";
				viewName = "groupware/survey/surveyInvestigationEdit";
				break;
			}
			model.addAttribute("message", message);
		} else {
			viewName = "groupware/survey/surveyInvestigationEdit";
		}
		return viewName;
	}
	
	@GetMapping("/surveyInvestigationDelete.do")
	public String surveyInvestigationDelete(
		Authentication authentication,
		@ModelAttribute("employee") EmployeeVO employee
		,@RequestParam(name="what" , required=true) int surinvNo	
		,@RequestParam(name="surNo" , required=true) int surNo	
		,@RequestParam(name="surqueNo" , required=true) int surqueNo	
//		,@RequestParam(name="surarcNo" , required=true) int surarcNo	
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
	) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		surveyInvestigation.setSurinvNo(surinvNo);
		// surveyInvestigation 정보가 다 담겨있음
		// 설문지 삭제
		SurveyVO survey = new SurveyVO();
		SurveyQuestionVO surveyQuestion = new SurveyQuestionVO();
//		SurveyArticleVO surveyArticle = new SurveyArticleVO();
		survey.setSurNo(surveyInvestigation.getSurNo());
		surveyQuestion.setSurqueNo(surveyInvestigation.getSurqueNo());
//		surveyArticle.setSurarcNo(surveyInvestigation.getSurarcNo());
		// 설문지 삭제하는 서비스 
		surService.removeSurvey(survey);
		// 설문 문항 삭제
		queService.removeSurveyQuestion(surveyQuestion);
		// 설문 항목 삭제
//		artService.removeSurveyArticle(surveyArticle);
		invService.removeSurveyInvestigation(surveyInvestigation);
		return "redirect:/groupware/survey/surveyInvestigationList.do";
		
	}
	
}
