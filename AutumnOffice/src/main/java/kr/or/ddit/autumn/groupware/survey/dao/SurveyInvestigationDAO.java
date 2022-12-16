package kr.or.ddit.autumn.groupware.survey.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyResponseVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface SurveyInvestigationDAO {
	public int insertSurveyInvestigation(SurveyInvestigationVO surveyInvestigation);
	public SurveyInvestigationVO selectSurveyInvestigation(@Param("surinvNo") int surinvNo);
	public int selectTotalRecord(PagingVO<SurveyInvestigationVO> pagingVO);
	public List<SurveyInvestigationVO> selectSurveyInvestigationList(PagingVO<SurveyInvestigationVO> pagingVO);
	public List<SurveyInvestigationVO> selectSurveyDeadlineList(PagingVO<SurveyInvestigationVO> pagingVO);
	public List<SurveyInvestigationVO> selectSurveyProgressList(PagingVO<SurveyInvestigationVO> pagingVO);
	public int updateSurveyInvestigation(SurveyInvestigationVO surveyInvestigation);
	public int deleteSurveyInvestigation(SurveyInvestigationVO surveyInvestigation);
	public List<SurveyVO> selectSurveyList(SurveyVO survey);
	public List<SurveyQuestionVO> selectSurveyQuestionList(SurveyQuestionVO surveyQuestion);
	public List<SurveyArticleVO> selectSurveyArticleList(SurveyArticleVO surveyArticle);
}
