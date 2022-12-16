package kr.or.ddit.autumn.groupware.survey.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyInvestigationVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.MattersVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface SurveyArticleDAO {
	public int insertSurveyArticle(SurveyArticleVO surveyArticle);
	public SurveyArticleVO selectSurveyArticle(@Param("surarcNo") int surarcNo);
	public int selectTotalRecord(PagingVO<SurveyArticleVO> pagingVO);
	public List<SurveyArticleVO> selectSurveyArticleList(PagingVO<SurveyArticleVO> pagingVO);
	public int updateSurveyArticle(SurveyArticleVO surveyArticle);
	public int deleteSurveyArticle(SurveyArticleVO surveyArticle);
	public List<SurveyQuestionVO> selectSurveyQuestionList(SurveyQuestionVO surveyQuestion);
}
