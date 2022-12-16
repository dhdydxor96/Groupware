package kr.or.ddit.autumn.commons.notify.event;

import kr.or.ddit.autumn.vo.NotifyVO;

public class NewNotifyEvent {
	private NotifyVO source;

	public NewNotifyEvent(NotifyVO source){
		this.source = source;
	}

	public NotifyVO getSource() {
		return source;
	}
}
