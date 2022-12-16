package kr.or.ddit.autumn.management.group.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface ManagementEmployeePowerDAO {
	public int insertUser(String empId);
	public int insertHead(String empId);
	public int insertDirector(String empId);
	public int deletePowerUser(PowerVO power);
	public int deletePowerHead(PowerVO power);
	public int deletePowerDirector(PowerVO power);
	public PowerVO selectPower(String empId);
	public List<EmployeeVO> selectEmployeeHeadList(PagingVO<EmployeeVO> pagingVO);
	public List<EmployeeVO> selectEmployeeDirectorList(PagingVO<EmployeeVO> pagingVO);
	public int selectHeadRecord(PagingVO<EmployeeVO> pagingVO);
	public int selectDirectorRecord(PagingVO<EmployeeVO> pagingVO);
}
