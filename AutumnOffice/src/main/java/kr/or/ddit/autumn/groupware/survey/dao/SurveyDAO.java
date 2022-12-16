package kr.or.ddit.autumn.groupware.survey.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface SurveyDAO {
	public int insertSurvey(SurveyVO survey);
	public SurveyVO selectSurvey(@Param("surNo") int surNo);
	public int selectTotalRecord(PagingVO<SurveyVO> pagingVO);
	public List<SurveyVO> selectSurveyList(PagingVO<SurveyVO> pagingVO);
	public int updateSurvey(SurveyVO survey);
	public int deleteSurvey(SurveyVO survey);
	public int updateSurveyStateOne(SurveyVO survey);
	public int updateSurveyStateTwo(SurveyVO survey);
}
