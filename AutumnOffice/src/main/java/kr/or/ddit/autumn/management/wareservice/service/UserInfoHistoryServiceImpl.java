package kr.or.ddit.autumn.management.wareservice.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.management.wareservice.dao.UserInfoHistoryDAO;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Service
public class UserInfoHistoryServiceImpl implements UserInfoHistoryService {

	@Inject
	private UserInfoHistoryDAO dao;
	
	@Override
	public int infoTotalRecode(PagingVO<ConsultingServiceVO> pagingVO) {
		return dao.infoTotalRecode(pagingVO);
	}

	@Override
	public List<ConsultingServiceVO> infoServiceList(PagingVO<ConsultingServiceVO> pagingVO) {
		return dao.infoServiceList(pagingVO);
	}


}
