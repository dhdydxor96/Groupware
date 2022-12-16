package kr.or.ddit.autumn.management.base.service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;

public interface LogoManageService {

	/**
	 * 기업의 로고 이미지 변경하기
	 * @param companyVO=변경하고자 하는 본인의 프로필 정보
	 * @return
	 */
	public ServiceResult updateLogoImage(CompanyVO companyVO);
	
	/**
	 * 기업의 로고 이미지 정보 조회하기
	 * @param comCode= 조회하고자 하는 기업의 아이디
	 * @return
	 */
	public AttatchVO retrieveLogoImage(String comCode);
	
}
