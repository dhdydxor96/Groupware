package kr.or.ddit.autumn.groupware.attendance.controller;

import java.util.List;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.AttendPrivacyService;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/groupware/attendance/dept/privacy")
public class DeptPrivacySelectController {
	
	private final AttendPrivacyService service;

	@GetMapping("/deptPrivacyList.do")
	public String listUI() {
		return "groupware/attendance/deptprivacyList";
	}
	
	// ================================
	// * 부서 인사정보 리스트 확인
	// ================================
	@GetMapping(value="/deptPrivacyList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public AttendPagingVO<AttendEmployeeVO> deptPrivacyList(Authentication authentication, 
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			) {
		
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String depId = realuser.getDepId();
		String comCode = realuser.getComCode();
		String powRole = null;
		
		//권한을 통해 인사정보를 확인할 대상 걸러내기
		if(realuser.getEmpRoles().contains("ROLE_HEAD")) {
			// 부서장의 권한으로 접근 시
			powRole = "ROLE_HEAD";
			
		}else if(realuser.getEmpRoles().contains("ROLE_CEO")) {
			// 이사급의 권한으로 접근시
			powRole = "ROLE_CEO";
			
		}
		
		// 페이징처리+리스트 출력
		log.info("DeptPrivacy 들어오는 검색 조건 값 {}", simpleCondition);
		AttendPagingVO<AttendEmployeeVO> pagingVO = new AttendPagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setPowRole(powRole);
		pagingVO.setSimpleCondition1(simpleCondition);
		pagingVO.setDepId(depId);
		pagingVO.setComCode(comCode);
		log.info("totalRecord를 처리하기 위해 pagingVO에 저장된 값 {}", pagingVO.getSimpleCondition1());
		int totalRecord = service.retrieveTotalRecord(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<AttendEmployeeVO> deptList = service.retrieveDeptPrivacyInfoList(pagingVO);
		pagingVO.setDataList(deptList);
		
		//groupware/attendance/deptprivacyList
		return pagingVO;
	}
	
	// ================================
	// * 총 인원 수 카운트
	// ================================
	@RequestMapping(value="/deptPrivacyTotalCount.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int deptTotalCount(Authentication authentication) {
		// 로그인한 나의 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String depId = realuser.getDepId();
		String comCode = realuser.getComCode();
		String powRole = null;
		
		//권한을 통해 인사정보를 확인할 대상 걸러내기
		if(realuser.getEmpRoles().contains("ROLE_HEAD")) {
			// 부서장의 권한으로 접근 시
			powRole = "ROLE_HEAD";
			
		}else if(realuser.getEmpRoles().contains("ROLE_CEO")) {
			// 이사급의 권한으로 접근시
			powRole = "ROLE_CEO";
			
		}
		
		AttendEmployeeVO vo = new AttendEmployeeVO();
		vo.setPowRole(powRole);
		vo.setDepId(depId);
		vo.setComCode(comCode);
		
		int rownum = service.retrieveTotalDeptPrivacy(vo);
		
		return rownum;
	}
}
