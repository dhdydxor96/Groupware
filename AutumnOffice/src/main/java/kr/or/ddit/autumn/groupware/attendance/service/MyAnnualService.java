package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;import kr.or.ddit.autumn.groupware.attendance.dao.MyAnnualDao;
import kr.or.ddit.autumn.groupware.attendance.vo.AnnualRecodeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AnnualVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;

public interface MyAnnualService {
	
	/**
	 * 내 연차 정보 조회 (통계정보)
	 * @param empId 조회할 나의 이름
	 * @return
	 */
	public AnnualVO selectMyAnnual(@Param("empId") String empId);
	
	/**
	 * 내 연차 사용 내역 조회
	 * @param pagingVO= 조회하기위한 pagingVO 정보
	 * @return 
	 */
	public List<AnnualRecodeVO> retrieveMyAnnualRecodeList(AttendPagingVO pagingVO);
	
	/**
	 * 페이징 처리를 위한 용도 (totalRecord 확인)
	 */
	public int retrieveTotalRecord(AttendPagingVO pagingVO);
}
