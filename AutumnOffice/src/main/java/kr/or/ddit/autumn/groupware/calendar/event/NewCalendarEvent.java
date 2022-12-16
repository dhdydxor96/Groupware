package kr.or.ddit.autumn.groupware.calendar.event;

import kr.or.ddit.autumn.vo.CalendarVO;

public class NewCalendarEvent {
	private CalendarVO source;

	public NewCalendarEvent(CalendarVO source){
		this.source = source;
	}

	public CalendarVO getSource() {
		return source;
	}
}
