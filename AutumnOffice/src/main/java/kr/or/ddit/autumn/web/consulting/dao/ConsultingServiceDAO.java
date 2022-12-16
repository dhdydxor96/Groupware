package kr.or.ddit.autumn.web.consulting.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.web.vo.ConsultingServiceVO;

@Mapper
public interface ConsultingServiceDAO {
	public int insertConsultingService(ConsultingServiceVO consultingService);
}
