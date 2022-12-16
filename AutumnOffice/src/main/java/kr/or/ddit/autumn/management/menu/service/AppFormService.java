package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AppFormVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface AppFormService {
	public ServiceResult createAppForm(AppFormVO appForm);
	public int retrieveAppFormCount(PagingVO<AppFormVO> pagingVO);
	public List<AppFormVO> retrieveAppFormList(PagingVO<AppFormVO> pagingVO);
	public ServiceResult removeAppForm(AppFormVO appForm);
}
