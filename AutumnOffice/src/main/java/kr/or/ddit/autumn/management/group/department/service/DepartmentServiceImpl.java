package kr.or.ddit.autumn.management.group.department.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.management.group.department.dao.DepartmentDAO;
import kr.or.ddit.autumn.vo.DepartmentVO;
import kr.or.ddit.autumn.vo.EmployeeVO;
import kr.or.ddit.autumn.vo.PowerVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentServiceImpl implements DepartmentService {
	
	private final DepartmentDAO depDAO;
	
	
	@Override
	public ServiceResult createDepartment(DepartmentVO department) {
		int rowcnt = depDAO.insertDepartment(department);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public DepartmentVO retrieveDepartment(String depId) {
		DepartmentVO department = depDAO.selectDepartment(depId);
		if(department==null)
			throw new RuntimeException(String.format("%d 부서가 없음", depId));
		return department;
	}

	@Override
	public List<DepartmentVO> retrieveDepartmentList(PagingVO<DepartmentVO> pagingVO) {
		return depDAO.selectDepartmentList(pagingVO);
	}

	@Override
	public int retrieveDepartmentCount(PagingVO<DepartmentVO> pagingVO) {
		return depDAO.selectTotalRecord(pagingVO);
	}

	@Override
	public ServiceResult modifyDepartment(DepartmentVO department) {
		retrieveDepartment(department.getDepId());
		int rowcnt = depDAO.updateDepartment(department);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public int removeDepartment(DepartmentVO department) {
		return depDAO.deleteDepartment(department);
	}

	@Override
	public int idCheck(DepartmentVO department) {
		int result = depDAO.idCheck(department);
		return result;
	}

	@Override
	public List<DepartmentVO> departmentList(DepartmentVO department) {
		return depDAO.departmentList(department);
	}

	@Override
	public List<PowerVO> retrieveHeadList(PowerVO power) {
		return depDAO.selectHeadList(power);
	}


}
