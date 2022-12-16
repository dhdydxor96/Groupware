package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.survey.dao.SurveyQusetionDAO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SurveyQuestionServiceImpl implements SurveyQuestionService {
	
	private final SurveyQusetionDAO queDAO;
	
	@Override
	public ServiceResult createSurveyQuestion(SurveyQuestionVO surveyQuestion) {
		int rowcnt = queDAO.insertSurveyQuestion(surveyQuestion);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public SurveyQuestionVO retrieveSurveyQuestion(int surqueNo) {
		SurveyQuestionVO surveyQuestion = queDAO.selectSurveyQuestion(surqueNo);
		if(surveyQuestion == null)
			throw new RuntimeException(String.format("%d 설문질문의 질문이 없음", surqueNo));
		return surveyQuestion;
	}

	@Override
	public int retrieveSurveyQuestionCount(PagingVO<SurveyQuestionVO> pagingVO) {
		return queDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public List<SurveyQuestionVO> retrieveSurveyQuestionList(PagingVO<SurveyQuestionVO> pagingVO) {
		return queDAO.selectSurveyQuestionList(pagingVO);
	}

	@Override
	public ServiceResult modifySurveyQuestion(SurveyQuestionVO surveyQuestion) {
		int rowcnt = queDAO.updateSurveyQuestion(surveyQuestion);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeSurveyQuestion(SurveyQuestionVO surveyQuestion) {
		int rowcnt = queDAO.deleteSurveyQuestion(surveyQuestion);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<SurveyVO> retrieveSurveyList(SurveyVO survey) {
		return queDAO.selectSurveyList(survey);
	}

}
