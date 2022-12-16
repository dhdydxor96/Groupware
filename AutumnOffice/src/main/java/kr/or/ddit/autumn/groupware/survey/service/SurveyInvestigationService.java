package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyResponseVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface SurveyInvestigationService {
	public ServiceResult createSurveyInvestigation(SurveyInvestigationVO surveyInvestigation,String comCode);
	public SurveyInvestigationVO retrieveSurveyInvestigation(int surinvNo);
	public int retrieveSurveyInvestigationCount(PagingVO<SurveyInvestigationVO> pagingVO);
	public List<SurveyInvestigationVO> retrieveSurveyInvestigationList(PagingVO<SurveyInvestigationVO> pagingVO);
	public List<SurveyInvestigationVO> retrieveSurveyDeadlineList(PagingVO<SurveyInvestigationVO> pagingVO);
	public List<SurveyInvestigationVO> retrieveSurveyProgressList(PagingVO<SurveyInvestigationVO> pagingVO);
	public ServiceResult modifySurveyInvestigation(SurveyInvestigationVO surveyInvestigation);
	public ServiceResult removeSurveyInvestigation(SurveyInvestigationVO surveyInvestigation);
	public List<SurveyVO> retrieveSurveyList(SurveyVO survey);
	public List<SurveyQuestionVO> retrieveSurveyQuestionList(SurveyQuestionVO surveyQuestion);
	public List<SurveyArticleVO> retrieveSurveyArticleList(SurveyArticleVO surveyArticle);
	
}
