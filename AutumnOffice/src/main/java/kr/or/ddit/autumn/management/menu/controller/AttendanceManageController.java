package kr.or.ddit.autumn.management.menu.controller;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.CompanyVOWrapper;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.management.menu.service.AttendanceManageService;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmpTimeVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/management/menu")
@RequiredArgsConstructor
public class AttendanceManageController {
	
	private final AttendanceManageService service;
	
	// ================================
	// * 근태관리 UI
	// 기존에 등록되어있던 정규시간이 존재한다면 
	// input 태그에 반영되게끔 한다.
	// ================================
	@GetMapping("/attendanceManage.do")
	public String attendanceManageUI(Authentication authentication , Model model) {
		
		// 로그인한 나의 정보
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		int rowNum = service.retrieveAttendanceManage(comCode);
		
		EmpTimeVO timeVO = new EmpTimeVO();
		
		if(rowNum==1) {
			timeVO= service.retrieveAttendaceManageList(comCode);
		}
		
		model.addAttribute("timeVO", timeVO);
		
		return "management/menu/attendanceManage";
	}

	
	// ================================
	// * 근무시간 등록 및 변경
	// 처음 등록하는 기업은 INSERT
	// 기존에 등록했던 기업은 UPDATE로 반영
	// ================================
	@PostMapping(value="/attendanceManage.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmpTimeVO InsertattendanceManage(Authentication authentication, String startTime, String endTime, RedirectAttributes rett) {
		
		// 로그인한 나의 정보
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		EmpTimeVO empTimeVO = new EmpTimeVO();
		
		empTimeVO.setComCode(comCode);
		empTimeVO.setEmtOnt(startTime);
		empTimeVO.setEmtOft(endTime);
		
		//정규시간 등록
		ServiceResult result = null;
		
		log.info("vo 값 제대로 나오니 >> {}",empTimeVO);
		log.info("comCode 값 {}" , comCode);
		
		int rownum = service.retrieveAttendanceManage(comCode);
		
		if(rownum==1) {
			result = service.updateAtttendanceManage(empTimeVO);
			
			if(result.equals(ServiceResult.OK)) {
				rett.addFlashAttribute("message", "정규시간이 정상적으로 변경되었습니다.");
			}else {
				rett.addFlashAttribute("message", "정규시간을 변경하는데 실패하였습니다. 잠시 후에 다시 시도해주세요.");
			}
		}else {
			result = service.insertAttendanceManage(empTimeVO);
			
			if(result.equals(ServiceResult.OK)) {
				rett.addFlashAttribute("message", "정규시간이 정상적으로 등록되었습니다.");
			}else {
				rett.addFlashAttribute("message", "정규시간을 등록하는데 실패하였습니다. 잠시 후에 다시 시도해주세요.");
			}
			
		}
		
		return empTimeVO;
	}
	
	
	// ================================
	// * 근속 연수에 따른 총 연차수 업데이트
	// ================================
	@RequestMapping(value="/updateVacation.do")
	public String updateVacation(Authentication authentication, RedirectAttributes ratt) {
		
		// 로그인한 나의 정보
		CompanyVOWrapper adapter = (CompanyVOWrapper)authentication.getPrincipal();
		CompanyVO realuser = adapter.getRealUser();
		String comCode = realuser.getComCode();
		
		ServiceResult result = service.updateVacation(comCode);
		
		if(result.equals(ServiceResult.FAIL)) {
			ratt.addFlashAttribute("message", "연차 업데이트에 실패하였습니다. 잠시 뒤 다시 시도해주세요.");
		}else {
			ratt.addFlashAttribute("message", "총 연차수가 모두 업데이트 되었습니다.");
		}
		
		return "redirect:/management/menu/attendanceManage.do";
	}
}
