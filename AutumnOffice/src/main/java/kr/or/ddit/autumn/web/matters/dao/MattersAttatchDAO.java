package kr.or.ddit.autumn.web.matters.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.vo.AttatchVO;
import kr.or.ddit.autumn.web.vo.MattersVO;

@Mapper
public interface MattersAttatchDAO {
	public int insertAttatches(MattersVO matters);
	public AttatchVO selectAttatch(int matNo);
	public int deleteAttatches(@Param("delAttNos") int[] delAttNos);
	public int deleteAttatch(int matNo);
}
