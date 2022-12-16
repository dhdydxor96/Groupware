package kr.or.ddit.autumn.groupware.attendance.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.groupware.attendance.dao.DepStatisticDAO;
import kr.or.ddit.autumn.groupware.attendance.vo.AttendPagingVO;
import kr.or.ddit.autumn.groupware.attendance.vo.DepStatisticVO;
import kr.or.ddit.autumn.vo.EmpTimeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class DepStatisticServiceImpl implements DepStatisticService {

	
	private final DepStatisticDAO dao;
	
	@Override
	public List<DepStatisticVO> retrievetDeptStatisticList(AttendPagingVO<DepStatisticVO> empVO) {
		
		EmpTimeVO empTimeVO = retrieveCompanyWorkTime(empVO.getComCode());
		
		List<DepStatisticVO> list = dao.selectDeptStatisticList(empVO);
		
		for(DepStatisticVO deptSta : list) {
			
			
			if(StringUtils.isNotBlank(deptSta.getStaOnt()) && (Integer.parseInt(empTimeVO.getEmtOnt().substring(0,2)) - Integer.parseInt(deptSta.getStaOnt().substring(0,2)))<=0 && !StringUtils.isNotBlank(deptSta.getVacCat()) && !StringUtils.isNotBlank(deptSta.getStaRec()) && !StringUtils.isNotBlank(deptSta.getBstTrp())) {
				log.info("empTimeVO에서 정규출근시간 값 {}",Integer.parseInt(empTimeVO.getEmtOnt().substring(0,2)));
				log.info("직원의 현재 출근시간 값 {}",Integer.parseInt(deptSta.getStaOnt().substring(0,2)));
				// 지각했을 때
				deptSta.setStaRes("C");
			}
			if(!StringUtils.isNotBlank(deptSta.getStaOnt()) && !StringUtils.isNotBlank(deptSta.getVacCat()) && !StringUtils.isNotBlank(deptSta.getStaRec()) && !StringUtils.isNotBlank(deptSta.getBstTrp())) {
				// 출근 기록 없을 때
				deptSta.setStaRes("G");
			}
		}
		
		
		
		return list;
	}

	@Override
	public int retrieveTotalStatistic(AttendPagingVO pagingVO) {
		return dao.selectTotalStatistic(pagingVO);
	}

	@Override
	public EmpTimeVO retrieveCompanyWorkTime(String comCode) {
		return dao.selectCompanyWorkTime(comCode);
	}

	@Override
	public DepStatisticVO retrieveDeptStatisticAll(DepStatisticVO deptStatus) {
		List<DepStatisticVO> list = dao.selectDeptStatisticAll(deptStatus);
		
		EmpTimeVO empTimeVO = retrieveCompanyWorkTime(deptStatus.getComCode());
		
		DepStatisticVO resultVO = new DepStatisticVO();
		
		int vac = 0;
		int rec = 0;
		int trip = 0;
		int late = 0;
		int non = 0;
		
		for(DepStatisticVO dep : list) {
			
			if(StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 휴가자 수 증가
				vac += 1;
				log.info("휴가 수 확인 {}", vac);
			}
			else if(!StringUtils.isNotBlank(dep.getVacCat()) && StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 연차 사용한 부서원 수 증가
				rec += 1;
				log.info("연차 수 확인 {}",rec);
			}
			else if(!StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && StringUtils.isNotBlank(dep.getBstTrp())) {
				// 출장 간 부서원 수 증가
				trip += 1;
				log.info("출장 수 확인 {}",trip);
			}
			else if(StringUtils.isNotBlank(dep.getStaOnt()) && (Integer.parseInt(empTimeVO.getEmtOnt().substring(0,2)) - Integer.parseInt(dep.getStaOnt().substring(0,2)))<=0 && !StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 지각자 수 증가
				late += 1;
				log.info("지각자 수 확인 {}",late);
			}
			else if(!StringUtils.isNotBlank(dep.getStaOnt()) && !StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 결근자 수 증가
				non += 1;
				log.info("결근자 수 확인 {}",non);
			}
		}
		
		resultVO.setVacRes(vac);
		resultVO.setRecRes(rec);
		resultVO.setTrpRes(trip);
		resultVO.setLateRes(late);
		resultVO.setNoRes(non);
		
		
		return resultVO;
	}

	@Override
	public DepStatisticVO retrieveEveryStatisticAll(DepStatisticVO deptStatus) {
		List<DepStatisticVO> list = dao.selectEveryStatisticAll(deptStatus);
		
		EmpTimeVO empTimeVO = retrieveCompanyWorkTime(deptStatus.getComCode());
		
		DepStatisticVO resultVO = new DepStatisticVO();
		
		int vac = 0;
		int rec = 0;
		int trip = 0;
		int late = 0;
		int non = 0;
		
		for(DepStatisticVO dep : list) {
			
			if(StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 휴가자 수 증가
				vac += 1;
				log.info("휴가 수 확인 {}", vac);
			}
			else if(!StringUtils.isNotBlank(dep.getVacCat()) && StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 연차 사용한 부서원 수 증가
				rec += 1;
				log.info("연차 수 확인 {}",rec);
			}
			else if(!StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && StringUtils.isNotBlank(dep.getBstTrp())) {
				// 출장 간 부서원 수 증가
				trip += 1;
				log.info("출장 수 확인 {}",trip);
			}
			else if(StringUtils.isNotBlank(dep.getStaOnt()) && (Integer.parseInt(empTimeVO.getEmtOnt().substring(0,2)) - Integer.parseInt(dep.getStaOnt().substring(0,2)))<=0 && !StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 지각자 수 증가
				late += 1;
				log.info("지각자 수 확인 {}",late);
			}
			else if(!StringUtils.isNotBlank(dep.getStaOnt()) && !StringUtils.isNotBlank(dep.getVacCat()) && !StringUtils.isNotBlank(dep.getStaRec()) && !StringUtils.isNotBlank(dep.getBstTrp())) {
				// 결근자 수 증가
				non += 1;
				log.info("결근자 수 확인 {}",non);
			}
		}
		
		resultVO.setVacRes(vac);
		resultVO.setRecRes(rec);
		resultVO.setTrpRes(trip);
		resultVO.setLateRes(late);
		resultVO.setNoRes(non);
		
		
		return resultVO;
	}

	@Override
	public List<DepStatisticVO> retrieveEveryStatisticList(AttendPagingVO<DepStatisticVO> empVO) {
		
		EmpTimeVO empTimeVO = retrieveCompanyWorkTime(empVO.getComCode());
		
		List<DepStatisticVO> list = dao.selectEveryStatisticList(empVO);
		
		for(DepStatisticVO deptSta : list) {
			if(StringUtils.isNotBlank(deptSta.getStaOnt()) && (Integer.parseInt(empTimeVO.getEmtOnt().substring(0,2)) - Integer.parseInt(deptSta.getStaOnt().substring(0,2)))<=0 && !StringUtils.isNotBlank(deptSta.getVacCat()) && !StringUtils.isNotBlank(deptSta.getStaRec()) && !StringUtils.isNotBlank(deptSta.getBstTrp())) {
				// 지각했을 때
				deptSta.setStaRes("C");
			}
			if(!StringUtils.isNotBlank(deptSta.getStaOnt()) && !StringUtils.isNotBlank(deptSta.getVacCat()) && !StringUtils.isNotBlank(deptSta.getStaRec()) && !StringUtils.isNotBlank(deptSta.getBstTrp())) {
				// 출근 기록 없을 때
				deptSta.setStaRes("G");
			}
		}
		
		
		
		return list;
	}

	@Override
	public int retrieveTotalEveryStatistic(AttendPagingVO pagingVO) {
		return dao.selectTotalEveryStatistic(pagingVO);
	}

}
