package kr.or.ddit.autumn.groupware.survey.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface SurveyQusetionDAO {
	public int insertSurveyQuestion(SurveyQuestionVO surveyQuestion);
	public SurveyQuestionVO selectSurveyQuestion(@Param("surqueNo") int surqueNo);
	public int selectTotalRecord(PagingVO<SurveyQuestionVO> pagingVO);
	public List<SurveyQuestionVO> selectSurveyQuestionList(PagingVO<SurveyQuestionVO> pagingVO);
	public int updateSurveyQuestion(SurveyQuestionVO surveyQuestion);
	public int deleteSurveyQuestion(SurveyQuestionVO surveyQuestion);
	public List<SurveyVO> selectSurveyList(SurveyVO survey);
}
