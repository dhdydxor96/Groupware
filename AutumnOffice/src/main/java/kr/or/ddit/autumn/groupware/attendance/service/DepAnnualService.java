package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import kr.or.ddit.autumn.groupware.attendance.vo.DepAnnualVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface DepAnnualService {

	public List<DepAnnualVO> selectDepAnnual(String empId);
	
	
	/**
	 * 부서별 연차 현황 리스트 -- (페이징)
	 * @param vo= 조건문 (부서정보)
	 * @return
	 */
	public List<DepAnnualVO> retrieveDepAnnualList(PagingVO pagingVO);
	
	/**
	 * 페이징 처리를 위한 용도 (totalRecord 확인)
	 */
	public int retrieveTotalRecord(PagingVO pagingVO);
}
