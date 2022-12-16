package kr.or.ddit.autumn.groupware.profile.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface GroupwareProfileDAO {

	/**
	 * 본인의 프로필 사진 변경하기 (재등록하는 과정)
	 * @param attatchVO=변경하고자 하는 본인의 프로필 정보
	 * @return
	 */
	public int insertProfileImage(AttatchVO attatchVO);
	
	/**
	 * 본인의 프로필 사진 변경하기 (삭제를 위해 attatch 정보 불러오기)
	 * @param empId
	 * @return
	 */
	public AttatchVO selectEmployeeAttatchInfo(String empId);
	
	/**
	 * 본인의 프로필 사진 변경하기 (기존의 프로필 사진 삭제)
	 * @param empId
	 * @return
	 */
	public int deleteProfileImage(String empId);
	
	//==== 로그인 내역 ================================
	
	/**
	 * 본인의 로그인 내역 확인하기
	 * @param pagingVO=로그인을 시도한 사용자의 정보
	 * @return
	 */
	public List<LogVO> selectLoginIpInfo(AttendPagingVO pagingVO);
	
	/**
	 * 페이징 처리용
	 * @param pagingVO
	 * @return
	 */
	public int selectLoginIpInfoTotalCount(AttendPagingVO pagingVO);
	
	//==== 비밀번호 변경 ==============================
	/**
	 * 본인의 비밀번호 변경하기
	 * @param employeeVO=변경하고자 하는 본인의 비밀번호 정보
	 * @return
	 */
	public int updateMyPassword(EmployeeVO employeeVO);
	
	/**
	 * 본인의 비밀번호를 변경하기 위해 확인하는 용도
	 * @param employeeVO= 비밀번호를 가져오기 위한 본인의 ID
	 * @return 비밀번호
	 */
	public String selectMyPassword(EmployeeVO employeeVO); 
}
