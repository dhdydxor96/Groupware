package kr.or.ddit.autumn.groupware.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.groupware.attendance.vo.AnnualRecodeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AnnualVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

/**
 * 연차관리 (Persistence Layer)
 *
 */
@Mapper
public interface MyAnnualDao {

	/**
	 * 내 연차 정보 조회 (통계정보)
	 * @param empId 조회할 나의 이름
	 * @return
	 */
	public AnnualVO selectEmployee(@Param("empId") String empId);
	
	
	/**
	 * 내 연차 사용 내역 조회
	 * @param pagingVO= 조회하기위한 pagingVO 정보
	 * @return 
	 */
	public List<AnnualRecodeVO> selectMyAnnualRecodeList(AttendPagingVO pagingVO);
	
	/**
	 * 페이징 처리를 위한 용도 (totalRecord 확인)
	 */
	public int selectTotalRecord(AttendPagingVO pagingVO);
}
	