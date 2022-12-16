package kr.or.ddit.autumn.web.consulting.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.autumn.web.vo.ConsultingVO;

@Mapper
public interface ConsultingDAO {
	public int insertConsulting(ConsultingVO consulting);
	public int idCheck(ConsultingVO consulting);
	public int comCodeCheck(ConsultingVO consulting);
}
