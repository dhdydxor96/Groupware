package kr.or.ddit.autumn.commons.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.LogVO;

/**
 * 회원 관리(Persistence Layer), CRUD
 *
 */
@Mapper
public interface EmployeeDAO {
	
	//전체 리스트 조회
	public List<EmployeeVO> AllEmployeeList(String comCode);
	
	//부서별 리스트 조회
	public List<EmployeeVO> DeptEmployeeList(@Param("comCode") String comCode, @Param("depId") String depId);
	
	//사원 조회
	public EmployeeVO selectEmployee(String empId);
	
	//상태 변경===================================================
	public int onlineEmployee(@Param("empId") String empId);
	
	public int offlineEmployee(@Param("empId") String empId);
	
	public int awayEmployee(@Param("empId") String empId);  
	
	public int workYearsEmployee(String empId);
	//===========================================================
	
	
	//로그인 내역 등록===============================================
	public int insertLoginInfo(LogVO logVO);
	//==========================================================
}





















