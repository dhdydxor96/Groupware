package kr.or.ddit.autumn.groupware.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.groupware.attendance.vo.DepStatisticVO;
import kr.or.ddit.autumn.vo.EmpTimeVO;

@Mapper
public interface DepStatisticDAO {

	
	/**
	 * 부서의 전체 통계 수 계산하기 (지각 몇명, 결근 몇명)
	 * @return
	 */
	public List<DepStatisticVO> selectDeptStatisticAll(DepStatisticVO deptStatus);

	/**
	 * 부서 내 근태 현황을 list로 확인
	 * @param empVO= 본인이 다니는 기업의 부서 정보
	 * @return
	 */
	public List<DepStatisticVO> selectDeptStatisticList(AttendPagingVO<DepStatisticVO> empVO);
	
	/**
	 * 페이징 처리용도
	 * @param pagingVO
	 * @return
	 */
	public int selectTotalStatistic(AttendPagingVO pagingVO);
	
	/**
	 * 기업의 정규 업무시간 확인용도
	 * @param comCode= 업무시간을 확인하기 위한 기업의 코드
	 * @return
	 */
	public EmpTimeVO selectCompanyWorkTime(String comCode);
	
	/**
	 * (대표이사한정) 기업의 근태 전체 통계 계산하기 (지각 몇명, 결근 몇명)
	 * @param deptStatus
	 * @return
	 */
	public List<DepStatisticVO> selectEveryStatisticAll(DepStatisticVO deptStatus);
	
	/**
	 * (대표이사한정) 기업의 사원 근태 현황을 LIST로 확인
	 * @param empVO
	 * @return
	 */
	public List<DepStatisticVO> selectEveryStatisticList(AttendPagingVO<DepStatisticVO> empVO);
	
	/**
	 * (대표이사한정) 페이징 처리용도
	 * @param pagingVO
	 * @return
	 */
	public int selectTotalEveryStatistic(AttendPagingVO pagingVO);
}
