package kr.or.ddit.autumn.groupware.resource.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.resource.service.ResourceService;
import kr.or.ddit.autumn.groupware.resource.vo.ReservVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.MeetReserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/groupware/resource")
public class ResourceInsertController {
	
	@Inject
	private ResourceService service;

	// ================================
	// * 회의실 예약하기
	// ================================
	@PostMapping(value="/resourceInsert.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ReservVO> resourceInsert(Authentication authentication, @ModelAttribute("meetReser") MeetReserVO meetReser, RedirectAttributes ratt) {
		
		// 로그인한 본인 정보
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		EmployeeVO realUser = adapter.getRealUser();
		
		String empId = realUser.getEmpId();
		
		// 예약하기
		meetReser.setEmpId(empId);
		
		ServiceResult result = service.createResource(meetReser);
		
		log.info("예약 결과 확인 {}", result);
		
		if(result.equals(ServiceResult.FAIL)) {
			ratt.addFlashAttribute("message", "서버 문제로 인해 예약 등록에 실패하였습니다. 잠시 후에 다시 시도해주세요.");
		}else if(result.equals(ServiceResult.PKDUPLICATED)) {
			ratt.addFlashAttribute("message", "이미 예약이 되어있어 등록이 불가합니다.");
		}
		
		// 회의실을 예약한 현황 리스트 출력
		ReservVO reservSetVO = new ReservVO();
        
        List<ReservVO> reservVOList = service.retrieveReservTableList(meetReser.getMeetNo());
		
		
		return reservVOList;
	}
}
