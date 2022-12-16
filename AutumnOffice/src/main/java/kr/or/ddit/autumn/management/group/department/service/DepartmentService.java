package kr.or.ddit.autumn.management.group.department.service;

import java.util.List;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface DepartmentService {
	public ServiceResult createDepartment(DepartmentVO department);
	public DepartmentVO retrieveDepartment(String depId);
	public List<DepartmentVO> retrieveDepartmentList(PagingVO<DepartmentVO> pagingVO);
	public int retrieveDepartmentCount(PagingVO<DepartmentVO> pagingVO);
	public ServiceResult modifyDepartment(DepartmentVO department);
	public int removeDepartment(DepartmentVO department);
	public int idCheck(DepartmentVO department);
	public List<DepartmentVO> departmentList(DepartmentVO department);
	public List<PowerVO> retrieveHeadList(PowerVO power);
}
