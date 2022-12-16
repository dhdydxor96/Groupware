package kr.or.ddit.autumn.commons.login.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.EmployeeVO;

@Mapper
public interface LoginFindPasswordDAO {

	public int checkEmp(EmployeeVO checkEmployee);
	
	public int updateEmp(EmployeeVO updateEmployee);
			
}
