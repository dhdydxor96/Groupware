package kr.or.ddit.autumn.management.wareservice.service;

import java.util.List;

import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

public interface ServiceHistoryService {

	public ConsultingServiceVO retrieveServiceHistory(String comCode);
	public List<ConsultingServiceVO> retrieveServiceHistroyList(PagingVO<ConsultingServiceVO> pagingVO);
	public int retrieveServiceHistoryCount(PagingVO<ConsultingServiceVO> pagingVO);
}
