package kr.or.ddit.autumn.commons.notify.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.NotifyVO;

public interface NotifyService {

	public ServiceResult createNotify(NotifyVO notify);

	public NotifyVO retrieveNotify(Integer notNo);

	public List<NotifyVO> retrieveNotifyList(String empId);

	public ServiceResult modifyNotify(NotifyVO notify);
	
	public ServiceResult modifyAllNotify(String empId);

	public ServiceResult removeNotify(Integer notNo);
	
	public ServiceResult removeAllNotify(String empId);
	
	//인서트 모듈화
	public void notifyInsertModule(String empId, Integer type);
}
