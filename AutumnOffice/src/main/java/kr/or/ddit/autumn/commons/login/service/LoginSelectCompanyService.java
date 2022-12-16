package kr.or.ddit.autumn.commons.login.service;

import java.util.List;

import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

public interface LoginSelectCompanyService {

	/**
	 * 로그인시 필요한 회사 리스트
	 * @return
	 */
	public List<CompanyVO> companyCheck();
	
	/**
	 * 회사코드와 아이디 검증
	 * @param employeeVO
	 * @return
	 */
	public boolean companyCompare(EmployeeVO employeeVO);
}
