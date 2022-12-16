package kr.or.ddit.autumn.management.group.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.JobVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface ManagementEmployeeDAO {
	public int insertEmployee(EmployeeVO employee);
	public EmployeeVO selectEmployee(@Param("empId") String empId);
	public int selectTotalRecord(PagingVO<EmployeeVO> pagingVO);
	public int selectRestignationTotalRecord(PagingVO<EmployeeVO> pagingVO);
	public List<EmployeeVO> selectEmployeeList(PagingVO<EmployeeVO> pagingVO);
	public int updateEmployee(EmployeeVO employee);
	public int deleteEmployee(EmployeeVO employee);
	public AttatchVO selectEmployeeImage(String empId);
	public List<DepartmentVO> selectDepartmentList(String comCode);
	public List<JobVO> selectJobList(String comCode);
	public List<EmployeeVO> selectResignationList(PagingVO<EmployeeVO> pagingVO);
	public int deleteResignation(EmployeeVO employee);
	public int idCheck(EmployeeVO employee);
	
}
