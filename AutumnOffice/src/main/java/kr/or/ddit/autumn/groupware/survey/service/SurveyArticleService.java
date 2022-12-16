package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface SurveyArticleService {
	public ServiceResult createSurveyArticle(SurveyArticleVO surveyArticle);
	public SurveyArticleVO retrieveSurveyArticle(int surarcNo);
	public int retrieveSurveyArticleCount(PagingVO<SurveyArticleVO> pagingVO);
	public List<SurveyArticleVO> retrieveSurveyArticleList(PagingVO<SurveyArticleVO> pagingVO);
	public ServiceResult modifySurveyArticle(SurveyArticleVO surveyArticle);
	public ServiceResult removeSurveyArticle(SurveyArticleVO surveyArticle);
	public List<SurveyQuestionVO> retrieveSurveyQuestionList(SurveyQuestionVO surveyQuestion);
}
