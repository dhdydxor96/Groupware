package kr.or.ddit.autumn.web.consulting.service;

import kr.or.ddit.autumn.commons.enumpkg.ServiceResult;
import kr.or.ddit.autumn.web.vo.ConsultingVO;

public interface ConsultingService {
	public ServiceResult createConsulting(ConsultingVO consulting);
	public int idCheck(ConsultingVO consulting);
	public int comCodeCheck(ConsultingVO consulting);
}
