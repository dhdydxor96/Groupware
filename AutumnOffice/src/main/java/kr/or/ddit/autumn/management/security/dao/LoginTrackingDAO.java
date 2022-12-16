package kr.or.ddit.autumn.management.security.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.LogVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface LoginTrackingDAO {

	/**
	 * 레코드 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int totalRecode(PagingVO<LogVO> pagingVO);
	
	/**
	 * 로그인 기록 리스트 불러오기
	 * @param pagingVO
	 * @return
	 */
	public List<LogVO> loginTrackingList (PagingVO<LogVO> pagingVO);
}
