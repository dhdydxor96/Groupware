package kr.or.ddit.autumn.groupware.attendance.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.AttendStatusService;
import kr.or.ddit.autumn.groupware.attendance.vo.DepAnnualVO;
import kr.or.ddit.autumn.groupware.attendance.vo.StatusVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/attendance/dept/status")
public class DeptStatusSelectController {

	@Inject
	private AttendStatusService service;

	// ================================
	// * 이번주 날짜 띄우기
	// ================================
	@RequestMapping(value="/deptStatusList.do")
	public String deptStatusHtml(Authentication authentication, Model model) {
		// 기간 지정
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		//일주일의 첫날 선택
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        //해당 주차 시작일과의 차이 구하기용
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - cal.getFirstDayOfWeek();
        //해당 주차의 첫날 세팅
        cal.add(Calendar.DAY_OF_MONTH, - dayOfWeek);
        //해당 주차의 첫일자(월)
        String stDt = format.format(cal.getTime());
        //해당 주차의 마지막 세팅
        cal.add(Calendar.DAY_OF_MONTH, 6); 
        //해당 주차의 마지막일자(금)
        String edDt = format.format(cal.getTime());
        
        String thisWeek = stDt+" ~ "+edDt;
		
		model.addAttribute("thisWeek", thisWeek);
        
		return "groupware/attendance/deptstatusList";
	}
	
	// ================================
	// * 부서 근태 현황 확인
	// ================================
	@RequestMapping(value="/deptStatusList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<StatusVO> deptStatus(@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition,
			Authentication authentication) {
		
		// 로그인 정보 확인
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String empId = realuser.getEmpId();
		String depId = realuser.getDepId();
		String comCode = realuser.getComCode();
		String powRole =null;
		
		//권한을 통해 인사정보를 확인할 대상 걸러내기
		if(realuser.getEmpRoles().contains("ROLE_HEAD")) {
			// 부서장의 권한으로 접근 시
			powRole = "ROLE_HEAD";
			
		}else if(realuser.getEmpRoles().contains("ROLE_CEO")) {
			// 이사급의 권한으로 접근시
			powRole = "ROLE_CEO";
			
		}
		
		//페이징처리
		PagingVO<StatusVO> pagingVO = new PagingVO<>(35,5);
		pagingVO.setCurrentPage(currentPage);
		pagingVO.setDepId(depId);
		pagingVO.setComcode(comCode);
		pagingVO.setPowRole(powRole);
		pagingVO.setSimpleCondition(simpleCondition);
		int totalRecord = service.selectTotalCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<StatusVO> list = service.retrieveDeptStatus(pagingVO); 
		log.info("데이터 값 확인 {}" , list);
		pagingVO.setDataList(list);
		
		return pagingVO;
	}
	
	// ================================
	// * 부서원의 근태 현황 변경 이력이 있을 때 띄우기
	// ================================
	@RequestMapping(value="/deptChangeStatus.do" , produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<StatusVO> deptChangeStatus(@RequestParam(value="who") String empId){
		List<StatusVO> list =  service.retrieveDeptChangeStatus(empId);
		
		return list;
	}
}
