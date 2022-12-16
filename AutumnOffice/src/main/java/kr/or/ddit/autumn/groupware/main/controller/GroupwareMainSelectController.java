package kr.or.ddit.autumn.groupware.main.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.groupware.main.service.GroupwareMainService;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.ElecAppVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.vo.NoticeVO;
import kr.or.ddit.autumn.vo.PostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/main")
public class GroupwareMainSelectController {

	@Inject
	private GroupwareMainService service;
	
	// ================================
	// * 공지사항 최대 3개 띄우기
	// ================================
	@RequestMapping(value="/groupwareMainNoticeList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<NoticeVO> selectNoticeList(Authentication authentication){
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		String comCode = realuser.getComCode();
		
		List<NoticeVO> noticeList = service.retrieveNoticeList(comCode);
		
		return noticeList;
	}
	
	// ================================
	// * 오늘 일정 최대 3개 띄우기
	// ================================
	@RequestMapping(value="/groupwareMainCalendarList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CalendarVO> selectCalendarList(Authentication authentication){
		
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		String depId = realuser.getDepId();

		EmployeeVO employeeVO = new EmployeeVO();
		
		employeeVO.setDepId(depId);
		employeeVO.setEmpId(empId);
		
		List<CalendarVO> calendarList = service.retrieveCalendarList(employeeVO);
		
		return calendarList;
	}
	
	// ================================
	// * 결재 대기 문서 최대 3개 띄우기
	// ================================
	@RequestMapping(value="/groupwareMainApprovalList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ElecAppVO> selectApprovalList(Authentication authentication){
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		String depId = realuser.getDepId();
		
		List<ElecAppVO> approvalList =  service.retrieveMyApprovalList(empId);
		
		return approvalList;
	}
	
	// ================================
	// * 나의 정보 띄우기 (ㅇㅇ팀,직위)
	// ================================
	@RequestMapping(value="/groupwareMainMyInfo.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public AttendEmployeeVO selectMyInfoProfile(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		String empNm = realuser.getEmpNm();
		DepartmentVO deptVO = realuser.getDepartment();
		JobVO jobVO = realuser.getJob();
		String empSta = realuser.getEmpSta();
		
		AttendEmployeeVO employeeVO = service.retrieveMyPrivacyInfo(empId);
		
		return employeeVO;
	}
	
	// ================================
	// * 나의 프로필 사진 띄우기
	// ================================
	@RequestMapping(value="/groupwareMainProfileInfo.do")
	public String selectMyProfileImage(Authentication authentication, Model model) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		AttatchVO attatch = service.retrieveMyInfo(empId);
		
		model.addAttribute("attatch", attatch);
		
		return "ImageView";
	}
	
	// ================================
	// * 현재 업무시간 띄우기
	// ================================
	@RequestMapping(value="/groupwareMainWorkTimeInfo.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public StatusVO selectMyWorkTimeInfo(Authentication authentication) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		
		StatusVO status = service.retrieveMyWorkInfo(empId);
		
		return status;
	}
	
	// ================================
	// * 헤더의 회사 로고
	// ================================
	@RequestMapping(value="/groupwareCompanyImageView.do")
	public String selectMyCompanyLogo(Authentication authentication, Model model){
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		AttatchVO attatch = service.retrieveCompanyLogo(comCode);
		
		model.addAttribute("attatch", attatch);
		
		return "ImageView";
	}
}
