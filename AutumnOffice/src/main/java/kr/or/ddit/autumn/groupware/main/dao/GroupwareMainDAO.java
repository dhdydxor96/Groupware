package kr.or.ddit.autumn.groupware.main.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;

@Mapper
public interface GroupwareMainDAO {

	/**
	 * 메인화면 - 공지사항 게시글을  (최대 5개) 최신 순으로 조회
	 * @param comCode= 공지사항을 확인하기 위한 본인의 기업 코드
	 * @return
	 */
	public List<NoticeVO> selectNoticeList(String comCode);
	
	/**
	 * 메인화면 - 커뮤니티 게시글을 (최대 5개) 최신 순으로 조회
	 * @param comCode= 커뮤니티를 확인하기 위한 본인의 기업 코드
	 * @return
	 */
	public List<PostVO> selectCommunityList(String comCode);
	
	/**
	 * 메인화면 - 오늘의 일정을 (최대5개) 조회
	 * @param employeeVO= 일정을 확인하기 위한 본인의 ID, 부서코드
	 * @return
	 */
	public List<CalendarVO> selectCalendarList(EmployeeVO employeeVO);
	
	/**
	 * 메인화면 - 본인이 결재해야 하는 문서 (최대 5개) 최신 순으로 조회 (결재대기문서)
	 * @param empId= 결재문서를 조회하기 위한 본인의 ID
	 * @return
	 */
	public List<ElecAppVO> selectMyApprovalList(String empId);
	
	/**
	 * 메인화면 - 본인의 프로필 정보 조회
	 * @param empId= 정보를 조회하려는 본인의 정보
	 * @return
	 */
	public AttatchVO selectMyInfo(String empId);
	
	/**
	 * 메인화면 - 본인의 현재 업무시간 조회
	 * @param empId= 업무시간을 조회하려는 본인의 ID
	 * @return
	 */
	public StatusVO selectMyWorkInfo(String empId);
	
	/**
	 * 메인화면 - 본인의 정보 조회
	 * @param empId= 정보를 조회하려는 본인의 Id
	 * @return
	 */
	public AttendEmployeeVO selectMyPrivacyInfo(String empId);
	
	/**
	 * 헤더 - 회사 로고 이미지 띄우기
	 * @param comCode=로고 이미지 띄울 회사코드
	 * @return
	 */
	public AttatchVO selectCompanyLogo(String comCode);
	
}
