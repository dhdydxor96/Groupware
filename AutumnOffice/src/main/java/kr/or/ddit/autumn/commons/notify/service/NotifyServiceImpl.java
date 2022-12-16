package kr.or.ddit.autumn.commons.notify.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.autumn.commons.employee.service.EmployeeService;
import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.commons.login.vo.EmployeeVOWrapper;
import kr.or.ddit.autumn.commons.notify.dao.NotifyDAO;
import kr.or.ddit.autumn.commons.notify.event.NewNotifyEvent;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.NotifyVO;

@Service
public class NotifyServiceImpl implements NotifyService {
	@Inject
	private NotifyDAO dao;
	
	@Inject
	private WebApplicationContext context;

	@Override
	public ServiceResult createNotify(NotifyVO notify) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		EmployeeVOWrapper employeeWrapper = (EmployeeVOWrapper) principal;
		EmployeeVO employee = employeeWrapper.getRealUser();
		
		ServiceResult result = null;

		if(notify.getNotType()==0) {
			notify.setNotCon("채팅에 초대 하셨습니다!");
			notify.setNotUrl("/groupware/chat/chatHome.do");
		}else if(notify.getNotType()==1) {
			notify.setNotCon("기안을 올렸습니다!");
			notify.setNotUrl("/groupware/approval/doc/dueAppDocList.do");
		}else if(notify.getNotType()==2) {
			notify.setNotCon("올리신 기안을 최종승인 하셨습니다!");
			notify.setNotUrl("/groupware/approval/doc/draftDocList.do");
		}else if(notify.getNotType()==3) {
			notify.setNotCon("올리신 기안을 반려 하셨습니다!");
			notify.setNotUrl("/groupware/approval/doc/draftDocList.do");
		}else if(notify.getNotType()==4) {
			notify.setNotCon("새로운 설문을 등록하셨습니다!");
			notify.setNotUrl("/groupware/survey/surveyProgressList.do");
		}else if(notify.getNotType()==5) {
			notify.setNotCon("등록하신 설문이 마감되었습니다!");
			notify.setNotUrl("/groupware/report/reportHome.do");
		}else if(notify.getNotType()==6) {
			notify.setNotCon("기안을 올렸습니다!");
			notify.setNotUrl("/groupware/approval/doc/waitAppDocList.do");
		}else if(notify.getNotType()==7) {
			notify.setNotCon("부서 일정을 추가하셨습니다!");
			notify.setNotUrl("/groupware/calendar/depCalendarList.do");
		}else if(notify.getNotType()==8) {
			notify.setNotCon("올리신 기안에 참조자로 등록하셨습니다!");
			notify.setNotUrl("/groupware/approval/doc/refDocList.do");
		}
		else{
			notify.setNotCon("알림을 보냈습니다!");
		}
		notify.setSendempId(employee.getEmpId());
		notify.setNotName(employee.getEmpNm()); 
		int rowcnt = dao.insertNotify(notify);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;

		return result;
	}

	@Override
	public NotifyVO retrieveNotify(Integer notNo) {
		NotifyVO Notify = dao.selectNotify(notNo);
		if (Notify == null)
			throw new RuntimeException("해당 알림 없음");
		return Notify;
	}

	@Override
	public List<NotifyVO> retrieveNotifyList(String empId) {
		return dao.selectNotifyList(empId);
	}

	@Override
	public ServiceResult modifyNotify(NotifyVO Notify) {
		retrieveNotify(Notify.getNotNo());
		int rowcnt = dao.updateNotify(Notify);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public ServiceResult modifyAllNotify(String empId) {
		
		int rowcnt = dao.updateAllNotify(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeNotify(Integer notNo) {
		retrieveNotify(notNo);
		int rowcnt = dao.deleteNotify(notNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public ServiceResult removeAllNotify(String empId) {
		
		int rowcnt = dao.deleteAllNotify(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public void notifyInsertModule(String empId, Integer type) {
  		NotifyVO notify = new NotifyVO();
  		notify.setEmpId(empId);
			notify.setNotType(type);
			createNotify(notify);
			NewNotifyEvent event = new NewNotifyEvent(notify);
			context.publishEvent(event);
  	}

}
