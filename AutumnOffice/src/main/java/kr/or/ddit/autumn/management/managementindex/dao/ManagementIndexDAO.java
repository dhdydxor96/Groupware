package kr.or.ddit.autumn.management.managementindex.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.management.managementindex.vo.ManagementIndexVO;

@Mapper
public interface ManagementIndexDAO {

	/**
	 * 관리자 메인페이지 정보 가져오기
	 * @param Comcode
	 * @return
	 */
	public ManagementIndexVO selectIndex(String comCode);
}
