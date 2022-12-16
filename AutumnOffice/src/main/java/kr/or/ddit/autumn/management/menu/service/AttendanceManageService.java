package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AulLeaveVO;
import kr.or.ddit.autumn.vo.EmpTimeVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

public interface AttendanceManageService {
	
	//====== 근무시간 용 =================================================================

	/**
	 * 기업의 출퇴근 정규시간 등록
	 * @param emptimeVO=정규시간을 등록하기 위한 기업의 정보
	 * @return OK:성공 FAIL:실패
	 */
	public ServiceResult insertAttendanceManage(EmpTimeVO emptimeVO);
	
	/**
	 * 기업의 출퇴근 정규시간 업데이트
	 * @param emptimeVO=정규시간을 변경하기 위한 기업의 정보
	 * @return 1:성공 0:실패
	 */
	public ServiceResult updateAtttendanceManage(EmpTimeVO emptimeVO);
	
	/**
	 * DB(EMP_TIME)에 기업이 등록되어 있는지 확인
	 * @param comCode=등록여부를 확인하기 위한 기업의 코드
	 * @return 1:UPDATE를 이용해 시간변경, 0:INSERT를 이용해 정규시간 등록
	 */
	public int retrieveAttendanceManage(String comCode);
	
	/**
	 * 기업의 정규시간을 조회
	 * @param comCode= 정규시간을 조회하려는 기업의 정보
	 * @return 기업의 정규시간이 담긴 VO
	 */
	public EmpTimeVO retrieveAttendaceManageList(String comCode);
	
	//====== 연차 용 =================================================================
	
	/**
	 * 기업의 총 연차 수 업데이트
	 * @param comCode= 연차수를 업데이트 하려는 사원의 ID
	 * @return
	 */
	public ServiceResult updateVacation(String empId);
	
	/**
	 * DB (AUL_LEAVE)에 사원이 등록되어 있는지 확인하기 위한 용도 -- 사원 불러오기
	 * @param comCode
	 * @return
	 */
	public List<EmployeeVO> retrieveEmployee(String comCode);
	
	/**
	 * DB (AUL_LEAVE)에 사원이 등록되어 있는지 확인하기 위한 용도 -- 총 연차 수 테이블 불러오기
	 * @param comCode
	 * @return
	 */
	public List<AulLeaveVO> retrieveVacationList(String comCode);
	
	/**
	 * DB (AUL_LEAVE)에 사원이 등록되어 있지 않은 경우 추가하기 위한 용도
	 * @param empId= 사원 추가
	 * @return
	 */
	public ServiceResult createVacation(String empId);
}
