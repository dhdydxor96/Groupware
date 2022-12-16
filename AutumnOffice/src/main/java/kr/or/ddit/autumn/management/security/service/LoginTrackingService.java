package kr.or.ddit.autumn.management.security.service;

import java.util.List;

import kr.or.ddit.autumn.vo.LogVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface LoginTrackingService {

	public int totalRecodeCount(PagingVO<LogVO> pagingVO);
	public List<LogVO> loginTrackingList(PagingVO<LogVO> pagingVO);
}
