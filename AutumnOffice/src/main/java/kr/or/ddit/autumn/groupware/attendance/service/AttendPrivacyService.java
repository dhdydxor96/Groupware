package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.vo.PagingVO;


public interface AttendPrivacyService {

	
	/**
	 * 내 인사정보 확인
	 * @param empId= 인사정보를 확인하려는 본인의 ID
	 * @return= 내 인사정보 VO
	 */
	public AttendEmployeeVO retrieveMyPrivacyInfo(String empId);
	
	/**
	 * 부서의 총 인원수 체크
	 * @param attendVO= 회사정보/부서 정보
	 * @return
	 */
	public int retrieveTotalDeptPrivacy(AttendEmployeeVO attendVO);
	
	/**
	 * 부서의 인사정보 확인
	 * @param pagingVO= 인사정보를 확인하려는 부서정보
	 * @return
	 */
	public List<AttendEmployeeVO> retrieveDeptPrivacyInfoList(AttendPagingVO pagingVO);
	
	/**
	 * 페이징 처리를 위한 용도 (totalRecord 확인)
	 */
	public int retrieveTotalRecord(AttendPagingVO pagingVO);
	
	
	/**
	 * 내 인사정보/부서 인사정보의 프로필 띄우기
	 * @param empId= 프로필을 띄우려는 해당 ID
	 * @return
	 */
	public AttatchVO retrieveProfileImage(String empId);
}
