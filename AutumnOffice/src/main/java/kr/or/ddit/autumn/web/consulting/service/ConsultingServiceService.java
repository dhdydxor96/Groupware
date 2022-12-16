package kr.or.ddit.autumn.web.consulting.service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;

public interface ConsultingServiceService {
	public ServiceResult createConsultingService(ConsultingServiceVO consultingService);
}
