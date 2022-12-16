package kr.or.ddit.autumn.groupware.calendar.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.calendar.dao.CalendarDAO;
import kr.or.ddit.autumn.vo.CalendarVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Service
public class CalendarServiceImpl implements CalendarService {
	@Inject
	private CalendarDAO dao;

	@Override
	public ServiceResult createCalendar(CalendarVO calendar) {
		ServiceResult result = null;
		
			
			int rowcnt = dao.insertCalendar(calendar);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		
		return result;
	}

	@Override
	public CalendarVO retrieveCalendar(Integer calNo) {
		CalendarVO calendar = dao.selectCalendar(calNo);
		if (calendar == null)
			throw new RuntimeException("없는 정보임");
		return calendar;
	}



	@Override
	public List<CalendarVO> retrieveCalendarList() {
		return dao.selectCalendarList();
	}
	
	@Override
	public List<CalendarVO> retrieveDepCalendarList(CalendarVO calendar) {
		return dao.selectDepCalendarList(calendar);
	}

	
	@Override
	public List<CalendarVO> retrieveEmpCalendarList(EmployeeVO emp) {
		return dao.selectEmpCalendarList(emp);
	}

	@Override
	public ServiceResult modifyCalendar(CalendarVO calendar) {
		retrieveCalendar(calendar.getCalNo());
		
		int rowcnt = dao.updateCalendar(calendar);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeCalendar(CalendarVO calendar) {
		retrieveCalendar(calendar.getCalNo());
		int rowcnt = dao.deleteCalendar(calendar.getCalNo());
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	


}
