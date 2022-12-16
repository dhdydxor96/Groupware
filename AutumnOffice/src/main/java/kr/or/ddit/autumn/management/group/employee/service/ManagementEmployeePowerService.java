package kr.or.ddit.autumn.management.group.employee.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface ManagementEmployeePowerService {
	public ServiceResult createUser(String empId);
	public ServiceResult createHead(String empId);
	public ServiceResult createDirector(String empId);
	public ServiceResult removePowerUser(PowerVO power);
	public ServiceResult removePowerHead(PowerVO power);
	public ServiceResult removePowerDirector(PowerVO power);
	public List<EmployeeVO> retrieveEmployeeHeadList(PagingVO<EmployeeVO> pagingVO);
	public List<EmployeeVO> retrieveEmployeeDirectorList(PagingVO<EmployeeVO> pagingVO);
	public int retrieveHeadCount(PagingVO<EmployeeVO> pagingVO);
	public int retrieveDirectorCount(PagingVO<EmployeeVO> pagingVO);
	public PowerVO selectPower(String empId);
}
