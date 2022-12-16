package kr.or.ddit.autumn.management.base.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.vo.CompanyVO;

@Mapper
public interface LogoManageDAO {

	/**
	 * 기업의 로고 이미지 변경하기 (재등록하는 과정)
	 * @param attatchVO=변경하고자 하는 기업 로고의 정보
	 * @return
	 */
	public int insertLogoImage(AttatchVO attatchVO);
	
	/**
	 * 기업의 로고 이미지 변경하기 (삭제를 위해 attatch 정보 불러오기)
	 * @param comCode
	 * @return
	 */
	public AttatchVO selectCompanyAttatchInfo(String comCode);
	
	/**
	 * 기업의 로고 이미지 변경하기 (기존의 로고 이미지 삭제)
	 * @param comCode
	 * @return
	 */
	public int deleteLogoImage(String comCode);
}
