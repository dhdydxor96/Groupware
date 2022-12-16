package kr.or.ddit.autumn.management.base.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;

@Mapper
public interface MenuManageDAO {

	public int insertMenuPow(PowerVO powerVO);
	
	//본인 회사의 사원들 조회 
	public List<EmployeeVO> AllEmployeeList(String comCode);
		
}
