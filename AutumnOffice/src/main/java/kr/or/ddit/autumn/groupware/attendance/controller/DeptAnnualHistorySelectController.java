package kr.or.ddit.autumn.groupware.attendance.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.attendance.service.DepAnnualHistoryService;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LveRecodeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import kr.or.ddit.autumn.web.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/attendance")
public class DeptAnnualHistorySelectController {
	
	@Inject
	private DepAnnualHistoryService service;
	
	@RequestMapping(value="/deptAnnualHistoryList.do")
	public String UI() {
		return "groupware/attendance/deptAnnualHistoryList";
	}

	// 부서 연차 사용 내역 (당일)
	@RequestMapping(value="/deptAnnualHistoryListToday.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<LveRecodeVO> deptAnnualHistoryList(Authentication authentication,Model model) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realuser = adapter.getRealUser();
		String depId = realuser.getDepId();
		String powRole =null;
		
		AttendEmployeeVO depInfo = new AttendEmployeeVO();
		depInfo.setDepId(depId);
		depInfo.setComCode(realuser.getComCode());

		//권한을 통해 인사정보를 확인할 대상 걸러내기
		if(realuser.getEmpRoles().contains("ROLE_HEAD")) {
			// 부서장의 권한으로 접근 시
			powRole = "ROLE_HEAD";
			
		}else if(realuser.getEmpRoles().contains("ROLE_CEO")) {
			// 이사급의 권한으로 접근시
			powRole = "ROLE_CEO";
			
		}
		depInfo.setPowRole(powRole);
		
		List<LveRecodeVO> lveRecodeList = service.depAnnualHistoryList(depInfo);
		
//		model.addAttribute("lveRecodeList",lveRecodeList);
		
		// groupware/attendance/deptAnnualHistoryList
		return lveRecodeList;
	}
	
	
	@RequestMapping(value="/deptAnnualHistoryList.do"
			, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<LveRecodeVO> list(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
			, @ModelAttribute("simpleCondition") SearchVO simpleCondition
			, @AuthenticationPrincipal(expression="realUser") EmployeeVO employee
//			, Model model
		) {

			String powRole = null;
			
			//권한을 통해 인사정보를 확인할 대상 걸러내기
			if(employee.getEmpRoles().contains("ROLE_HEAD")) {
				// 부서장의 권한으로 접근 시
				powRole = "ROLE_HEAD";
				
			}else if(employee.getEmpRoles().contains("ROLE_CEO")) {
				// 이사급의 권한으로 접근시
				powRole = "ROLE_CEO";
				
			}
		
			PagingVO<LveRecodeVO> pagingVO = new PagingVO<>(5,5);
			pagingVO.setCurrentPage(currentPage);
			pagingVO.setSimpleCondition(simpleCondition);
			pagingVO.setPowRole(powRole);
			pagingVO.setDepId(employee.getDepId());
			pagingVO.setComcode(employee.getComCode());
			
			
			int totalRecord = service.historyRecode(pagingVO);
			
			pagingVO.setTotalRecord(totalRecord);
			List<LveRecodeVO> lveRecodeList = service.rertieveHistoryRecodeList(pagingVO);
			pagingVO.setDataList(lveRecodeList);
			
			log.info("pagingVO : {}", pagingVO);
			
			return pagingVO;
	
	}
}