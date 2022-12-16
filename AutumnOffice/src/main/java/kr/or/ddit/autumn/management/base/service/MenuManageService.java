package kr.or.ddit.autumn.management.base.service;

import java.util.List;

import kr.or.ddit.autumn.vo.EmployeeVO;

public interface MenuManageService {

	public List<EmployeeVO> AllEmployeeList(String comCode);	
}
