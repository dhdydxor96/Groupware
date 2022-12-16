package kr.or.ddit.autumn.web.advice.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.vo.AdviceVO;

@Mapper
public interface AdviceAttatchDAO {
	public int insertAttatches(AdviceVO advice);
	public AttatchVO selectAttatch(int advNo);
	public int deleteAttatches(@Param("delAttNos") int[] delAttNos);
	public int deleteAttatch(int advNo);
}
