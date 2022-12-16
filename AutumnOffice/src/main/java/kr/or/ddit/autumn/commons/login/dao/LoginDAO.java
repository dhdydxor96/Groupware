package kr.or.ddit.autumn.commons.login.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.CompanyVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Mapper
public interface LoginDAO {
	public EmployeeVO findByPk(@Param("username") String username);
	public CompanyVO findByComPk(@Param("username") String username);
}
