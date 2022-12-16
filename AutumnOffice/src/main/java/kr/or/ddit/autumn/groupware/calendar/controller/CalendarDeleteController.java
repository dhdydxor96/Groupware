package kr.or.ddit.autumn.groupware.calendar.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.validate.DeleteGroup;
import kr.or.ddit.autumn.groupware.calendar.service.CalendarService;
import kr.or.ddit.autumn.vo.CalendarVO;

@Controller
@RequestMapping("/groupware/calendar")
public class CalendarDeleteController extends HttpServlet {
	@Inject
	private CalendarService service;
	
	//개인일정삭제
	@PostMapping("/calendarDelete.do")
	public String doPost(@Validated(DeleteGroup.class) @ModelAttribute("calNo") int calNo
			, BindingResult errors
			) {

		CalendarVO calendar = new CalendarVO();
		calendar.setCalNo(calNo);
		ServiceResult result = service.removeCalendar(calendar);
		String viewName = null;
		if(ServiceResult.OK.equals(result)) {
			viewName = "redirect:/groupware/calendar/empCalendarList.do";
		}else {
			
			viewName = "redirect:/groupware/calendar/empCalendarList.do";
		}
		
		return viewName;
	}
	
	
	
	
}
