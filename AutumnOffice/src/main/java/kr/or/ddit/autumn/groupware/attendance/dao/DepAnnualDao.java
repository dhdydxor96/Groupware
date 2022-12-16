package kr.or.ddit.autumn.groupware.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.groupware.attendance.vo.DepAnnualVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

/**
 * 부서별 연차 현황
 *
 */
@Mapper
public interface DepAnnualDao {

	/**
	 * @param depId (부서코드) 부서별 연차 현황
	 * @return
	 */
	public List<DepAnnualVO> selectDepAnnual(@Param("depId")String depId);
	
	/**
	 * 부서별 연차 현황 리스트 -- (페이징)
	 * @param vo= 조건문 (부서정보)
	 * @return
	 */
	public List<DepAnnualVO> selectDepAnnualList(PagingVO pagingVO);
	
	/**
	 * 페이징 처리를 위한 용도 (totalRecord 확인)
	 */
	public int selectTotalRecord(PagingVO pagingVO);
}
