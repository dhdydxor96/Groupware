package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.employee.service.EmployeeService;
import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.commons.notify.service.NotifyService;
import kr.or.ddit.autumn.groupware.survey.dao.SurveyArticleDAO;
import kr.or.ddit.autumn.groupware.survey.dao.SurveyDAO;
import kr.or.ddit.autumn.groupware.survey.dao.SurveyInvestigationDAO;
import kr.or.ddit.autumn.groupware.survey.dao.SurveyQusetionDAO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyResponseVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SurveyInvestigationServiceImpl implements SurveyInvestigationService{
	
	private final SurveyInvestigationDAO invDAO;
	private final SurveyDAO surDAO;
	private final SurveyQusetionDAO queDAO;
	private final SurveyArticleDAO arcDAO;
	//알림을 위한 서비스 
	private final NotifyService notifyService;
	private final EmployeeService EmployeeService;
	
	@Override
	public ServiceResult createSurveyInvestigation(SurveyInvestigationVO surveyInvestigation,String comCode) {
		int rowcnt = invDAO.insertSurveyInvestigation(surveyInvestigation);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		EmployeeVOWrapper employeeWrapper = (EmployeeVOWrapper) principal;
		EmployeeVO employee = employeeWrapper.getRealUser();
		//알림기능
		List<EmployeeVO> EmployeeList 
    	= EmployeeService.allRetrieveEmployeeList(comCode);
		for(EmployeeVO empVO : EmployeeList) {
			if(!empVO.getEmpId().equals(employee.getEmpId())) {
				notifyService.notifyInsertModule(empVO.getEmpId(), 4);
			}
		}
				
			
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public SurveyInvestigationVO retrieveSurveyInvestigation(int surinvNo) {
		SurveyInvestigationVO surveyInvestigation = invDAO.selectSurveyInvestigation(surinvNo);
		if(surveyInvestigation == null)
			throw new RuntimeException(String.format("%d 설문조사의 설문조사가 없음", surinvNo));
		return surveyInvestigation;
	}

	@Override
	public int retrieveSurveyInvestigationCount(PagingVO<SurveyInvestigationVO> pagingVO) {
		return invDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public List<SurveyInvestigationVO> retrieveSurveyInvestigationList(PagingVO<SurveyInvestigationVO> pagingVO) {
		return invDAO.selectSurveyInvestigationList(pagingVO);
	}

	@Override
	public ServiceResult modifySurveyInvestigation(SurveyInvestigationVO surveyInvestigation) {
		int rowcnt = invDAO.updateSurveyInvestigation(surveyInvestigation);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public ServiceResult removeSurveyInvestigation(SurveyInvestigationVO surveyInvestigation) {
		int rowcnt = invDAO.deleteSurveyInvestigation(surveyInvestigation);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<SurveyVO> retrieveSurveyList(SurveyVO survey) {
		return invDAO.selectSurveyList(survey);
	}

	@Override
	public List<SurveyQuestionVO> retrieveSurveyQuestionList(SurveyQuestionVO surveyQuestion) {
		return invDAO.selectSurveyQuestionList(surveyQuestion);
	}

	@Override
	public List<SurveyArticleVO> retrieveSurveyArticleList(SurveyArticleVO surveyArticle) {
		return invDAO.selectSurveyArticleList(surveyArticle);
	}

	@Override
	public List<SurveyInvestigationVO> retrieveSurveyDeadlineList(PagingVO<SurveyInvestigationVO> pagingVO) {
		return invDAO.selectSurveyDeadlineList(pagingVO);
	}

	@Override
	public List<SurveyInvestigationVO> retrieveSurveyProgressList(PagingVO<SurveyInvestigationVO> pagingVO) {
		return invDAO.selectSurveyProgressList(pagingVO);
	}




}
