package kr.or.ddit.autumn.groupware.main.service;

import java.util.List;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;

public interface GroupwareMainService {
	
	/**
	 * 메인화면 - 공지사항 게시글을  (최대 5개) 최신 순으로 조회
	 * @param comCode= 공지사항을 확인하기 위한 본인의 기업 코드
	 * @return
	 */
	public List<NoticeVO> retrieveNoticeList(String comCode);
	
	/**
	 * 메인화면 - 커뮤니티 게시글을 (최대 5개) 최신 순으로 조회
	 * @param comCode= 커뮤니티를 확인하기 위한 본인의 기업 코드
	 * @return
	 */
	public List<PostVO> retrieveCommunityList(String comCode);
	
	/**
	 * 메인화면 - 오늘의 일정을 (최대5개) 조회
	 * @param employeeVO= 일정을 확인하기 위한 본인의 ID, 부서코드
	 * @return
	 */
	public List<CalendarVO> retrieveCalendarList(EmployeeVO employeeVO);
	
	/**
	 * 메인화면 - 본인이 결재해야 하는 문서 (최대 5개) 최신 순으로 조회 (결재대기문서)
	 * @param empId= 결재문서를 조회하기 위한 본인의 ID
	 * @return
	 */
	public List<ElecAppVO> retrieveMyApprovalList(String empId);
	
	/**
	 * 메인화면 - 본인의 프로필 정보 조회
	 * @param empId= 정보를 조회하려는 본인의 정보
	 * @return
	 */
	public AttatchVO retrieveMyInfo(String empId);
	
	/**
	 * 메인화면 - 본인의 현재 업무시간 조회
	 * @param empId= 업무시간을 조회하려는 본인의 ID
	 * @return
	 */
	public StatusVO retrieveMyWorkInfo(String empId);
	
	
	/**
	 * 메인화면 - 본인의 정보 조회
	 * @param empId= 정보를 조회하려는 본인의 Id
	 * @return
	 */
	public AttendEmployeeVO retrieveMyPrivacyInfo(String empId);
	
	/**
	 * 헤더 - 회사 로고 이미지 띄우기
	 * @param comCode=로고 이미지 띄울 회사코드
	 * @return
	 */
	public AttatchVO retrieveCompanyLogo(String comCode);
}
