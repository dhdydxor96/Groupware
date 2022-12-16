package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.LveRecodeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface DepAnnualHistoryService {

	public List<LveRecodeVO> depAnnualHistoryList(AttendEmployeeVO depInfo);
	
	public List<LveRecodeVO> depAnnualHistoryAllList(DepartmentVO department);
	
	public int historyRecode(PagingVO<LveRecodeVO> pagingVO);
	
	public List<LveRecodeVO> rertieveHistoryRecodeList(PagingVO<LveRecodeVO> pagingVO); 
}
