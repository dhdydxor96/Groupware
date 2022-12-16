package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.attendance.dao.DepAnnualHistoryDAO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendEmployeeVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.LveRecodeVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DepAnnualHistoryServiceImpl implements DepAnnualHistoryService {

	@Inject
	private DepAnnualHistoryDAO dao;
	
	
	@Override
	public List<LveRecodeVO> depAnnualHistoryList(AttendEmployeeVO depInfo) {
		List<LveRecodeVO> depHistroyList = dao.depAnnualHistoryList(depInfo);
		log.info("depHistoryList : {}", depHistroyList);
		return depHistroyList;
	}


	@Override
	public List<LveRecodeVO> depAnnualHistoryAllList(DepartmentVO department) {
		List<LveRecodeVO> depHistoryAllList = dao.depAnnualHistoryAllList(department);
		return depHistoryAllList;
	}


	@Override
	public int historyRecode(PagingVO<LveRecodeVO> pagingVO) {		
		return dao.historyRecode(pagingVO);
	}


	@Override
	public List<LveRecodeVO> rertieveHistoryRecodeList(PagingVO<LveRecodeVO> pagingVO) {
		return dao.historyRecodeList(pagingVO);
	}

}
