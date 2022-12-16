package kr.or.ddit.autumn.web.advice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.autumn.web.vo.AdviceVO;
import kr.or.ddit.autumn.web.vo.PagingVO;

@Mapper
public interface AdviceDAO {
	public int insertAdvice(AdviceVO advice);
	public AdviceVO selectAdvice(@Param("advNo") int advNo);
	public List<AdviceVO> selectAdviceList(PagingVO<AdviceVO> pagingVO);
	public int updateAdvice(AdviceVO advice);
	public int deleteAdvice(AdviceVO advice);
	public int selectTotalRecord(PagingVO<AdviceVO> pagingVO);
}
