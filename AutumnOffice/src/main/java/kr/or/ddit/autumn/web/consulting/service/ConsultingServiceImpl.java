package kr.or.ddit.autumn.web.consulting.service;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.web.consulting.dao.ConsultingDAO;
import kr.or.ddit.autumn.web.vo.ConsultingVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ConsultingServiceImpl implements ConsultingService {
	
	private final ConsultingDAO conDAO;
	
	@Override
	public ServiceResult createConsulting(ConsultingVO consulting) {
		ServiceResult result = null;
		int rowcnt = conDAO.insertConsulting(consulting);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public int idCheck(ConsultingVO consulting) {
		int result = conDAO.idCheck(consulting);
		return result;
	}

	@Override
	public int comCodeCheck(ConsultingVO consulting) {
		int result = conDAO.comCodeCheck(consulting);
		return result;
	}


}
