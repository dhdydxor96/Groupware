package kr.or.ddit.autumn.management.wareservice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface ServiceHistoryDAO {

	/**
	 * 검색 조건에 맞는 레코드수 조회
	 * @param pagingVO
	 * @return
	 */
	public int SelectTotalRecode(PagingVO<ConsultingServiceVO> pagingVO);
	
	/**
	 * 검색 조건에 맞는 레코드 목록 조회
	 * @param pagingVO
	 * @return
	 */
	public List<ConsultingServiceVO> selectConsultingServiceList(PagingVO<ConsultingServiceVO> pagingVO);
	
	/**
	 * 회사 상세조회
	 * @param serCode
	 * @return
	 */
	public ConsultingServiceVO selectConsultingService(@Param("comCode")String comCode);
	
	
}
