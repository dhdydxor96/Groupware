package kr.or.ddit.autumn.management.menu.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.management.menu.dao.AttendanceManageDAO;
import kr.or.ddit.autumn.vo.AulLeaveVO;
import kr.or.ddit.autumn.vo.EmpTimeVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class AttendanceManageServiceImpl implements AttendanceManageService {

	private final AttendanceManageDAO dao;
	
	@Override
	public ServiceResult insertAttendanceManage(EmpTimeVO emptimeVO) {
		ServiceResult result = null;
		
		int rownum = dao.insertAttendanceManage(emptimeVO);
		
		if(rownum>=1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public int retrieveAttendanceManage(String comCode) {
		return dao.selectAttendanceManage(comCode);
	}

	@Override
	public ServiceResult updateAtttendanceManage(EmpTimeVO emptimeVO) {
		ServiceResult result = null;
		
		int rownum = dao.updateAtttendanceManage(emptimeVO);
		
		if(rownum>=1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

	@Override
	public EmpTimeVO retrieveAttendaceManageList(String comCode) {
		return dao.selectAttendaceManageList(comCode);
	}
	
	//----- 연차 용도 ---------------------------------------------------------

	@Override
	public ServiceResult updateVacation(String comCode) {
		ServiceResult result = ServiceResult.OK;
		ServiceResult insertResult = ServiceResult.OK;
		
		// 사원정보
		List<EmployeeVO> employeeList =  retrieveEmployee(comCode);
		
		log.info("serviceImpl에서 사원정보 제대로 나오는지 {}", employeeList);
		
		// 연차테이블 정보
		List<AulLeaveVO> vacationList = retrieveVacationList(comCode);

		//=================================================================
		// insert for문
		for(EmployeeVO employeeVO : employeeList) {
			int num = 0; // 초기화 값
			
			for(AulLeaveVO leaveVO : vacationList) {
				if(!insertResult.equals(ServiceResult.FAIL)) {
					
					if((leaveVO.getEmpId()).equals(employeeVO.getEmpId())) {
						
						num = 1;
					}
					
//					log.info("vacation값 {}  : employee 값 {}", leaveVO.getEmpId(), employeeVO.getEmpId());
//					log.info("vacationList에 employee Id가 포함되어 있는가 {}", (leaveVO.getEmpId()).equals(employeeVO.getEmpId()) );
				}
			}
			
			if(num == 0) {
				insertResult = createVacation(employeeVO.getEmpId());
				
			}
		}
		log.info("INSERT 결과", insertResult);
		
		//=================================================================
		// 연차 테이블에 사원 정보가 모두 등록이 된다면
		if(insertResult.equals(ServiceResult.OK)) {
			for(EmployeeVO employeeVO : employeeList) {
				
				if(!result.equals(ServiceResult.FAIL)) {
					result = updateVacation(employeeVO.getEmpId());
				}
			}
			
		}
		
		return result;
	}

	@Override
	public List<EmployeeVO> retrieveEmployee(String comCode) {
		return dao.selectEmployee(comCode);
	}

	@Override
	public List<AulLeaveVO> retrieveVacationList(String comCode) {
		return dao.selectVacationList(comCode);
	}

	@Override
	public ServiceResult createVacation(String empId) {
		
		ServiceResult result = null;
		
		int rownum = dao.insertVacation(empId);
		
		if(rownum >= 1) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

}
