package kr.or.ddit.autumn.commons.login.service;

import kr.or.ddit.autumn.vo.EmployeeVO;

public interface LoginFindPasswordService {
	
	public int checkEmp(EmployeeVO checkEmployee);
	
	public int updateEmp(EmployeeVO updateEmployee);

}
