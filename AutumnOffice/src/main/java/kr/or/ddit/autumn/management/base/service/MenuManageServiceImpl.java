package kr.or.ddit.autumn.management.base.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.management.base.dao.MenuManageDAO;
import kr.or.ddit.autumn.vo.EmployeeVO;

@Service
public class MenuManageServiceImpl implements MenuManageService {

	@Inject
	private MenuManageDAO dao;
	
	@Override
	public List<EmployeeVO> AllEmployeeList(String comCode) {
		return dao.AllEmployeeList(comCode);
	}

}
