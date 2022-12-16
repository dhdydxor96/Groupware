package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface SurveyService {
	public ServiceResult createSurvey(SurveyVO survey);
	public SurveyVO retrieveSurvey(int surNo);
	public int retrieveSurveyCount(PagingVO<SurveyVO> pagingVO);
	public List<SurveyVO> retrieveSurveyList(PagingVO<SurveyVO> pagingVO);
	public ServiceResult modifySurvey(SurveyVO survey);
	public ServiceResult removeSurvey(SurveyVO survey);
	public ServiceResult modifySurveyStateOne(SurveyVO survey);
	public ServiceResult modifySurveyStateTwo(SurveyVO survey);
}
