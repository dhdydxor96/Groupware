package kr.or.ddit.autumn.groupware.survey.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.survey.dao.SurveyArticleDAO;
import kr.or.ddit.autumn.vo.SurveyArticleVO;
import kr.or.ddit.autumn.vo.SurveyQuestionVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SurveyArticleServiceImpl implements SurveyArticleService {
	
	private final SurveyArticleDAO artDAO;
	
	@Override
	public ServiceResult createSurveyArticle(SurveyArticleVO surveyArticle) {
		int rowcnt = artDAO.insertSurveyArticle(surveyArticle);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public SurveyArticleVO retrieveSurveyArticle(int surarcNo) {
		SurveyArticleVO surveyArticle = artDAO.selectSurveyArticle(surarcNo);
		if(surveyArticle == null)
			throw new RuntimeException(String.format("%d 설문 답변의 답변이 없음", surarcNo));
		return surveyArticle;
	}

	@Override
	public int retrieveSurveyArticleCount(PagingVO<SurveyArticleVO> pagingVO) {
		return artDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public List<SurveyArticleVO> retrieveSurveyArticleList(PagingVO<SurveyArticleVO> pagingVO) {
		return artDAO.selectSurveyArticleList(pagingVO);
	}

	@Override
	public ServiceResult modifySurveyArticle(SurveyArticleVO surveyArticle) {
		int rowcnt = artDAO.updateSurveyArticle(surveyArticle);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeSurveyArticle(SurveyArticleVO surveyArticle) {
		int rowcnt = artDAO.deleteSurveyArticle(surveyArticle);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<SurveyQuestionVO> retrieveSurveyQuestionList(SurveyQuestionVO surveyQuestion) {
		return artDAO.selectSurveyQuestionList(surveyQuestion);
	}

}
