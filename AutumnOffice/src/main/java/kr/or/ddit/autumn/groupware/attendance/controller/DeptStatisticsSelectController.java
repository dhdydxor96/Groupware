package kr.or.ddit.autumn.groupware.attendance.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.DepStatisticService;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.groupware.attendance.vo.DepStatisticVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.SearchVO;

@Controller
@RequestMapping("/groupware/attendance/dept/statistics")
public class DeptStatisticsSelectController {

	@Inject
	private DepStatisticService service;
	
	// UI
	@RequestMapping("/deptStatisticsList.do")
	public String listUI() {
		return "groupware/attendance/deptstatisticsList";
	}
	
	// ================================
	// * 부서원 근태 현황 확인
	// ================================
	@RequestMapping(value="/deptStatisticsList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public AttendPagingVO<DepStatisticVO> deptStatis(Authentication authentication, 
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition) {
		
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String depId = realuser.getDepId();
		String comCode = realuser.getComCode();
		String jobNm = realuser.getJob().getJobNm();
		String powRole = null;

		AttendPagingVO<DepStatisticVO> pagingVO = new AttendPagingVO<>();
		
		//권한을 통해 인사정보를 확인할 대상 걸러내기
		if(realuser.getEmpRoles().contains("ROLE_HEAD")) {
			// 부서장의 권한으로 접근 시
			powRole = "ROLE_HEAD";
			
		}else if(realuser.getEmpRoles().contains("ROLE_CEO")) {
			// 이사급의 권한으로 접근시
			powRole = "ROLE_CEO";
			
		}
	
		// 부서장의 권한을 가지고 있는 경우
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDepId(depId);
		pagingVO.setComCode(comCode);
		pagingVO.setPowRole(powRole);
		pagingVO.setSimpleCondition1(simpleCondition);
		int totalRecord = service.retrieveTotalStatistic(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<DepStatisticVO> depStatisticList = service.retrievetDeptStatisticList(pagingVO);
		pagingVO.setDataList(depStatisticList);
			
		return pagingVO;
	}
	
	// ================================
	// * 부서 전체 통계 확인
	// ================================
	@RequestMapping(value="/deptStatisticsAll.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public DepStatisticVO deptStatisAll(Authentication authentication) {
		
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String depId = realuser.getDepId();
		String comCode = realuser.getComCode();
		String jobNm = realuser.getJob().getJobNm();
		String powRole = null;

		DepStatisticVO dept = new DepStatisticVO();
		
		DepStatisticVO resultVO = new DepStatisticVO();
		
		//권한을 통해 인사정보를 확인할 대상 걸러내기
		if(realuser.getEmpRoles().contains("ROLE_HEAD")) {
			// 부서장의 권한으로 접근 시
			powRole = "ROLE_HEAD";
			
		}else if(realuser.getEmpRoles().contains("ROLE_CEO")) {
			// 이사급의 권한으로 접근시
			powRole = "ROLE_CEO";
			
		}
		
		// 부서장의 권한을 가지고 있는 경우
		dept.setDepId(depId);
		dept.setComCode(comCode);
		dept.setPowRole(powRole);
		resultVO = service.retrieveDeptStatisticAll(dept);
		
		
		
		return resultVO;
	}
}
