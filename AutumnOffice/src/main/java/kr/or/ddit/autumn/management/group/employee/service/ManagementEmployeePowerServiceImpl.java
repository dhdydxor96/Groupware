package kr.or.ddit.autumn.management.group.employee.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.management.group.employee.dao.ManagementEmployeePowerDAO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ManagementEmployeePowerServiceImpl implements ManagementEmployeePowerService {
	
	private final ManagementEmployeePowerDAO powDAO;
	
	@Override
	public ServiceResult createUser(String empId) {
		int rowcnt = powDAO.insertUser(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createHead(String empId) {
		int rowcnt = powDAO.insertHead(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createDirector(String empId) {
		int rowcnt = powDAO.insertDirector(empId);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<EmployeeVO> retrieveEmployeeHeadList(PagingVO<EmployeeVO> pagingVO) {
		return powDAO.selectEmployeeHeadList(pagingVO);
	}

	@Override
	public List<EmployeeVO> retrieveEmployeeDirectorList(PagingVO<EmployeeVO> pagingVO) {
		return powDAO.selectEmployeeDirectorList(pagingVO);
	}


	@Override
	public int retrieveHeadCount(PagingVO<EmployeeVO> pagingVO) {
		return powDAO.selectHeadRecord(pagingVO);
	}

	@Override
	public int retrieveDirectorCount(PagingVO<EmployeeVO> pagingVO) {
		return powDAO.selectDirectorRecord(pagingVO);
	}

	@Override
	public PowerVO selectPower(String empId) {
		PowerVO power = powDAO.selectPower(empId);
		return power;
	}

	@Override
	public ServiceResult removePowerUser(PowerVO power) {
		int rowcnt = powDAO.deletePowerUser(power);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removePowerHead(PowerVO power) {
		int rowcnt = powDAO.deletePowerHead(power);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removePowerDirector(PowerVO power) {
		int rowcnt = powDAO.deletePowerDirector(power);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
