package kr.or.ddit.autumn.commons.login.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Mapper
public interface LoginSelectCompanyDAO {

	public List<CompanyVO> companyCheck();
	
	public EmployeeVO companyCompare(EmployeeVO employeeVO);
}
