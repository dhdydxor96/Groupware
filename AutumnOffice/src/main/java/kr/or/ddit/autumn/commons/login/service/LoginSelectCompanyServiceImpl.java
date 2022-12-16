package kr.or.ddit.autumn.commons.login.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.login.dao.LoginSelectCompanyDAO;
import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Service
public class LoginSelectCompanyServiceImpl implements LoginSelectCompanyService {

	@Inject
	private LoginSelectCompanyDAO dao;
	
	@Override
	public List<CompanyVO> companyCheck() {
		return dao.companyCheck();
	}

	@Override
	public boolean companyCompare(EmployeeVO employeeVO) {
		EmployeeVO checkemp = dao.companyCompare(employeeVO);
		
		boolean result = false;
		
		if(checkemp == null) {
			result = false;
		}else {
			result = true;
		}
		return result;
	}

}
