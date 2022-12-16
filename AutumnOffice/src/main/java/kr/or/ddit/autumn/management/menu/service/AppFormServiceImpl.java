package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.management.menu.dao.AppFormDAO;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AppFormServiceImpl implements AppFormService {
	
	private final AppFormDAO appDAO;

	@Override
	public ServiceResult createAppForm(AppFormVO appForm) {
		int rowcnt = appDAO.insertAppForm(appForm);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public int retrieveAppFormCount(PagingVO<AppFormVO> pagingVO) {
		return appDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public List<AppFormVO> retrieveAppFormList(PagingVO<AppFormVO> pagingVO) {
		return appDAO.selectAppFormList(pagingVO);
	}

	@Override
	public ServiceResult removeAppForm(AppFormVO appForm) {
		int rowcnt = appDAO.deleteAppForm(appForm);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	

}
