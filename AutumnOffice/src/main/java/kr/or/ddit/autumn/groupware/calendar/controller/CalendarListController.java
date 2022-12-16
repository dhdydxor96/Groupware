package kr.or.ddit.autumn.groupware.calendar.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.groupware.approval.service.ApprovalService;
import kr.or.ddit.autumn.groupware.calendar.service.CalendarService;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.DepartmentVO;


@Controller
public class CalendarListController {
	@Inject
	private CalendarService service;
	@Inject
	private ApprovalService approvalService;
	
	@RequestMapping(value = "/calendar/depList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<DepartmentVO> depList(Model model
									,Authentication authentication) {
		
    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
    	List<DepartmentVO> depList = approvalService.retrieveDeptGroupList(adapter.getRealUser().getComCode());
		model.addAttribute("depList", depList);
		
		return depList;

	}
	
	//부서일정 데이터 리스트
	@RequestMapping(value = "/groupware/calendar/depCalendarList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<HashMap<String, Object>> depCalendarList(Model model
													,Authentication authentication
													,CalendarVO calendar2) {
		
    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
    	List<DepartmentVO> depList = approvalService.retrieveDeptGroupList(adapter.getRealUser().getComCode());
		model.addAttribute("depList", depList);
		List<HashMap<String, Object>> list = new ArrayList<>();
		calendar2.setDepId(adapter.getRealUser().getDepId());
		List<CalendarVO> calendarList = service.retrieveDepCalendarList(calendar2);
		
		for (CalendarVO calendar : calendarList) {
			HashMap<String, Object> hash = new HashMap<>();
			hash.put("title", calendar.getCalTit());
			hash.put("start", calendar.getCalStart());
			hash.put("end", calendar.getCalEnd());
			hash.put("_id", calendar.getCalNo());

			hash.put("allDay", calendar.getCalAllday());
			hash.put("backgroundColor", calendar.getCalColor());
			hash.put("description", calendar.getCalCon());
			hash.put("type", calendar.getDepId());
			hash.put("username", calendar.getEmpId());
			hash.put("depList",depList);
			list.add(hash);

		}

		return list;

	}
	
	//부서일정UI
	@GetMapping("/groupware/calendar/depCalendarList.do")
	public String depCalendar() {

		String logicalViewName = "groupware/calendar/depCalendar";
		return logicalViewName;
	}
	
	
	
	
	
	//개인일정데이터
	@RequestMapping(value = "/groupware/calendar/empCalendarList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<HashMap<String, Object>> empCalendar(Model model
													,Authentication authentication) {
		
	    	EmployeeVOWrapper adapter = (EmployeeVOWrapper)authentication.getPrincipal();
	    	
		List<HashMap<String, Object>> list = new ArrayList<>();
		List<CalendarVO> calendarList = service.retrieveEmpCalendarList(adapter.getRealUser());
		
		for (CalendarVO calendar : calendarList) {
			HashMap<String, Object> hash = new HashMap<>();
			hash.put("title", calendar.getCalTit());
			hash.put("start", calendar.getCalStart());
			hash.put("end", calendar.getCalEnd());
			hash.put("_id", calendar.getCalNo());

			hash.put("allDay", calendar.getCalAllday());
			hash.put("backgroundColor", calendar.getCalColor());
			hash.put("description", calendar.getCalCon());
			hash.put("type", calendar.getDepId());
			hash.put("username", calendar.getEmpId());

			list.add(hash);

		}

		return list;

	}
	
	//개인일정UI
	@GetMapping("/groupware/calendar/empCalendarList.do")
	public String empCalendar() {

		String logicalViewName = "groupware/calendar/empCalendar";
		return logicalViewName;
	}

}
