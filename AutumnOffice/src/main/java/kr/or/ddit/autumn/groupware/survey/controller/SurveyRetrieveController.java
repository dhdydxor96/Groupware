package kr.or.ddit.autumn.groupware.survey.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.survey.service.SurveyArticleService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyInvestigationService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyQuestionService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyResponseService;
import kr.or.ddit.autumn.groupware.survey.service.SurveyService;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyResponseVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/groupware/survey")
public class SurveyRetrieveController {
	
	private final SurveyService surService;
	private final SurveyArticleService artService;
	private final SurveyQuestionService queService;
	private final SurveyInvestigationService invService;
	private final SurveyResponseService resService;
	
	@RequestMapping(value="/surveyStateUpdate.do")
	public String updateStateUpdate(Authentication authentication, RedirectAttributes ratt) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		SurveyVO survey = new SurveyVO();
		
		ServiceResult result1 = surService.modifySurveyStateOne(survey);
		ServiceResult result2 = surService.modifySurveyStateTwo(survey);
		
		if(result1.equals(ServiceResult.FAIL) && (result2.equals(ServiceResult.FAIL))) {
			ratt.addFlashAttribute("message", "설문 업데이트에 실패하였습니다. 잠시 뒤 다시 시도해주세요.");
		}
		
		return "redirect:/groupware/survey/surveyList.do";
	}
	
	
	@GetMapping("/surveyList.do")
	public String surveyListUI() {
		return "groupware/survey/surveyList";
	}
	
	@GetMapping(value="/surveyList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyVO> surveyList(
		Authentication authentication,
		@RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
		, @ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("survey") SurveyVO survey
	){
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		String empId = realuser.getEmpId();
		employee.setEmpId(empId);
		survey.setEmpId(employee.getEmpId());
		
		PagingVO<SurveyVO> pagingVO = new PagingVO<>(5,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		log.info("pagingvo : {}", pagingVO.getComCode());
		int totalRecord = surService.retrieveSurveyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyVO> surveyList = surService.retrieveSurveyList(pagingVO);
		pagingVO.setDataList(surveyList);
		
		return pagingVO;
	}
	
	@GetMapping("/surveyView.do")
	public ModelAndView surveyView(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surNo 
		,@ModelAttribute("employee") EmployeeVO employee
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		SurveyVO survey = surService.retrieveSurvey(surNo);
		employee.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("survey", survey);
		mav.setViewName("groupware/survey/surveyView");
		return mav;
	}
	
	@GetMapping("/surveyQuestionList.do")
	public String surveyQuestionListUI() {
		return "groupware/survey/surveyQuestionList";
	}
	
	@GetMapping(value="/surveyQuestionList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyQuestionVO> surveyQuestionList(
			Authentication authentication,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @ModelAttribute("survey") SurveyVO survey
			){
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<SurveyQuestionVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		survey.setSurTitle(survey.getSurTitle());
		int totalRecord = queService.retrieveSurveyQuestionCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyQuestionVO> surveyQuestionList = queService.retrieveSurveyQuestionList(pagingVO);
		pagingVO.setDataList(surveyQuestionList);
		
		return pagingVO;
	}
	
	@GetMapping("/surveyQuestionView.do")
	public ModelAndView surveyQuestionView(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surqueNo 
		,@ModelAttribute("employee") EmployeeVO employee
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		SurveyQuestionVO surveyQuestion = queService.retrieveSurveyQuestion(surqueNo);
		employee.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("surveyQuestion", surveyQuestion);
		mav.setViewName("groupware/survey/surveyQuestionView");
		return mav;
	}
	
	@GetMapping("/surveyArticleList.do")
	public String surveyArticleListUI() {
		return "groupware/survey/surveyArticleList";
	}
	
	@GetMapping(value="/surveyArticleList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyArticleVO> surveyArticleList(
			Authentication authentication,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
			){
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<SurveyArticleVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		surveyQuestion.setSurqueContent(surveyQuestion.getSurqueContent());
		int totalRecord = artService.retrieveSurveyArticleCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyArticleVO> surveyArticleList = artService.retrieveSurveyArticleList(pagingVO);
		pagingVO.setDataList(surveyArticleList);
		
		return pagingVO;
	}
	
	@GetMapping("/surveyArticleView.do")
	public ModelAndView surveyArticleView(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surarcNo 
		,@ModelAttribute("employee") EmployeeVO employee
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		SurveyArticleVO surveyArticle = artService.retrieveSurveyArticle(surarcNo);
		employee.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("surveyArticle", surveyArticle);
		mav.setViewName("groupware/survey/surveyArticleView");
		return mav;
	}
	
	@GetMapping("/surveyInvestigationList.do")
	public String surveyInvestigationListUI() {
		return "groupware/survey/surveyInvestigationList";
	}
	
	@GetMapping(value="/surveyInvestigationList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyInvestigationVO> surveyInvestigationList(
			Authentication authentication,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
			, @ModelAttribute("survey") SurveyVO survey
			, @ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
			){
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<SurveyInvestigationVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		surveyQuestion.setSurqueContent(surveyQuestion.getSurqueContent());
		int totalRecord = invService.retrieveSurveyInvestigationCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyInvestigationVO> surveyInvestigationList = invService.retrieveSurveyInvestigationList(pagingVO);
		pagingVO.setDataList(surveyInvestigationList);
		
		return pagingVO;
	}
	
	@GetMapping("/surveyInvestigationView.do")
	public ModelAndView surveyInvestigationView(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surinvNo 
		,@ModelAttribute("employee") EmployeeVO employee
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		SurveyInvestigationVO surveyInvestigation = invService.retrieveSurveyInvestigation(surinvNo);
		log.info(">>> 상세정보로 넘어갈때 들고가는 정보 {}", surveyInvestigation);
		employee.setComCode(comCode);
		ModelAndView mav = new ModelAndView();
		mav.addObject("surveyInvestigation", surveyInvestigation);
			if(surveyInvestigation.getSurinvType().equals("객관식")) {
				mav.setViewName("groupware/survey/surveyInvestigationChoiceView");
			}else if(surveyInvestigation.getSurinvType().equals("주관식"))
				mav.setViewName("groupware/survey/surveyInvestigationEssayView");
		return mav;
	}
	
	@GetMapping("/surveyProgressResponseChart.do")
	public ModelAndView surveyResponseChartUI(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surinvNo 
		,@ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, @ModelAttribute("surveyResponse") SurveyResponseVO surveyResponse
		, Model model
		, RedirectAttributes ratt
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		surveyInvestigation.setSurqueNo(surveyInvestigation.getSurqueNo());
		List<SurveyResponseVO> surveyResponseList =  resService.selectSurveyResponseList(surinvNo);
		surveyInvestigation = invService.retrieveSurveyInvestigation(surinvNo);
		ModelAndView mav = new ModelAndView();
		mav.addObject("surveyResponse",surveyResponseList);
		if(surveyInvestigation.getSurinvType().equals("객관식")) {
			mav.setViewName("groupware/survey/surveyProgressResponseChart");
		}
		return mav;
	}
	
	
	@GetMapping("/surveyProgressEssayResponseChart.do")
	public ModelAndView surveyProgressEssayResponseChartUI(@RequestParam(name="what", required=true) int surinvNo ,Model model) {
		ModelAndView mav = new ModelAndView();
		SurveyVO survey = new SurveyVO();
		SurveyInvestigationVO surveyInvestigation = new SurveyInvestigationVO();
		List<SurveyInvestigationVO> surveyInvestigationList = resService.retrieveSurveyInvestigationList(surveyInvestigation);
		List<SurveyVO> surveyList = resService.retrieveSurveyList(survey);
		List<SurveyResponseVO> surveyResponseList2 =  resService.selectSurveyResponseList(surinvNo);
		
		mav.addObject("survey",surveyList);
		mav.addObject("surveyInvestigation",surveyInvestigationList);
		mav.addObject("surveyResponse2",surveyResponseList2);
		mav.setViewName("groupware/survey/surveyEssayResponseChart");
		return mav;
	}
	
	@GetMapping(value = "/surveyProgressEssayResponseChart.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyResponseVO> surveyProgressEssayResponseChartList(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surinvNo 
		, @RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
		, @ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, @ModelAttribute("surveyResponse") SurveyResponseVO surveyResponse
		, Model model
		, RedirectAttributes ratt
	) {
		log.info("여긴 ajax 주관식");
		
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		SurveyVO survey = new SurveyVO();
		
		surveyResponse.setSurinvNo(surinvNo);
		surveyResponse.setSurTitle(surveyInvestigation.getSurTitle());
		surveyResponse.setSurSdate(surveyInvestigation.getSurSdate());
		surveyResponse.setSurEdate(surveyInvestigation.getSurEdate());
		surveyResponse.setSurGuide(surveyInvestigation.getSurGuide());
		surveyResponse.setSurPurpose(surveyInvestigation.getSurPurpose());
		List<SurveyVO> surveyList = resService.retrieveSurveyList(survey);
		model.addAttribute("surveyList", surveyList);
		
		
		model.addAttribute("surveyResponse",surveyResponse);
		PagingVO<SurveyResponseVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		pagingVO.setSurinvNo(surinvNo);
		int totalRecord = resService.retrieveSurveyResponseCount(pagingVO);
		log.info(">>>>>>>>>>>>> {}",totalRecord);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyResponseVO> surveyResponseList =  resService.retrieveSurveyResponseList(pagingVO);
		log.info(">>>>>>>>>>>>> {}",surveyResponseList);
		pagingVO.setDataList(surveyResponseList);
		
		return pagingVO;
	}
	
	@GetMapping("/surveyDeadlineResponseChart.do")
	public ModelAndView surveyDeadlineResponseChartUI(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surinvNo 
		,@ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, @ModelAttribute("surveyResponse") SurveyResponseVO surveyResponse
		, Model model
		, RedirectAttributes ratt
	) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		surveyInvestigation.setSurqueNo(surveyInvestigation.getSurqueNo());
		List<SurveyResponseVO> surveyResponseList =  resService.selectSurveyResponseList(surinvNo);
		surveyInvestigation = invService.retrieveSurveyInvestigation(surinvNo);
		ModelAndView mav = new ModelAndView();
		mav.addObject("surveyResponse",surveyResponseList);
		if(surveyInvestigation.getSurinvType().equals("객관식")) {
			mav.setViewName("groupware/survey/surveyDeadlineResponseChart");
		}
		return mav;
	}
	
	@GetMapping("/surveyDeadlineEssayResponseChart.do")
	public ModelAndView surveyDeadlineEssayResponseChartUI(@RequestParam(name="what", required=true) int surinvNo ,Model model) {
		ModelAndView mav = new ModelAndView();
		SurveyVO survey = new SurveyVO();
		SurveyInvestigationVO surveyInvestigation = new SurveyInvestigationVO();
		List<SurveyInvestigationVO> surveyInvestigationList = resService.retrieveSurveyInvestigationList(surveyInvestigation);
		List<SurveyVO> surveyList = resService.retrieveSurveyList(survey);
		List<SurveyResponseVO> surveyResponseList2 =  resService.selectSurveyResponseList(surinvNo);
		
		mav.addObject("survey",surveyList);
		mav.addObject("surveyInvestigation",surveyInvestigationList);
		mav.addObject("surveyResponse2",surveyResponseList2);
		mav.setViewName("groupware/survey/surveyDeadlineEssayResponseChart");
		return mav;
	}
	
	@GetMapping(value = "/surveyDeadlineEssayResponseChart.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyResponseVO> surveyDeadlineEssayResponseChartList(
		Authentication authentication,
		@RequestParam(name="what", required=true) int surinvNo 
		, @RequestParam(name="page", required=false, defaultValue="1") int currentPage
		, @ModelAttribute("simpleCondition") SearchVO simpleCondition
		, @ModelAttribute("employee") EmployeeVO employee
		, @ModelAttribute("surveyInvestigation") SurveyInvestigationVO surveyInvestigation
		, @ModelAttribute("surveyResponse") SurveyResponseVO surveyResponse
		, Model model
		, RedirectAttributes ratt
	) {
		
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		SurveyVO survey = new SurveyVO();
		
		surveyResponse.setSurinvNo(surinvNo);
		surveyResponse.setSurTitle(surveyInvestigation.getSurTitle());
		surveyResponse.setSurSdate(surveyInvestigation.getSurSdate());
		surveyResponse.setSurEdate(surveyInvestigation.getSurEdate());
		surveyResponse.setSurGuide(surveyInvestigation.getSurGuide());
		surveyResponse.setSurPurpose(surveyInvestigation.getSurPurpose());
		List<SurveyVO> surveyList = resService.retrieveSurveyList(survey);
		model.addAttribute("surveyList", surveyList);
		
		model.addAttribute("surveyResponse",surveyResponse);
		PagingVO<SurveyResponseVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		pagingVO.setSurinvNo(surinvNo);
		int totalRecord = resService.retrieveSurveyResponseCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyResponseVO> surveyDeadlineResponseList =  resService.retrieveSurveyDeadlineResponseList(pagingVO);
		pagingVO.setDataList(surveyDeadlineResponseList);
		
		return pagingVO;
	}
	
	@GetMapping("/surveyDeadlineList.do")
	public String surveyDeadlineListUI() {
		return "groupware/survey/surveyDeadlineList";
	}
	
	@GetMapping(value="/surveyDeadlineList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyInvestigationVO> surveyDeadlineList(
			Authentication authentication,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
			, @ModelAttribute("survey") SurveyVO survey
			, @ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
			){
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<SurveyInvestigationVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		surveyQuestion.setSurqueContent(surveyQuestion.getSurqueContent());
		int totalRecord = invService.retrieveSurveyInvestigationCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyInvestigationVO> surveyDeadlineList = invService.retrieveSurveyDeadlineList(pagingVO);
		pagingVO.setDataList(surveyDeadlineList);
		
		return pagingVO;
	}
	
	@GetMapping("/surveyProgressList.do")
	public String surveyProgressListUI() {
		return "groupware/survey/surveyProgressList";
	}
	
	@GetMapping(value="/surveyProgressList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<SurveyInvestigationVO> surveyProgressList(
			Authentication authentication,
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @ModelAttribute("surveyQuestion") SurveyQuestionVO surveyQuestion
			, @ModelAttribute("survey") SurveyVO survey
			, @ModelAttribute("surveyArticle") SurveyArticleVO surveyArticle
			){
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		PagingVO<SurveyInvestigationVO> pagingVO = new PagingVO<>(10,3);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setSimpleCondition(simpleCondition);
		pagingVO.setComcode(comCode);
		surveyQuestion.setSurqueContent(surveyQuestion.getSurqueContent());
		int totalRecord = invService.retrieveSurveyInvestigationCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<SurveyInvestigationVO> surveyProgressList = invService.retrieveSurveyProgressList(pagingVO);
		pagingVO.setDataList(surveyProgressList);
		
		return pagingVO;
	}
	
}
