package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.groupware.attendance.dao.MyAnnualDao;
import kr.or.ddit.autumn.groupware.attendance.vo.AnnualRecodeVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AnnualVO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;

@Service
public class MyAnnualServiceImpl implements MyAnnualService {

	@Inject
	private MyAnnualDao dao;
		
	@Override
	public AnnualVO selectMyAnnual(String empId) {		
		
		AnnualVO annual = dao.selectEmployee(empId);
		int aul = annual.getAulCot()-annual.getAulLot();
		annual.setAulUse(aul);
		
		return annual;
	}

	@Override
	public List<AnnualRecodeVO> retrieveMyAnnualRecodeList(AttendPagingVO pagingVO) {
		return dao.selectMyAnnualRecodeList(pagingVO);
	}


	@Override
	public int retrieveTotalRecord(AttendPagingVO pagingVO) {
		return dao.selectTotalRecord(pagingVO);
	}

}
