package kr.or.ddit.autumn.groupware.calendar.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.exception.UserNotFoundException;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

/**
 * 회원 관리(Business Logic Layer), CRUD
 *
 */


public interface CalendarService {
	

	public CalendarVO retrieveCalendar(Integer calNo);
	


	public List<CalendarVO> retrieveCalendarList();

	public List<CalendarVO> retrieveDepCalendarList(CalendarVO calendar);
	
	public List<CalendarVO> retrieveEmpCalendarList(EmployeeVO emp);

	public ServiceResult createCalendar(CalendarVO calender);

	public ServiceResult modifyCalendar(CalendarVO calendar);

	public ServiceResult removeCalendar(CalendarVO calendar);
}















