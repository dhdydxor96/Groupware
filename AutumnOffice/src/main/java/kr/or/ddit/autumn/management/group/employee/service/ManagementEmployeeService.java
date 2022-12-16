package kr.or.ddit.autumn.management.group.employee.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface ManagementEmployeeService {
	public ServiceResult createEmployee(EmployeeVO employee);
	public EmployeeVO retrieveEmployee(String empId);
	public int retrieveEmpCount(PagingVO<EmployeeVO> pagingVO);
	public int retrieveResignationEmpCount(PagingVO<EmployeeVO> pagingVO);
	public List<EmployeeVO> retrieveEmployeeList(PagingVO<EmployeeVO> pagingVO);
	public ServiceResult modifyEmployee(EmployeeVO employee);
	public ServiceResult removeEmployee(EmployeeVO employee);
	public AttatchVO retrieveAttatch(String empId);
	public List<DepartmentVO> retrieveDepartmentList(String comCode);
	public List<JobVO> retrieveJobList(String comCode);
	public List<EmployeeVO> retrieveResignationList(PagingVO<EmployeeVO> pagingVO);
	public ServiceResult removeResignation(EmployeeVO employee);
	public int idCheck(EmployeeVO employee);
}
