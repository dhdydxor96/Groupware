package kr.or.ddit.autumn.groupware.calendar.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.UpdateGroup;
import kr.or.ddit.autumn.groupware.calendar.service.CalendarService;
import kr.or.ddit.autumn.vo.CalendarVO;


@Controller
@RequestMapping("groupware/calendar")
public class CalendarUpdateController {
	
	@Inject
	private CalendarService service;
	


	//개인일정수정
	@PostMapping("/empCalendarUpdate.do")
	public String calendarUpdate(
	    @Validated(UpdateGroup.class) @ModelAttribute("calendar") CalendarVO calendar
		, BindingResult errors
		, Model model
	) {
		
		calendar.setCalSta("1");
		System.out.println("calendar" + calendar);
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyCalendar(calendar);
			
			String message = null;
			switch (result) {
				case FAIL:
					message = "실패";
					viewName = "groupware/calendar/empCalendar";
					break;
				case OK:
					viewName = "redirect:/groupware/calendar/empCalendarList.do";
					break;
				default:
					message = "서버 오류";
					viewName = "groupware/calendar/empCalendar";
					break;
			}
			model.addAttribute("message", message);
		}else {
			viewName = "groupware/calendar/empCalendar";
		}
		return viewName;
	}
	
	
	
	
	
	//부서일정수정
		@PostMapping("/depCalendarUpdate.do")
		public String depCalendarUpdate(
		    @Validated(UpdateGroup.class) @ModelAttribute("calendar") CalendarVO calendar
			, BindingResult errors
			, Model model
		) {
			calendar.setCalSta("0");
			System.out.println("calendar" + calendar);
			String viewName = null;
			if(!errors.hasErrors()) {
				ServiceResult result = service.modifyCalendar(calendar);
				
				String message = null;
				switch (result) {
					case FAIL:
						message = "실패";
						viewName = "groupware/calendar/empCalendar";
						break;
					case OK:
						viewName = "redirect:/groupware/calendar/empCalendarList.do";
						break;
					default:
						message = "서버 오류";
						viewName = "groupware/calendar/empCalendar";
						break;
				}
				model.addAttribute("message", message);
			}else {
				viewName = "groupware/calendar/empCalendar";
			}
			return viewName;
		}
}

	
		
	






















