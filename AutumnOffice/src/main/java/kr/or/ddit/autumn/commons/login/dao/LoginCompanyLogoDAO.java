package kr.or.ddit.autumn.commons.login.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.AttatchVO;

@Mapper
public interface LoginCompanyLogoDAO {

	/**
	 * 회사 로고 변경
	 * @param comCode
	 * @return
	 */
	public AttatchVO companyLogo(int comCode);
}
