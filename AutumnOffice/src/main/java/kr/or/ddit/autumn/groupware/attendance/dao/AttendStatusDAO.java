package kr.or.ddit.autumn.groupware.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface AttendStatusDAO {
	
	/**
	 * 출근하기 버튼 클릭 - 출근 이력 기록
	 * @param empId= 출근이력을 기록하려는 본인의 ID
	 * @return 1:성공 0:실패
	 */
	public int insertMyStartWork(String empId);
	
	/**
	 * 출근 버튼 중복 방지용
	 * @param empId= 당일의 출근 이력을 확인하려는 본인 ID
	 * @return 1:출근이력 존재 0:출근이력없음
	 */
	public int selectMyStartWorkOverlap(String empId);
	
	/**
	 * 퇴근하기 버튼 클릭 - 퇴근 이력 기록
	 * @param empId= 퇴근이력을 기록하려는 본인의 ID
	 * @return 1:성공 0:실패
	 */
	public int updateMyEndWork(String empId);
	
	/**
	 * 근태 관리 메뉴의 상단바에서 확인할 수 있는 출근시간/퇴근시간/업무시간/오늘날짜
	 * 메인 메뉴에서도 사용 예정
	 * @param empId= 근태정보를 확인하기 위한 본인의 ID
	 * @return
	 */
	public StatusVO selectMyWorkInfo(String empId);
	
	//--------------------------------------------------------------------------
	/**
	 * 내 근태 현황 조회
	 * @param empId= 근태 현황을 조회할 본인의 ID
	 * @return
	 */
	public List<StatusVO> selectMyStatus(String empId);
	
	/**
	 * 이번주 나의 누적 시간 계산
	 * @param empId= 나의 아이디
	 * @return= 총 누적된 시간(초 단위)
	 */
	public int selectMyStatusSum(String empId);
	
	/**
	 * 이번달 나의 누적 시간 계산
	 * @param empId= 나의 아이디
	 * @return 총 누적된 시간 (초 단위)
	 */
	public int selectMyStatusSumMonth(String empId);
	
	//-------------------------------------------------------------------------

	/**
	 * 이번주 부서원 근태 현황 조회
	 * @param status= 근태 현황을 조회할 회사/부서 정보
	 * @return
	 */
	public List<StatusVO> selectDeptStatus(PagingVO pagingVO);
	
	/**
	 * 페이징 처리용도
	 * @param pagingVO
	 * @return
	 */
	public int selectTotalCount(PagingVO pagingVO);
	
	/**
	 * 이번주 부서원 근태 누적 시간 조회
	 * @param status= 근태 현황을 조회할 회사/부서 정보
	 * @return
	 */
	public List<StatusVO> selectDeptStatusTime(PagingVO pagingVO);
	
	/**
	 * 부서원의 근태 상태 수정하기
	 * @param status= 수정할 부서원의 근태 상태 정보
	 * @return
	 */
	public int updateDeptEmployeeInfo(StatusVO status);
	
	/**
	 * 부서원의 근태 상태 수정시, 변경 이력 확인하기
	 * @param empId= 변경이력을 확인할 부서원의 아이디
	 * @return
	 */
	public List<StatusVO> selectDeptChangeStatus(String empId);
}
