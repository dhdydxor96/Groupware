package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyResponseVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface SurveyResponseService {
	public ServiceResult createSurveyResponse(SurveyResponseVO surveyResponse);
	public List<SurveyVO> retrieveSurveyList(SurveyVO survey);
	public List<SurveyQuestionVO> retrieveSurveyQuestionList(SurveyQuestionVO surveyQuestion);
	public List<SurveyArticleVO> retrieveSurveyArticleList(SurveyArticleVO surveyArticle);
	public List<SurveyInvestigationVO> retrieveSurveyInvestigationList(SurveyInvestigationVO surveyInvestigation);
	public int idCheck(SurveyResponseVO surveyResponse);
	public List<SurveyResponseVO> selectSurveyResponseList(int surinvNo);
	public int retrieveSurveyResponseCount(PagingVO<SurveyResponseVO> pagingVO);
	public List<SurveyResponseVO> retrieveSurveyResponseList(PagingVO<SurveyResponseVO> pagingVO);
	public List<SurveyResponseVO> retrieveSurveyDeadlineResponseList(PagingVO<SurveyResponseVO> pagingVO);
}
