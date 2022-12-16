package kr.or.ddit.autumn.commons.employee.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.employee.dao.EmployeeDAO;
import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	@Inject
	private EmployeeDAO dao;



	@Override
	public List<EmployeeVO> allRetrieveEmployeeList(String comCode) {
		return dao.AllEmployeeList(comCode);
	}
	
	@Override
	public List<EmployeeVO> DeptEmployeeList(String comCode, String DepId){
		return dao.DeptEmployeeList(comCode, DepId);
	}
	
	@Override
	public EmployeeVO retrieveEmployee(String empId) {
		EmployeeVO employee = dao.selectEmployee(empId);
		if (employee == null)
			throw new RuntimeException(empId+"사원이 없음");
		return employee;
	}

	@Override
	public ServiceResult onlineEmployee(String empId) {
		int rowcnt = dao.onlineEmployee(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult offlineEmployee(String empId) {
		int rowcnt = dao.offlineEmployee(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult awayEmployee(String empId) {
		int rowcnt = dao.awayEmployee(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createLoginInfo(LogVO logVO) {
		int rowcnt = dao.insertLoginInfo(logVO);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	

}
