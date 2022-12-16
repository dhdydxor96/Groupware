package kr.or.ddit.autumn.management.group.employee.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Mapper
public interface ManagementEmployeeAttatchDAO {
	public int insertAttatches(EmployeeVO employee);
	public AttatchVO selectAttatch(String empId);
	public int deleteAttatches(@Param("delAttNos") int[] delAttNos);
	public int deleteAttatch(String empId);
}
