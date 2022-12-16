package kr.or.ddit.autumn.management.wareservice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface UserInfoHistoryDAO {

	/**
	 * 총 레코드 수 조회
	 * @param pagingVO
	 * @return
	 */
	public int infoTotalRecode(PagingVO<ConsultingServiceVO> pagingVO);
	
	/**
	 * 서비스 목록 리스트
	 * @param pagingVO
	 * @return
	 */
	public List<ConsultingServiceVO> infoServiceList (PagingVO<ConsultingServiceVO> pagingVO);
	

}
