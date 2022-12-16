package kr.or.ddit.autumn.groupware.calendar.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.EmployeeVO;


@Mapper
public interface CalendarDAO {

	
	
	public CalendarVO selectCalendar(Integer calNo);
	
 
	public List<CalendarVO> selectCalendarList();
	//부서일정 
	public List<CalendarVO> selectDepCalendarList(CalendarVO calendar);
	//개인일정
	public List<CalendarVO> selectEmpCalendarList(EmployeeVO emp);

	public int insertCalendar(CalendarVO calendar);
	
	public int updateCalendar(CalendarVO calendar);
	
	public int deleteCalendar(@Param("calNo") Integer calNo);
}
