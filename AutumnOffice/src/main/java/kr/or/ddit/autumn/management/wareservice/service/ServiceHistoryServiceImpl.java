package kr.or.ddit.autumn.management.wareservice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.management.wareservice.dao.ServiceHistoryDAO;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ServiceHistoryServiceImpl implements ServiceHistoryService {

	private final ServiceHistoryDAO dao;
	
	
	@Override
	public ConsultingServiceVO retrieveServiceHistory(String comCode) {
		ConsultingServiceVO serviceHistory = dao.selectConsultingService(comCode);
		return serviceHistory;
	}

	@Override
	public List<ConsultingServiceVO> retrieveServiceHistroyList(PagingVO<ConsultingServiceVO> pagingVO) {		
		return dao.selectConsultingServiceList(pagingVO);
	}

	@Override
	public int retrieveServiceHistoryCount(PagingVO<ConsultingServiceVO> pagingVO) {
		return dao.SelectTotalRecode(pagingVO);
	}

}
