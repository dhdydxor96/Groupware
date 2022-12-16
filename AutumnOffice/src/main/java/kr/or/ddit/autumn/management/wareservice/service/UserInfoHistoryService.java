package kr.or.ddit.autumn.management.wareservice.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface UserInfoHistoryService {

	public int infoTotalRecode(PagingVO<ConsultingServiceVO> pagingVO);
	
	public List<ConsultingServiceVO> infoServiceList (PagingVO<ConsultingServiceVO> pagingVO);
	

}
