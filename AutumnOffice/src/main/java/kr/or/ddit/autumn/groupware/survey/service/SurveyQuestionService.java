package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface SurveyQuestionService {
	public ServiceResult createSurveyQuestion(SurveyQuestionVO surveyQuestion);
	public SurveyQuestionVO retrieveSurveyQuestion(int surqueNo);
	public int retrieveSurveyQuestionCount(PagingVO<SurveyQuestionVO> pagingVO);
	public List<SurveyQuestionVO> retrieveSurveyQuestionList(PagingVO<SurveyQuestionVO> pagingVO);
	public ServiceResult modifySurveyQuestion(SurveyQuestionVO surveyQuestion);
	public ServiceResult removeSurveyQuestion(SurveyQuestionVO surveyQuestion);
	public List<SurveyVO> retrieveSurveyList(SurveyVO survey);
}
