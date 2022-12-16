package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.attendance.dao.DepAnnualDao;
import kr.or.ddit.autumn.groupware.attendance.vo.DepAnnualVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DepAnnualServiceImpl implements DepAnnualService {

	@Inject
	private DepAnnualDao dao;
	
	
	
	
	@Override
	public List<DepAnnualVO> selectDepAnnual(String depId) {
		List<DepAnnualVO> depAnnual = dao.selectDepAnnual(depId); 
		for(DepAnnualVO annual : depAnnual) {
		int aul = annual.getAulCot()-annual.getAulLot();
		annual.setAulUse(aul);
		
//		int aulCot = annual.getAulCot() + annual.getEmpYears();
//		annual.setAulCot(aulCot);
		}
		
		return depAnnual;
	}




	@Override
	public List<DepAnnualVO> retrieveDepAnnualList(PagingVO pagingVO) {
		List<DepAnnualVO> depAnnual = dao.selectDepAnnualList(pagingVO); 
//		for(DepAnnualVO annual : depAnnual) {
//		int aul = annual.getAulCot()-annual.getAulLot();
//		annual.setAulUse(aul);
//		
//		log.info("사용 연차 계산 {}", annual);
//		
//		int aulCot = annual.getAulCot() + annual.getEmpYears();
//		annual.setAulCot(aulCot);
//		}
		
		return depAnnual;
	}




	@Override
	public int retrieveTotalRecord(PagingVO pagingVO) {
		return dao.selectTotalRecord(pagingVO);
	}

}
