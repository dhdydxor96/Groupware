package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.survey.dao.SurveyDAO;
import kr.or.ddit.autumn.vo.SurveyVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SurveyServiceImpl implements SurveyService {
	
	private final SurveyDAO surDAO;
	
	@Override
	public ServiceResult createSurvey(SurveyVO survey) {
		int rowcnt = surDAO.insertSurvey(survey);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public SurveyVO retrieveSurvey(int surNo) {
		SurveyVO survey = surDAO.selectSurvey(surNo);
		if(survey == null)
			throw new RuntimeException(String.format("%d 설문번호의 설문이 없음.", surNo));
		return survey;
	}

	@Override
	public int retrieveSurveyCount(PagingVO<SurveyVO> pagingVO) {
		return surDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public List<SurveyVO> retrieveSurveyList(PagingVO<SurveyVO> pagingVO) {
		return surDAO.selectSurveyList(pagingVO);
	}

	@Override
	public ServiceResult modifySurvey(SurveyVO survey) {
		int rowcnt = surDAO.updateSurvey(survey);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeSurvey(SurveyVO survey) {
		int rowcnt = surDAO.deleteSurvey(survey);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifySurveyStateOne(SurveyVO survey) {
		int rowcnt = surDAO.updateSurveyStateOne(survey);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifySurveyStateTwo(SurveyVO survey) {
		int rowcnt = surDAO.updateSurveyStateTwo(survey);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
