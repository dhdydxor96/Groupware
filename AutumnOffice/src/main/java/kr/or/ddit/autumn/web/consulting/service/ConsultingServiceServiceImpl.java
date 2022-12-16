package kr.or.ddit.autumn.web.consulting.service;

import org.springframework.stereotype.Service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.web.consulting.dao.ConsultingServiceDAO;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ConsultingServiceServiceImpl implements ConsultingServiceService {
	
	private final ConsultingServiceDAO serDAO;
	

	@Override
	public ServiceResult createConsultingService(ConsultingServiceVO consultingService) {
		ServiceResult result = null;
		int rowcnt = serDAO.insertConsultingService(consultingService);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

}
