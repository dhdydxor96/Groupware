package kr.or.ddit.autumn.management.managementindex.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.management.managementindex.dao.ManagementIndexDAO;
import kr.or.ddit.autumn.management.managementindex.vo.ManagementIndexVO;

@Service
public class ManagementIndexServiceImpl implements ManagementIndexService {

	@Inject
	private ManagementIndexDAO dao;
	
	@Override
	public ManagementIndexVO selectIndex(String comCode) {
		return dao.selectIndex(comCode);
	}

}
