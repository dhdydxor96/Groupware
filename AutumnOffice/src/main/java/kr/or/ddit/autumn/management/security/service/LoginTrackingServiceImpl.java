package kr.or.ddit.autumn.management.security.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.management.security.dao.LoginTrackingDAO;
import kr.or.ddit.autumn.vo.LogVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Service
public class LoginTrackingServiceImpl implements LoginTrackingService {
	
	@Inject
	private LoginTrackingDAO dao;
	

	@Override
	public List<LogVO> loginTrackingList(PagingVO<LogVO> pagingVO) {
		return dao.loginTrackingList(pagingVO);
	}


	@Override
	public int totalRecodeCount(PagingVO<LogVO> pagingVO) {
		
		return dao.totalRecode(pagingVO);
	}

}
