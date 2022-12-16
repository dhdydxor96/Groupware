package kr.or.ddit.autumn.commons.employee.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;

public interface EmployeeService {
	//전체 리스트 조회
	public List<EmployeeVO> allRetrieveEmployeeList(String comCode);
	//부서별 리스트 조회
	public List<EmployeeVO> DeptEmployeeList(String comCode, String DepId);
	
	public EmployeeVO retrieveEmployee(String empId);
	
	//상태 변경===================================================
	public ServiceResult onlineEmployee(String empId);
	
	public ServiceResult offlineEmployee(String empId);
	
	public ServiceResult awayEmployee(String empId);
	//==========================================================
	
	//로그인 내역 등록===============================================
	public ServiceResult createLoginInfo(LogVO logVO);
	//==========================================================
	
}
