package kr.or.ddit.autumn.groupware.calendar.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.employee.service.EmployeeService;
import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.commons.notify.service.NotifyService;
import kr.or.ddit.autumn.commons.validate.InsertGroup;
import kr.or.ddit.autumn.groupware.calendar.service.CalendarService;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("groupware/calendar")
public class CalendarInsertController {
	@Inject
	private CalendarService service;
	@Inject
	private EmployeeService employeeService;
	@Inject
	private NotifyService notifyService;
	//개인일정추가
	@PostMapping("/empCalendarInsert.do")
	public String calendarInsert(
			@Validated(InsertGroup.class) @ModelAttribute("calendar") CalendarVO calendar
			, Errors errors
			, Model model
			) {

		String viewName = null;
		
		//개인일정 상태값
		calendar.setCalSta("1");
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.createCalendar(calendar);
			if(ServiceResult.OK.equals(result)) {
				viewName = "redirect:/groupware/calendar/empCalendarList.do";
				
			
			}else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "groupware/calendar/empCalendar";
			}
		}else {
			String message = "등록 실패";
			model.addAttribute("message", message);
			viewName = "groupware/calendar/empCalendar";
		}
		
		return viewName;
	}
	
	
	
	
	@PostMapping("/depCalendarInsert.do")
	public String depCalendarInsert(
			@Validated(InsertGroup.class) @ModelAttribute("calendar") CalendarVO calendar
			, Errors errors
			, Model model
			,Authentication authentication
			) {
		EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
		String empId = adapter.getRealUser().getEmpId();
		String comCode = adapter.getRealUser().getComCode();
		String depId = adapter.getRealUser().getDepId();
		String viewName = null;
		List<EmployeeVO> empList = employeeService.DeptEmployeeList(comCode,depId);
		//부서일정 상태값
		calendar.setCalSta("0");
		if(!errors.hasErrors()) {
			ServiceResult result = service.createCalendar(calendar);
			
			calendar.getDepId();
			if(ServiceResult.OK.equals(result)) {
				for(EmployeeVO emp : empList) {
					if(!empId.equals(emp.getEmpId())) {
						notifyService.notifyInsertModule(emp.getEmpId(), 7);
					}
				}
				viewName = "redirect:/groupware/calendar/depCalendarList.do";
				
			}else {
				String message = "등록 실패";
				model.addAttribute("message", message);
				viewName = "groupware/calendar/depCalendar";
			}
		}else {
			String message = "등록 실패";
			model.addAttribute("message", message);
			viewName = "groupware/calendar/depCalendar";
		}
		return viewName;
	}
}

