package kr.or.ddit.autumn.groupware.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.vo.AttatchVO;

@Mapper
public interface AttendPrivacyDAO {

	/**
	 * 내 인사정보 확인
	 * @param empId= 인사정보를 확인하려는 본인의 ID
	 * @return= 내 인사정보 VO
	 */
	public AttendEmployeeVO selectMyPrivacyInfo(String empId);
	
	/**
	 * 부서의 총 인원수 체크
	 * @param attendVO= 회사정보/부서 정보
	 * @return
	 */
	public int selectTotalDeptPrivacy(AttendEmployeeVO attendVO);
	
	/**
	 * 부서의 인사정보 확인
	 * @param depId= 인사정보를 확인하려는 부서ID
	 * @return
	 */
	public List<AttendEmployeeVO> selectDeptPrivacyList(AttendPagingVO pagingVO);
	
	/**
	 * 페이징 처리를 위한 용도 (totalRecord 확인)
	 */
	public int selectTotalRecord(AttendPagingVO pagingVO);
	
	/**
	 * 내 인사정보/부서 인사정보의 프로필 띄우기
	 * @param empId= 프로필을 띄우려는 해당 ID
	 * @return
	 */
	public AttatchVO selectProfileImage(String empId);
}
