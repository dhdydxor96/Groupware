package kr.or.ddit.autumn.groupware.profile.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface GroupwareProfileService {


	/**
	 * 본인의 프로필 사진 변경하기
	 * @param employeeVO=변경하고자 하는 본인의 프로필 정보
	 * @return
	 */
	public ServiceResult updateProfileImage(EmployeeVO employeeVO);

	
	//==== 로그인 내역 ================================
	
	/**
	 * 본인의 로그인 내역 확인하기
	 * @param pagingVO=로그인을 시도한 사용자의 정보
	 * @return
	 */
	public List<LogVO> retrieveLoginIpInfo(AttendPagingVO pagingVO);
	
	/**
	 * 페이징 처리용
	 * @param pagingVO
	 * @return
	 */
	public int retrieveLoginIpInfoTotalCount(AttendPagingVO pagingVO);
	
	
	//==== 비밀번호 변경 ==============================
	
	/**
	 * 본인의 비밀번호 변경하기
	 * @param employeeVO=변경하고자 하는 본인의 비밀번호 정보
	 * @return
	 */
	public ServiceResult updateMyPassword(EmployeeVO employeeVO);
	
	/**
	 * 본인의 비밀번호를 변경하기 위해 확인하는 용도
	 * @param employeeVO= 비밀번호를 가져오기 위한 본인의 정보
	 * @return 비밀번호
	 */
	public ServiceResult retrieveMyPassword(EmployeeVO employeeVO); 
}
